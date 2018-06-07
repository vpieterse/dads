dnl $Id: twolevelExplain.html.m4,v 1.21 2011/12/06 20:59:23 black Exp $
dnl *created  "Thu Oct 26 11:47:46 2000" *by "Paul E. Black"
dnl *modified "Mon May 21 08:28:55 2018" *by "Paul E. Black"
dnl
dnl $Log: twolevelExplain.html.m4,v $
dnl Thu Jun  7 13:05:03 2018  Paul E. Black
dnl Update URL for anybrowser campaign
dnl 
dnl Tue May  6 13:47:20 2014  Paul E. Black
dnl Include bits Fix Defn, to explain how to make suggestions, explicitly
dnl here, instead of implicitly through bits Demarcate.
dnl 
dnl Fri Nov  8 13:47:57 2013  Paul E. Black
dnl Include bits of required HTML <head> stuff.  Add end of file line.
dnl 
dnl Revision 2.0  Fri Jul 13 11:11:32 SAST 2012  vreda
dnl Remove NIST exit script bit, and used other bits for people
dnl >>>>> The number of terms in DADS might also be replaced by a bit.
dnl
dnl Revision 1.21  2011/12/06 20:59:23  black
dnl Include new NIST exit script bit, instead of hardcoding the URL
dnl
dnl Revision 1.20  2010/05/03 16:31:36  black
dnl move privacy policy link to bitsNISTis.m4.  Add RCS Id, Log, and
dnl Source keywords.  Make created and modified lines m4 comments, instead
dnl of HTML comments, so that they no longer appear in the HTML at all.
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en-US">
<head>
<title>Two-level Index</title>
<!-- turn off Microsoft's added smart tags -->
<meta name="MSSmartTagsPreventParsing" content="TRUE">
<link rel="stylesheet" type="text/css" href="$ROOTDIR/dads.css">
include(`Pages/bitsReqHeadStuff.m4')
</head>
<body>

include(`Pages/bitsImageLogos.m4')
<center><h1>Explanation</h1></center>
<center><h2>of the</h2></center>
<center><h1>Two-Level Index</h1></center>
<center><h2>of the</h2></center>
<center><h1>Dictionary of Algorithms and Data Structures</h1></center>

<p>
This web site is hosted by
include(`Pages/bitsHostedBy.m4')
</p>

<p>
This site is a dictionary of algorithms, algorithmic techniques, 
data structures, archetypal problems, and related definitions.
The <a href="terms.html">main page</a> includes a description
of what subjects are and are not included,
entries for about 1400 terms, and lists of references.
However it is a lot to download if you have a slow
connection or just want to look up one term.  The two-column layout of
the index takes a noticeable amount of time to render, too.
</p>

<p>
The two-level index is very brief.  The first index has links to
secondary index pages, and those link to
the entries.  This two-level approach trades a little less
convenience (two clicks) for a download of about 1/20th the size.
</p>

<p>
There are additional index pages which list entries by 
<a href="termsArea.html">area</a>, for
instance, sorting, searching, or graphs, and by
<a href="termsType.html">type</a>, for example, algorithms or data
structures.
A page also lists all
<a href="termsImpl.html">implementations</a>.
We thank
<a href="Other/contrib.html">those who contributed definitions</a>
as well as many others who offered suggestions and corrections.
</p>

<p>
include(`Pages/bitsDemarcate.m4')
include(`Pages/bitsFixDefn.m4')
</p>

<p>
If you don't find a term with a leading variable, such as
<em>n</em>-way, <em>m</em>-dimensional, or <em>p</em>-branching, look
under <em>k</em>-.
</p>

<hr>
include(`Pages/bitsSearch.m4')
<hr>

<center>
<p>
<a href="https://anybrowser.org/campaign/"> 
<img src="Images/anybrowser4.gif" width="88" height="31" 
 alt="Viewable With Any Browser" border="0"></a>
</p>
</center>

<hr>

<em>Created
Thu Oct 26 12:03:12 2000
</em>
include(`Pages/bitsPaul.m4')
dnl following lines are updated by emacs macros
<em>Updated
Mon May 21 08:28:55 2018
</em>
by <a href="https://hissa.nist.gov/~black/">Paul E. Black
</a>

<p>
This page's URL is
<a href="$ROOTDIR/twolevelExplain.html">$ROOTDIR/twolevelExplain.html</a>
</p>

</body>
</html>
dnl end of $Source$
