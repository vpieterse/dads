# $Id: mkcommon.pl,v 1.3 2001/07/03 15:21:13 black Exp $
# *created  "Tue Apr  3 15:51:02 2001" *by "Paul E. Black"
# *modified "Tue Jul  3 11:07:35 2001" *by "Paul E. Black"
#
# Common definitions for format and indexing terms for web pages.
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

# CONFIGURATION SECTION:
# set the following appropriately

# - The file system path of the web pages.
$WEB_DIR	="Target";
#$WEB_DIR	="TargetExt";
# - The URL to the main directory, that is,
#	$URL_DIR/$WEBPAGE.html is the URL for the main page and
#	$URL_DIR/$OUT_DIR/termFile.html is the URL for termFile.trm
#$URL_DIR	="http://hissa.nist.gov/dads";
$URL_DIR	="http://www.nist.gov/dads";

# Note: the *name=\value is a Perl 5.0-ism which says name refers to 
# value, and the reference cannot be changed.  Equivalent to declaring
# the name to be a constant or immutable.

# - The path of the directory which has term files.
*TERMS_DIR=\"Terms";
# - The extension of term files (.trm for now).
*TERM_EXT =\"trm";
# - The (path) name of file with the authors' initials, name, ref., etc. file
*AUTHORS  =\"authors.data";
# - The (path) name of file with the areas into which entries are classified
*AREAS	  =\"areas.data";
# - The (path) name of file with the admissible types of the entries
*TYPES	  =\"types.data";
# - The (path) name of the file with PERL substitutions to change LaTeX 
#	to the target language, e.g., HTML
*LATEXREWRITES = \"latex2html.data";
# - The path of the directory where term pages go, that is,
#	$WEB_DIR/$OUT_DIR/termFile.html is the path for termFile.trm
*OUT_DIR  =\"HTML";
# - The name of final (combined or main) web page, less extension 
#	(.html).  The page is written to $WEB_DIR/$WEBPAGE.html
*WEBPAGE  =\"terms";
# - Name of the main web page with extension
*MAINPAGE =\"$WEBPAGE.html";

#------------------------------------------------------------------------
#
# you should not have to edit anything below this
#
#------------------------------------------------------------------------

# defined entry properties
%properties = (
	NAME	=> 1,
	TYPE	=> 1,
	AREA	=> 1,
	DEFN	=> 1,
	FORML	=> 1,
	AKA	=> 1,
	WEB	=> 1,
	XREFS	=> 1,
	BIB	=> 1,
	NOTES	=> 1,
	AUTHOR	=> 1,
	IMPL	=> 1,
	LINKS	=> 1
);

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
    if ($_[0] =~ /\$/) {
	# it has a dollar sign, so it is probably a LaTeX expression
	# print "Start : $_[0]\n";
	for $onesubs (@latexRewrites) {
	    #do {print "Before: $_[0]\n";}
	    1 while eval "\$_[0] =~ $onesubs";
	    # print "After : $_[0]\n";
	}

	# remove all $...$ brackets
	$_[0] =~ s/\$(.*?[^\\])\$/$1/g;
	# print "Final : $_[0]\n";
    }
}

#------------------------------------------------------------------------
#
# Step I: read initialization and config files
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
		if (!($replace eq '"' || $replace eq ')' || $replace eq '}')) {
		    # pad everything but left-closers with a space so
		    # things like $s\in T$ look right
		    # HTML compresses spaces, so $s \in T$ looks right, too
		    $replace = " $replace";
		}
		$replace = quoteREpatterns($replace);
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
# Step II: read term entries
#
#------------------------------------------------------------------------

