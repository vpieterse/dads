# $Id: mkcommon.pl,v 1.34 2013/08/23 13:18:35 black Exp $
# *created  "Tue Apr  3 15:51:02 2001" *by "Paul E. Black"
# *modified "Mon Oct 29 13:51:50 2018" *by "Paul E. Black"
#
# Common definitions and routines for format and indexing terms.
#
# This software was developed at the National Institute of Standards 
# and Technology by employees of the Federal Government in the course 
# of their official duties.  Pursuant to title 17 Section 105 of the 
# United States Code this software is not subject to copyright 
# protection and is in the public domain. 
# 
# We would appreciate acknowledgement if the software is used.
#
# Paul E. Black <paul.black@nist.gov> or <p.black@acm.org>
# http://hissa.nist.gov/~black/
#
#------------------------------------------------------------------------

# site-specific variables and routines are here
require './mksite.pl';

# CONFIGURATION SECTION:
# set the following appropriately

# Note: the *name=\value is a Perl 5.0-ism which says name refers to 
# value, and the reference cannot be changed.  Equivalent to declaring
# the name to be a constant or immutable.

# - The file system path of the web pages.
#$WEB_DIR	="TargetInternal";
$WEB_DIR	="Target";

#------------------------------------------------------------------------
#	Input files, directories, etc.
#------------------------------------------------------------------------

# - The path of the directory which has term files.
*TERMS_DIR=\"Terms";
# - The extension of term files (.trm for now).
*TERM_EXT =\"trm";
# - The directory with the .concl, .intro, etc. files
*PAGES    =\"Pages";
# - The (path) name of file with the authors' initials, name, ref., etc. file
*AUTHORS  =\"authors.data";
# - The (path) name of file with the areas into which entries are classified
*AREAS	  =\"areas.data";
# - The (path) name of file with the admissible types of the entries
*TYPES	  =\"types.data";
# - The (path) name of the file with PERL substitutions to change LaTeX 
#	to the target language, e.g., HTML
*LATEXREWRITES = \"latex2html.data";

#------------------------------------------------------------------------
#	Output files, directories, etc.
#------------------------------------------------------------------------

# - The path of the directory where term pages go, that is,
#	$WEB_DIR/$OUT_DIR/termFile.html is the path for termFile.trm
*OUT_DIR  =\"HTML";
# - The name of final (combined or main) web page, less extension 
#	(.html).  The page is written to $WEB_DIR/$WEBPAGE.html
#	It is made from $PAGES/$WEBPAGE.intro and .concl.
*WEBPAGE  =\"terms";
# - Name of the main web page with extension
*MAINPAGE =\"$WEBPAGE.html";
# - The path of the directory where index, reference, etc. pages go, 
#	e.g., $WEB_DIR/$OTHER/$AUTHPAGE.html is the path to authors page.
*OTHER    =\"Other";
# - Name of the contributors web page is $AUTHPAGE.html.
*AUTHPAGE =\"contrib";

#------------------------------------------------------------------------
#
# you should not have to edit anything below this
#
#------------------------------------------------------------------------

# properties accepted in entries
%properties = (
	NAME	=> 1,
	TYPE	=> 1,
	AREA	=> 1,
	DEFN	=> 1,
	FORML	=> 1,
	AKA	=> 1,
	WEB	=> 1,
	XREFS	=> 1,
	IMA	=> 1,	# Generalization ("I am a kind of ...")
	VARIANT	=> 1,	# Specialization ("... is a kind of me.")
	IMIN	=> 1,	# Aggregate parent ("I am a part of or used in ...")
	INME	=> 1,	# Aggregate child ("... is a part of or used in me.")
	BIB	=> 1,
	NOTES	=> 1,
	HISTORY	=> 1,	# Historical note
	AUTHOR	=> 1,
	IMPL	=> 1,
	LINKS	=> 1
);

