dnl *created  "Thu Jan 17 10:05:27 2002" *by "Paul E. Black"
dnl *modified "Fri Nov  8 13:26:23 2013" *by "Paul E. Black"
dnl
dnl $Log: ui.intro.m4,v $
dnl Fri Nov  8 13:57:24 2013  Paul E. Black
dnl Include bits of required HTML <head> stuff.  Add end of file line.
dnl 
dnl Revision 2.0  Fri Jul 13 14:16:29 SAST 2012  vreda
dnl Remove NIST exit script and use more bit files
dnl 
dnl Revision  Tue Dec  6 15:30:59 2011  black
dnl use another file for NIST exit
<!DOCTYPE HTML PUBLIC "-//IETF//DTD W3 HTML 2.0//EN">
<html lang="en-US">
<head>

<title>DADS Unified Index</title>
<link rel="stylesheet" type="text/css" href="$ROOTDIR/dads.css">
include(`Pages/bitsReqHeadStuff.m4')
</head>
<body>

include(`Pages/bitsImageLogos.m4')
 
<center>
<h1>Unified Index</h1>
<h3>of the</h3>
<h1>Dictionary of Algorithms and Data Structures</h1> </center>

<p>
This is a unified index of <strong>all</strong> terms in the
Dictionary, including many created only for web searches.  For
instance, TSP is listed under "traveling salesman" (one "l" in
"traveling"), the American spelling, and "travelling salesman" (two
"l"s), the British spelling.  Other variants are "quick sort" and
"quicksort", and "sort" and "sorting algorithm".
</p>

<p>
Doubly linked list and its synonyms appears four times: as
doubly linked list, symmetrically linked list, two-way linked list,
and two-way list.  The last two would occur close to each other in the 
<a href="terms.html">main index</a>, so "two-way list" is only in
this index, which is for <a
href="http://www.robotstxt.org/faq.html">robots</a>
to find and index.
</p>

<p>
This page was never intended for human use.  If you find a use for
this page and have a suggestion to make it more usable, don't hesitate to contact us. include(`Pages/bitsFixDefn.m4')
</p>

<hr>

<!-- this is joined with the entries and a conclusion to make a
	complete page -->
<!-- end of ui.intro -->
dnl end of $Source$