sub readTermEntries {
    print STDERR "Reading terms" if ($verbose);

    # Step IIa: get a list of all term entry files
    @entries=`ls $TERMS_DIR/[A-Za-z]*.$TERM_EXT`;

    #print @entries;

    # count the number of entries read
    $numEntriesRead = 0;

    # Step IIb: read each entry file and save the properties
    while ($entryFile = shift @entries) {
	undef %thisEntry; # make sure nothing is left over
	my($thisEntry) = {};

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
	    chop;
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

	# save the base of the file name (to create a parallel HTML page)
	($thisEntry{BASEFILENM}) = ($entryFile =~ m|.*/([^.]*)|o);

	# if no NAME given, make one from the file name
	if (! defined $thisEntry{NAME}) {
	    print "No entry NAME given in $entryFile\n";
	    # assign a default
	    ($thisEntry{NAME}) = ($thisEntry{BASEFILENM});
	} else {
	    if ($thisEntry{NAME} =~ / $/) {
		print "NAME <<$thisEntry{NAME}>> has a trailing blank in $entryFile\n";
	    }
	}

	# audit the entry
	if (defined $thisEntry{TYPE}) {
	    my($etype) = $thisEntry{TYPE};
	    if (! defined $types{$etype}) {
		print "Unknown TYPE $etype in $entryFile\n";
	    }
	}
	if (defined $thisEntry{AREA}) {
	    my($earea) = $thisEntry{AREA};
	    if (! defined $areas{$earea}) {
		print "Unknown AREA $earea in $entryFile\n";
	    }
	}
	if (defined $thisEntry{AUTHOR}) {
	    foreach $initials (split / *, */, $thisEntry{AUTHOR}) {
		if (! defined $authors{$initials}) {
		    print "Unknown AUTHOR $initials in $entryFile\n";
		}
	    }
	}

	# NAME (ename in other places) is original name, e.g.,
	#		BB$\alpha<sub>2</sub>$ tree
	# XNAME is name without LaTeX markers to lookup cross references.
	#		BB\alpha<sub>2</sub> tree
	# DNAME is display name, e.g.,
	#		BB<src img="alpha.gif"><sub>2</sub> tree
	# TNAME is plain-text name, e.g., without HTML or LaTeX markers.
	#		BBalpha2 tree
	# alphname HERE is name used to alphabetize, e.g.,
	#		BBALPHATWOTREE

	# save a version of the entry name without LaTeX markers for lookup
	($thisEntry{XNAME} = $thisEntry{NAME}) =~ s/\$([^\$]*)\$/$1/go;

	# save a rich display version of the entry name
	rewriteLatex($thisEntry{DNAME} = $thisEntry{NAME});

	# save a plain text version of the entry name, i.e., without HTML
	($tname = $thisEntry{NAME}) =~ s/<[^>]*>//go;
	$tname =~ s/\$([^\$]*)\$/$1/go;
	$tname =~ s/\\//go;
	($thisEntry{TNAME}) = $tname;

	# add this to an "index" for later sorting and printing
	my $alphname = $thisEntry{NAME};
	print STDERR "." if ($verbose); # progress indicator
	# index some numbers and symbols as words
	$alphname =~ s/\b0\b/zero/g;
	$alphname =~ s/\b1\b/one/g;
	$alphname =~ s/\b2\b/two/g;
	$alphname =~ s/\b3\b/three/g;
	$alphname =~ s/\b4\b/four/g;
	$alphname =~ s/[*]/star/go;
	$alphname =~ s/[+]/plus/go;
	# remove any embedded html
	$alphname =~ s/<[^>]*>//go;
	$startsWithSpecial = ($alphname =~ /^\$\\/);
	# make all letters upper case and remove any remaining non-letter
	$alphname =~ tr/A-Za-z\0-\377/A-ZA-Z/d;
	if ($startsWithSpecial) {
	    # prepend a space so names with special characters come first
	    $alphname = " $alphname";
	}
	# make sure entry name is unique
	while (defined $entries{$alphname}) {
	    $alphname .= "Z";
	}
	# save as a hash-of-hashes
	for $fld (keys %thisEntry) {
	    $entries{$alphname}{$fld} = $thisEntry{$fld};
	}

	#print "NAME is $thisEntry{NAME}\nTNAME is $thisEntry{TNAME}\n";
	#print "DNAME is $thisEntry{DNAME}\nalphname is $alphname\n";
	#print "XNAME is $thisEntry{XNAME}\n";
	# remember this entry to check cross references
	$entriesForXref{$thisEntry{XNAME}} = $alphname;
    }
    print STDERR "\n" if ($verbose);

    print "Read $numEntriesRead terms\n";
}

# end of $Source: /home/black/DADS/dads/RCS/mkcommon.pl,v $
