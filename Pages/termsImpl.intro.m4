dnl *created  "Wed Nov 18 08:51:04 1998" *by "Paul E. Black"
dnl *modified "Tue Sep  2 08:24:19 2014" *by "Paul E. Black"
dnl
dnl $Log$
dnl Tue Sep  2 08:56:48 2014  Paul E. Black
dnl Change www.cs.sunysb.edu to www3.cs.stonybrook.edu for Stony Brook URL
dnl 
dnl Tue May  6 13:46:29 2014  Paul E. Black
dnl Remove second include of bits Fix Defn.  Put first include on its own line.
dnl 
dnl Mon Apr 21 12:34:04 2014  Paul E. Black
dnl Replace header tags used for formatting with format tags.  Note:
dnl format tags should be in CSS.  Improve the English a bit ("that"
dnl instead of "which").
dnl 
dnl Fri Nov  8 13:56:49 2013  Paul E. Black
dnl Include bits of required HTML <head> stuff.  Add $Log$ and end of file lines.
dnl 
<!DOCTYPE HTML PUBLIC "-//IETF//DTD W3 HTML 2.0//EN">
<html lang="en-US">
<head>

<title>Terms and Definitions with Implementation Links</title>
<meta name="description"
  content="Links to implementations of algorithms and data structures"> 
<!-- turn off Microsoft's added smart tags -->
<meta name="MSSmartTagsPreventParsing" content="TRUE">
<link rel="stylesheet" type="text/css" href="$ROOTDIR/dads.css">
include(`Pages/bitsReqHeadStuff.m4')
</head>
<body>

<center> <h1><a href="terms.html">Algorithms and Data Structures</a></h1> </center>
<center> <strong>that have</strong> </center>
<center> <h1>Links to Implementations</h1> </center>

<hr>

<p>
This is the web page of terms with definitions that have links to
implementations with source code.  The language is in
parentheses. We also list all 
<a href="termsType.html">entries by type</a>, for instance, whether it
is an algorithm, a definition, a problem, or a data structure,
and
<a href="termsArea.html">entries by area</a>, for instance, graphs,
trees, sorting, etc.
</p>

<p>
Don't use this site to cheat.  Teachers, contact us if we can help.
</p>

<p>
We need people to contribute. 
include(`Pages/bitsFixDefn.m4')
You are welcome to make suggestions to expand and improve the DADS.
</p>

<p>
By selecting almost any of these links, you will be leaving the DADS
webspace.  We provided these links because they may have
information of interest to you.  No inferences should be
drawn because some sites are referenced, or not, from this
page. There may be other web sites that are more appropriate for your
purpose.  We do not necessarily endorse the views expressed, or
concur with the facts presented on these sites.
</p>

<p>
A great source of implementations, organized by area and reviewed for
quality, is the
<a href="http://www3.cs.stonybrook.edu/~algorith/">Stony Brook
Algorithm Repository</a>.  A great source of implementations of
mathematical functions is the NIST
<a href="http://gams.nist.gov/">Guide to Available Mathematical
Software</a> or GAMS.
</p>

<p>
Java is a trademark of Sun Microsystems, Inc.
</p>

<!-- this is joined with indexes and a conclusion to make a complete page -->
<!-- end of termsImpl.intro -->
dnl end of $Source$