# copy the file to the file handle, replacing variables as appropriate
# example: append the contents of $TEMP_FILE to $target
#	open(TARGET, "> $target");
#	&concatenate($TEMP_FILE, TARGET);
#	close(TARGET);
sub concatenate {
    my($filename, $handle) = @_;
    open(FHANDLE, "< $filename")
	|| die("Cannot open $filename\n");
    while (<FHANDLE>) {
	s/\$ROOTDIR/$URL_DIR/g;
	print $handle $_
    };
    close(FHANDLE);
}

# rename the existing page (topage) to be a backup, and rename the 
# new page (frompage) to be the existing page.  For instance, if
# there is page.html and newpage.html and we invoke
#	&backupMove("newpage.html", "page.html");
# we get page.html~ and page.html.
sub backupMove {
    my $frompage = $_[0];
    my $topage = $_[1];
    my $backuppage = "$topage~";

    # backup the existing page
    if (-e $topage) {
	unlink($backuppage);
	link($topage, $backuppage)
	    || print STDERR "Warning: cannot create backup page $backuppage\n";
	unlink($topage)
	    || print STDERR "Warning: cannot unlink page $topage\n";
    }

    # rename the temporary file
    link($frompage, $topage)
	|| die("Cannot link temporary file $frompage to $topage, stopped");
    unlink($frompage);
}

