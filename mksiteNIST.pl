# $Id: mkcommon.pl $
# *created  "Fri Oct 18 11:46:42 2013" *by "Paul E. Black"
# *modified "Mon Oct  3 15:03:10 2016" *by "Paul E. Black"
#
# Site specific definitions and routines for format and indexing terms.
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

# $Log$
# Mon Oct  3 15:03:42 2016  Paul E. Black
# Update NIST access method to be https.  Add log line.
# 
#

# Note: the *name=\value is a Perl 5.0-ism which says name refers to 
# value, and the reference cannot be changed.  Equivalent to declaring
# the name to be a constant or immutable.

# - The local domain.  NIST uses this to determine if a link is outside,
#	and hence must be rewritten to use an exit script.  For example, 
#	http://gams.nist.gov/ does NOT need to be rewritten.
*LOCAL_DOMAIN	=\"nist.gov";

# - The URL to the main directory, for instance,
#	$URL_DIR/$WEBPAGE.html is the URL for the main page and
#	$URL_DIR/$OUT_DIR/termFile.html is the URL for termFile.trm
*URL_DIR	=\"https://www.nist.gov/dads";

# It seems logical that URL_DIR must be in the LOCAL_DOMAIN
# Note: rewriteHrefs (mkcommon.pl) depends on URL_DIR being in LOCAL_DOMAIN
die "URL_DIR ($URL_DIR) is not in LOCAL_DOMAIN ($LOCAL_DOMAIN)" 
					if $URL_DIR !~ "$LOCAL_DOMAIN/";


# rewrite a URL (href="...") to use the NIST "exit script" described at
#	http://inet.nist.gov/pao/howdoi/exit-script.cfm
sub rewriteOutsideURL {
    my($url) = $_[1];

    # Aug 2013 don't do anything.  The NIST exit script should be
    # implemented as a local jQuery script, according to the
    # above link
    return;

################################################################################
#
#	    NN      NN   OOOOOOOO   TTTTTTTTTT  EEEEEEEEEE
#	    NNN     NN  OOOOOOOOOO  TTTTTTTTTT  EEEEEEEEEE  
#	    NNNN    NN  OO      OO      TT      EE          
#	    NN NN   NN  OO      OO      TT      EE          
#	    NN  NN  NN  OO      OO      TT      EEEEE       
#	    NN  NN  NN  OO      OO      TT      EEEEE       
#	    NN   NN NN  OO      OO      TT      EE          
#	    NN    NNNN  OO      OO      TT      EE          
#	    NN     NNN  OOOOOOOOOO      TT      EEEEEEEEEE  
#	    NN      NN   OOOOOOOO       TT      EEEEEEEEEE
#
# Although the code below was taken from working code, it has NOT been tested 
# at all since it was factored out into this subroutine. Variable use, 
# modification of passed parameter, etc. might be all wrong. Treat this as 
# brand new code.
#
################################################################################

    # quote special cgi characters
    my($urlCGIQ) = $url;
    $urlCGIQ =~ s|%|%25|g;
    $urlCGIQ =~ s| |%20|g;
    $urlCGIQ =~ s|"|%22|g;
    $urlCGIQ =~ s|\#|%23|g;
    $urlCGIQ =~ s|&|%26|g;
    $urlCGIQ =~ s|\+|%2B|g;
    #$urlCGIQ =~ s|/|%2F|g; # not necessary
    $urlCGIQ =~ s|;|%3B|g;
    $urlCGIQ =~ s|=|%3D|g;
    $urlCGIQ =~ s|~|%7E|g;
    my($urlExit) = "\"http://www.nist.gov/nist-exit-script.cfm?url=$urlCGIQ\"";

    # quote special RE characters
    my $urlQ = quoteREpatterns("\"$url\"");

    #print "subs is /$urlQ/$urlExit/\n"; # for debugging
    $_[0] =~ s/$urlQ/$urlExit/;
}

# apparently require 'mksite.pl' in mkcommon.pl needs a true value. 
# I'm probably doing use/require wrong, but it works.
1;

# end of $Source: mksite.pl $
