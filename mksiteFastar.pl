# $Id: mkcommon.pl $
# *created  "Fri Oct 18 12:54:21 2013" *by "Paul E. Black"
# *modified "Mon Jun  6 08:41:00 2016" *by "Paul E. Black"
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
# Mon Jun  6 08:49:40 2016  Paul E. Black
# update FASTAR URL
# 

# Note: the *name=\value is a Perl 5.0-ism which says name refers to 
# value, and the reference cannot be changed.  Equivalent to declaring
# the name to be a constant or immutable.

# - The local domain.  NIST uses this to determine if a link is outside,
#	and hence must be rewritten to use an exit script.  For example, 
#	http://gams.nist.gov/ does NOT need to be rewritten.
*LOCAL_DOMAIN	=\"fastar.org";

# - The URL to the main directory, for instance,
#	$URL_DIR/$WEBPAGE.html is the URL for the main page and
#	$URL_DIR/$OUT_DIR/termFile.html is the URL for termFile.trm
*URL_DIR	=\"http://fastar.org/dads";

# It seems logical that URL_DIR must be in the LOCAL_DOMAIN
# Note: rewriteHrefs (mkcommon.pl) depends on URL_DIR being in LOCAL_DOMAIN
die "URL_DIR ($URL_DIR) is not in LOCAL_DOMAIN ($LOCAL_DOMAIN)" 
					if $URL_DIR !~ "$LOCAL_DOMAIN/";


# rewrite a URL (href="...")
# no change needed for the Fastar site
sub rewriteOutsideURL {
    # EMPTY BODY
}

# apparently require 'mksite.pl' in mkcommon.pl needs a true value. 
# I'm probably doing use/require wrong, but it works.
1;

# end of $Source: mksite.pl $