# "quote" characters which are special in regular expression patterns
sub quoteREpatterns ($) {
    my $expr = shift;

    $expr =~ s|\\|\\\\|g;
    $expr =~ s/\|/\\\|/g;
    $expr =~ s|\(|\\(|g;
    $expr =~ s|\)|\\)|g;
    $expr =~ s|\[|\\[|g;
    $expr =~ s|\{|\\{|g;
    $expr =~ s|\^|\\^|g;
    $expr =~ s|\$|\\\$|g;
    $expr =~ s|\*|\\*|g;
    $expr =~ s|\+|\\+|g;
    $expr =~ s|\?|\\?|g;
    $expr =~ s|\.|\\.|g;
    # we'll use / as separator, so it is special for us, too
    $expr =~ s|/|\\/|g;

    $expr;
}

# Rewrite any LaTeX expressions with those in latexRewrites
sub rewriteLatex ($) {
    # special hardwired conversion: rewrite `` and '' into "
    # this Latex applies *outside* math expressions
    $_[0] =~ s/``|''/"/go;

    if ($_[0] =~ /\$/) {
	# it has a dollar sign, so it is probably a LaTeX expression
	# print "Start : $_[0]\n";
	for $onesubs (@latexRewrites) {
	    #print "Before: $_[0]\n";
	    #print "Substitution: $onsubs \n";
	    1 while eval "\$_[0] =~ $onesubs";
	    # print "After : $_[0]\n";
	}

	# remove all $...$ brackets
	$_[0] =~ s/\$(.*?[^\\])\$/$1/g;
	# print "Final : $_[0]\n";
    }
}

# Rewrite anchors (<a href= ...>) as needed
sub rewriteHrefs {
    # The most general regex for anchors is <a [^>]+> however we have
    # <a href="http://www.jstor.org/sici? ... <282:GOPBAT>2.0.CO;2-E">
    # which has close angle (>) within double quotes ("). The [^T] keeps
    # the first regex from matching incorrectly, and the second regex
    # matches that link (and most other links).
    foreach $anchor ($_[0] =~ m/(<a [^>]+[^T]>|<a href="[^"]*">)/ig) {
	# ... in case of other links with embedded angle brackets (>)
	print STDERR "\nAnchor with unmatched \"\n    $anchor\n" if $anchor =~ /^[^"]+("[^"]+"[^"]*)*"[^"]*$/;

	# pull out the href string
	$anchor =~ /href="([^"]+)"/;
	$url = $1;

	# $anchor is the whole anchor, e.g., 
	#	<a  href="http://www.merlyn.demon.co.uk/zeller-c.htm">
	#	<a href="../terms.html#GG98">
	#	<a href="mailto:Jnwarfield@aol.com">
	#	<a href="ftp://ftp.cs.cmu.edu/user/sleator/splaying/">
	# $url is the string in the href double quotes, e.g.,
	#	http://www.merlyn.demon.co.uk/zeller-c.htm
	#	../terms.html#GG98
	#	mailto:Jnwarfield@aol.com
	#	ftp://ftp.cs.cmu.edu/user/sleator/splaying/

	#print "Working on $anchor\n"; # for debugging

	# skip all mailto: anchors
	next if $url =~ /^mailto:/;

	# skip partly done curly bracket (e.g. {list}) references. 
	# These occur when there is an external reference, for instance
	# {..Wikipedia:Self-organising_heuristic}, which leads rewriteXrefs
	# to call this subroutine which processes the whole paragraph.
	next if $url =~/^#/;

	# if link is outside DADS, ...
	if ($url !~ $URL_DIR && $url !~ /^[.][.]/) {
	    #
	    #           Add target="_blank" to open in new window
	    #
	    # form the anchor to be rewritten - quote special RE characters
	    my $anchorQ = quoteREpatterns("$anchor");

	    # form the anchor with target... in it
	    my $anchorTarg = $anchor;
	    $anchorTarg =~ s/>$/ target="_blank">/;

	    #print "substitute is /$anchorQ/$anchorTarg/\n"; # for debugging
	    $_[0] =~ s/$anchorQ/$anchorTarg/;

	    # if link is outside local domain, ...
	    if ($url !~ $LOCAL_DOMAIN) {
		#print "\nFound $url\n"; # for debugging

		rewriteOutsideURL($_[0], $url);
	    }
	}
    }
}

#------------------------------------------------------------------------
#
#	Change a Unix date string, e.g.,
#	    Fri Dec 17 12:25:09 2004
#	    Thu Jun  2 12:13:29 2005
#	into day-month-year string, e.g.,
#	    17 December 2004
#	    2 June 2005
#
#------------------------------------------------------------------------

sub unixDateStringToDDMMMYYY($) {
    my $dateString = shift;

    # remove leading day-of-week
    $dateString =~ s/^(Sun|Mon|Tue|Wed|Thu|Fri|Sat) //;

    # remove time
    $dateString =~ s/ \d\d:\d\d:\d\d / /;

    # spell out month
    $dateString =~ s/^Jan /January /;
    $dateString =~ s/^Feb /February /;
    $dateString =~ s/^Mar /March /;
    $dateString =~ s/^Apr /April /;
    #$dateString =~ s/^May /May/;
    $dateString =~ s/^Jun /June /;
    $dateString =~ s/^Jul /July /;
    $dateString =~ s/^Aug /August /;
    $dateString =~ s/^Sep /September /;
    $dateString =~ s/^Oct /October /;
    $dateString =~ s/^Nov /November /;
    $dateString =~ s/^Dec /December /;

    # switch date and month
    $dateString =~ s/^([A-Z][a-z]+) +(\d+) /$2 $1 /;

    $dateString;
}

#------------------------------------------------------------------------
#
#	Read initialization and config files
#
#------------------------------------------------------------------------

sub readConfigFiles {
    # Step Ia: read areas
    open(AREASFH, "< $AREAS")
	|| die("Cannot open areas file, $AREAS\n");

    while (<AREASFH>) {
	next if (/^ *\#/o); # skip comment lines
	chop;

	# get abbreviation and print name
	local ($abbrev, $areaPrintName) = split /\t+/;
	$areas{$abbrev} = $areaPrintName;
    }

    close AREASFH;

    # Step Ib: read types
    open(TYPESFH, "< $TYPES")
	|| die("Cannot open types file, $TYPES\n");

    while (<TYPESFH>) {
	next if (/^ *\#/o); # skip comment lines
	chop;

	# get abbreviation and print name
	local ($abbrev, $areaPrintName) = split /\t+/;
	$types{$abbrev} = $areaPrintName;
    }

    close TYPESFH;

    # Step Ic: read authors and their initials
    open(AUTHRS, "< $AUTHORS")
	|| die("Cannot open authors file, $AUTHORS\n");

    while (<AUTHRS>) {
	next if (/^ *\#/o);
	# get initials ($1), name ($2), and optional e-mail, url, etc. ($3)
	/^([^\t]*)\t([^\t]*)\t?(.*)?/o;
	$authors{$1} = $2;
	$authemail{$1} = $3;
    }

    close AUTHRS;

    # Step Id: read LaTeX rewrite expressions
    open(REWRTS, "< $LATEXREWRITES")
	|| die("Cannot open LaTeX rewrites file, $LATEXREWRITES\n");

    while (<REWRTS>) {
	my ($pat, $replace);
	next if /^\s*\#/o || /^\s*$/o; # skip comment and blank lines
	SWITCH: {
	    if (/^(\S*\{.*)\$(.*\}\S*\{.*)\$(\S*\})\s+(.*)\$(.*)\$(.*)/o) {
		# replace $...$lpat{$mid1}$cpat{$mid2}$rpat...$
		# with    $...$lrepl$mid1$crepl$mid2$rrepl...$
		my ($leftpat, $centerpat, $rightpat,
				$leftreplace, $centerreplace, $rightreplace);
		$leftpat  = quoteREpatterns($1);
		$centerpat= quoteREpatterns($2);
		$rightpat = quoteREpatterns($3);
		$pat = "$leftpat(.*?)$centerpat(.*?)$rightpat";
		$leftreplace  = quoteREpatterns($4);
		$centerreplace= quoteREpatterns($5);
		$rightreplace = quoteREpatterns($6);
		$replace = " $leftreplace\$2$centerreplace\$3$rightreplace";
		# print "REPLACE $pat\n";
		# print "with    $replace\n";
		last SWITCH;
	    }
	    if (/^(\S*\{.*)\$(\S*\})\s+(.*)\$(.*)/o) {
		# replace $...$lpat{$mid$rpat}...$
		# with    $...$lrepl$mid$rrepl...$
		my ($leftpat, $rightpat, $leftreplace, $rightreplace);
		$leftpat  = quoteREpatterns($1);
		$rightpat = quoteREpatterns($2);
		$pat = "$leftpat(.*?)$rightpat";
		$leftreplace  = quoteREpatterns($3);
		$rightreplace = quoteREpatterns($4);
		$replace = " $leftreplace\$2$rightreplace";
		# print "REPLACE $pat\n";
		# print "with    $replace\n";
		last SWITCH;
	    }
	    if (/^(\S*\{.*)\$(\S*\})\s+(.*)/o) {
		# replace $...$lpat{$mid$rpat}...$
		# with    $...$replace...$
		my ($leftpat, $rightpat);
		$leftpat  = quoteREpatterns($1);
		$rightpat = quoteREpatterns($2);
		$pat = "$leftpat(.*?)$rightpat";
		$replace  = quoteREpatterns($3);
		$replace = " $replace";
		# print "REPLACE $pat\n";
		# print "with    $replace\n";
		last SWITCH;
	    }
	    if (/^(\S+)\s*(.*)/o) {
		$pat = quoteREpatterns($1);
		$replace = $2;
		# use absolute, not relative, path for images, since images 
		# like sim.gif appear in names at top level and in entries
		$replace =~ s|"Images|"$URL_DIR/Images|g;
		$replace = quoteREpatterns($replace);
		# print "REPLACE $pat\n";
		# print "with    $replace\n";
		last SWITCH;
	    }
	    {
		print "latex rewrite line ignored: $_";
		next;
	    }
	}

	# rewrite as a substitution within $'s
	# this means: replace $...$pat...$ with $...$replace...$
	push @latexRewrites,
		"s/(\\\$[^\\\$]*)$pat(?=.*?\\\$)/\$1$replace/g";
	# print "full: $latexRewrites[-1]\n";
    }

    close REWRTS;
}


#------------------------------------------------------------------------
#
#	Read term entries and add them to internal dictionary
#
#------------------------------------------------------------------------

sub addToDictionary (\%) {
    undef %entry; # make sure nothing is left over
    my(%entry, $entryRef);
    $entryRef = shift;
    %entry = %$entryRef;

    if (! defined $entry{NAME}) {
	print "\nSomething is very wrong: no NAME defined\n";
	for $fld (keys %entry) {
	    print "\$entry\{$fld} = $entry{$fld}\n";
	}

	exit;
    }

    # audit the entry
    if ($entry{NAME} =~ / $/) {
	print "NAME <<$entry{NAME}>> has a trailing blank in $entryFile\n";
    }
    if (defined $entry{TYPE}) {
	my($etype) = $entry{TYPE};
	if (! defined $types{$etype}) {
	    print "Unknown TYPE $etype in $entryFile\n";
	}
    }
    if (defined $entry{AREA}) {
	my($earea) = $entry{AREA};
	if (! defined $areas{$earea}) {
	    print "Unknown AREA $earea in $entryFile\n";
	}
    }
    if (defined $entry{AUTHOR}) {
	foreach $initials (split / *, */, $entry{AUTHOR}) {
	    if (! defined $authors{$initials}) {
		print "Unknown AUTHOR $initials in $entryFile\n";
	    }
	}
    }
    if (defined $entry{XREFS} && $entry{XREFS} =~ /[. ]$/) {
	print "XREFS has a funny trailing character in $entryFile\n";
    }
    if (defined $entry{IMA} && $entry{IMA} =~ /[. ]$/) {
	print "IMA has a funny trailing character in $entryFile\n";
    }
    if (defined $entry{VARIANT} && $entry{VARIANT} =~ /[. ]$/) {
	print "VARIANT has a funny trailing character in $entryFile\n";
    }
    if (defined $entry{IMIN} && $entry{IMIN} =~ /[. ]$/) {
	print "IMIN has a funny trailing character in $entryFile\n";
    }
    if (defined $entry{INME} && $entry{INME} =~ /[. ]$/) {
	print "INME has a funny trailing character in $entryFile\n";
    }

    # NAME (ename in other places) is original name, e.g.,
    #		BB$\alpha<sub>2</sub>$ tree
    #		K&ouml;nigsberg bridges
    # XNAME is name without LaTeX markers to lookup cross references.
    #		BB\alpha<sub>2</sub> tree
    # DNAME is display name, e.g.,
    #		BB<src img="alpha.gif"><sub>2</sub> tree
    # TNAME is plain-text name, e.g., without HTML or LaTeX markers.
    #		BBalpha2 tree
    #		K&ouml;nigsberg bridges
    # alphaName is name used to alphabetize, e.g.,
    #		BBALPHATWOTREE
    #		bTHETA (where b is a blank)
    #		KOENIGSBERGBRIDGES

    # save a version of the entry name without LaTeX markers for lookup
    ($entry{XNAME} = $entry{NAME}) =~ s/\$([^\$]*)\$/$1/go;

    # save a rich display version of the entry name
    rewriteLatex($entry{DNAME} = $entry{NAME});
    # used in main index for AKA's:
    #		$dname See: <a ..>$srcdname</a>
    if (defined $entry{SRCNAME}) {
	rewriteLatex($entry{SRCDNAME} = $entry{SRCNAME});
	#print "\nsource dname for $entry{DNAME} is $entry{SRCDNAME}\n";
    }

    # save a plain text version of the entry name, i.e., without HTML
    my $tname;
    ($tname = $entry{NAME}) =~ s/<[^>]*>//go;
    $tname =~ s/\$([^\$]*)\$/$1/go;
    $tname =~ s/\\//go;
    ($entry{TNAME}) = $tname;

    # figure out the name to alphabetize this with
    my $alphaName = $entry{NAME};
    print STDERR "." if ($verbose); # progress indicator
    # index some numbers and symbols as words
    $alphaName =~ s/\b0\b/zero/g;
    $alphaName =~ s/\b1\b/one/g;
    $alphaName =~ s/\b2\b/two/g;
    $alphaName =~ s/\b3\b/three/g;
    $alphaName =~ s/\b4\b/four/g;
    $alphaName =~ s/\b8\b/eight/g;
    $alphaName =~ s/[*]/star/go;
    $alphaName =~ s/[+]/plus/go;
    # remove any embedded html
    $alphaName =~ s/<[^>]*>//go;
    # replace special characters, e.g., &ouml; with oe
    $alphaName =~ s/&(.)uml;/$1e/g;
    # remember if this starts with a special character
    $startsWithSpecial = ($alphaName =~ /^\$\\/);
    # make all letters upper case and remove any remaining non-letter
    $alphaName =~ tr/A-Za-z\0-\377/A-ZA-Z/d;
    if ($startsWithSpecial) {
	# prepend a space so names with special characters come first
	$alphaName = " $alphaName";
    }
    # make sure entry name is unique.  (Use "A" for suffix to sort close to
    # word with no suffix, e.g., TOUR and TOURA.)  Actual (display name) 
    # duplicates are reported when the index is written.
    while (defined $entries{$alphaName}) {
	$alphaName .= "A";
    }

    #print "NAME is $entry{NAME}\n"
    #print "XNAME is $entry{XNAME}\n";
    #print "DNAME is $entry{DNAME}\n";
    #print "TNAME is $entry{TNAME}\n";
    #print "alphaName is $alphaName\n";

    # assign an HTML file name if necessary (for AKA and WEB)
    if (! defined $entry{FILENM}) {
	$entry{FILENM} = $tname;

	# change all-caps words to all-lower case
	if ($entry{FILENM} =~ /^[A-Z]+$/) {
	    $entry{FILENM} =~ tr/A-Z/a-z/;
	}

	# capitalize words following spaces (change "..se na.." to "..seNa..")
	while ($entry{FILENM} =~ /( [a-z])/) {
	    my $patrn = $1;
	    (my $subst = $patrn) =~ tr/a-z/A-Z/;
	    $subst =~ s/ //;
	    #print "\n$entry{FILENM}\n";	# before
	    $entry{FILENM} =~ s/$patrn/$subst/g;
	    #print "$entry{FILENM}\n";		# after
	}

	# remove dashes, character markers, and remaining spaces
	$entry{FILENM} =~ s/[^a-zA-Z0-9]//go;

	# try to make HTML file name unique.  Actual (display name)
	# duplicates are reported when the index is written.
	while (-e "$TERMS_DIR/$entry{FILENM}.trm") {
	    $entry{FILENM} .= "I";
	}
    }

    if ($entry{ENTCLASS} !~ /WEB|AKA/) {
	# remember this entry to find cross references
	$entriesForXref{$entry{XNAME}} = $alphaName;
    }

    # save as a hash-of-hashes
    for $fld (keys %entry) {
	$entries{$alphaName}{$fld} = $entry{$fld};
    }

    $totalEntries++;
}

sub readTermEntries {
    print STDERR "Reading terms" if ($verbose);

    # Step IIa: get a list of all term entry files
    @entries=`ls $TERMS_DIR/[A-Za-z]*.$TERM_EXT`;

    #print @entries;

    # the number of entries read
    my $numEntriesRead = 0;
    # the number of entries in the index.  This adds AKA's, but not WEB's.
    $numEntriesInIndex = 0;
    # total entries in the dictionary.  This adds WEB's.
    $totalEntries = 0;

    # Step IIb: read each entry file and save the properties
    while ($entryFile = shift @entries) {
	undef %thisEntry; # make sure nothing is left over
	my($thisEntry) = {};
	$thisEntry{ENTCLASS} = "FILE";

	chop $entryFile;

	open(ENTRY, "< $entryFile")
		|| print STDERR "Cannot open $entryFile\n" && next;

	while (<ENTRY>) {
	    if (/modified "([^"]+)"/) {
		$thisEntry{MODIFIED} = $1;
	    }

	    next if (/^ *\#/o); # skip comments

	    # look for property headers
	    if (s/^@([^=]*)=//o) {
		$prop=$1;
	    }
	    s/\n$//; # can't "chop" in case file doesn't end with new line
	    next if /^$/; # ignore empty lines
	    if (! defined $properties{$prop}) {
		print "Unknown property $prop in $entryFile\n";
	    }
	    if (defined $thisEntry{$prop}) {
		$thisEntry{$prop} .= " "; # space after existing stuff
	    }
	    $thisEntry{$prop} .= $_; # save the info
	}

	close ENTRY;

	$numEntriesRead++;

	# save the base of the file name (FILENM is used to create an HTML 
	# page, and SRCFILE is used to check for modification)
	($thisEntry{FILENM}) = ($entryFile =~ m|.*/([^.]*)|o);
	$thisEntry{SRCFILE} = $thisEntry{FILENM};

	# add entries for AKA (Also Known As) names
	if (defined $thisEntry{AKA}) {
	    my($ealiases) = $thisEntry{AKA};
	    #print "$thisEntry{NAME} is also known as";

	    if ($ealiases =~ /[., ]$/) {
		print "\nAKA <<$ealiases>> has a funny trailing character in $entryFile\n";
	    }

	    if ($ealiases =~ /[{}]/) {
		print "\nAKA <<$ealiases>> has a funny character in $entryFile\n";
	    }

	    foreach $aka (split /^ +| *, */, $ealiases) {
		next if ($aka eq ""); # above RE may start with a null split

		#
		# create entry in database for this
		#

		undef %akaEntry; # make sure nothing is left over
		my $akaEntry = {};
		$akaEntry{NAME} = $aka;
		# SRCNAME is the name of the original entry and is converted
		# to a display name, SRCDNAME, in addToDictionary, which is
		# used as a main index entry:
		#	$dname See: <a href=$pg>$SRCDNAME</a>
		$akaEntry{SRCNAME} = $thisEntry{NAME};
		$akaEntry{DEFN} = "See \{$thisEntry{NAME}}.";
		$akaEntry{SRCFILE} = $thisEntry{SRCFILE};
		$akaEntry{ENTCLASS} = "AKA";
		if (defined $thisEntry{TYPE}) {
		    $akaEntry{TYPE} = $thisEntry{TYPE};
		}
		if (defined $thisEntry{AREA}) {
		    $akaEntry{AREA} = $thisEntry{AREA};
		}
		if (defined $thisEntry{MODIFIED}) {
		    $akaEntry{MODIFIED} = $thisEntry{MODIFIED};
		}
		if (defined $thisEntry{AUTHOR}) {
		    $akaEntry{AUTHOR} = $thisEntry{AUTHOR};
		}

		$numEntriesInIndex++;
		addToDictionary %akaEntry;
	    }
	    #print "\n";
	}

	# add entries for WEB variants
	if (defined $thisEntry{WEB}) {
	    my($webaliases) = $thisEntry{WEB};
	    #print "$thisEntry{NAME} has variant(s) for web of";

	    if ($webaliases =~ /[., ]$/) {
		print "\nWEB <<$webaliases>> has a funny trailing character in $entryFile\n";
	    }

	    foreach $webvar (split /^ *{?|}?, *{?|}? *$/, $webaliases) {
		next if ($webvar eq ""); # above RE may start with a null split
		#print " '$webvar'"; # for debugging

		#
		# create entry in database for this
		#

		undef %webEntry; # make sure nothing is left over
		my $webEntry = {};
		$webEntry{NAME} = $webvar;
		$webEntry{DEFN} = "See \{$thisEntry{NAME}}.";
		$webEntry{SRCFILE} = $thisEntry{SRCFILE};
		$webEntry{ENTCLASS} = "WEB";
		if (defined $thisEntry{TYPE}) {
		    $webEntry{TYPE} = $thisEntry{TYPE};
		}
		if (defined $thisEntry{AREA}) {
		    $webEntry{AREA} = $thisEntry{AREA};
		}
		if (defined $thisEntry{MODIFIED}) {
		    $webEntry{MODIFIED} = $thisEntry{MODIFIED};
		}
		if (defined $thisEntry{AUTHOR}) {
		    $webEntry{AUTHOR} = $thisEntry{AUTHOR};
		}

		addToDictionary %webEntry;
	    }
	    #print "\n";
	}

	$numEntriesInIndex++;
	addToDictionary %thisEntry;
    }
    print STDERR "\n" if ($verbose);

    print "$numEntriesRead terms read.  $numEntriesInIndex in main indices.  $totalEntries terms total.\n";
}

# end of $Source: /home/black/DADS/RCS/mkcommon.pl,v $
