#!/usr/bin/perl -w
# *created  "Wed Oct 16 11:38:59 2013" *by "Paul E. Black"
# *modified "Mon Oct 29 13:53:18 2018" *by "Paul E. Black"
#
# Rewrite global macros in the given file.  Output on stdout
#
#------------------------------------------------------------------------

$useMsg="usage: macroReplace.pl [--help] file";
$minOperands = 1;
$maxOperands = 1;

#------------------------------------------------------------------------
#
# This software was developed at the National Institute of Standards 
# and Technology by employees of the Federal Government in the course 
# of their official duties.  Pursuant to title 17 Section 105 of the 
# United States Code this software is not subject to copyright 
# protection and is in the public domain. 
# 
# We would appreciate acknowledgement if the software is used.
#
# Paul E. Black paul.black@nist.gov
#
#------------------------------------------------------------------------

# CONFIGURATION SECTION:
require './mkcommon.pl';

#------------------------------------------------------------------------------
#       Command line handling
#------------------------------------------------------------------------------

while ($#ARGV >= 0) {
    if ($ARGV[0] =~ /^--?h(e(lp?)?)?/) {
        print "$useMsg\n";
        print "    where\n";
        print "\t--help    Print this message and exit\n";
        print "\t--        End of options\n";
        print "    Rewrite global macros in the given file.  Output on stdout\n";
        exit 0;
    } elsif ($ARGV[0] eq "--") {
        shift;
    } elsif ($ARGV[0] =~ /^-/) {
        print "unknown option: $ARGV[0]\n";
        print "$useMsg\n";
        exit 1;
    } else {
        # end of options
        last;
    }
}

$numberOfOperands = 1 + $#ARGV; # - $optind
if ($numberOfOperands < $minOperands || $maxOperands < $numberOfOperands) {
    print "Wrong number of operands\n";
    print "$useMsg\n";
    die;
}

# name of file to read from
$infile = $ARGV[0];

&concatenate("$infile", STDOUT);

exit;

# end of $Source$
