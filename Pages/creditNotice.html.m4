dnl $Id: creditNotice.html.m4,v 1.14 2011/12/06 20:58:45 black Exp $
dnl *created  "Thu Jun  2 11:17:54 2005" *by "Paul E. Black"
dnl *modified "Mon Sep 18 10:13:44 2017" *by "Paul E. Black"
dnl
dnl $Log$
dnl Mon Sep 18 10:41:52 2017  Paul E. Black
dnl Remove FASTAR from "hosted by" since it will not be hosting DADS.
dnl 
dnl Mon Jun  6 08:50:52 2016  Paul E. Black
dnl update FASTAR URL
dnl 
dnl Mon May 18 09:45:56 2015  Paul E. Black
dnl Update URL for CRC permissions. Again.
dnl 
dnl Mon Mar  2 15:46:14 2015  Paul E. Black
dnl Update CRC permissions web page, again.
dnl 
dnl Mon Apr 21 12:26:40 2014  Paul E. Black
dnl Replace header tags that were used for formatting with format tags.
dnl Note: formatting should go in CSS.  Fix header nesting, e.g., <h2>
dnl under <h1> instead of <h3> under <h1>.
dnl 
dnl Fri Nov  8 13:48:25 2013  Paul E. Black
dnl Include bits of required HTML <head> stuff.  Add end of file line.
dnl 
dnl Wed Oct 30 10:42:24 2013  Paul E. Black
dnl Add the $Log line back
dnl 
dnl Wed Oct 30 10:35:39 2013  Paul E. Black
dnl Remove institution from print citation. Add NIST to HTML citation.
dnl Update "accessed" dates so they dont look TOO old.
dnl
dnl Revision 2.0  Fri Jul 13 11:11:32 SAST 2012  vreda
dnl Remove NIST exit script bit and used bits for top image and people
dnl
dnl Revision 1.14  2011/12/06 20:58:45  black
dnl Include new NIST exit script bit, instead of hardcoding the URL
dnl
dnl Revision 1.13  2010/05/03 16:42:20  black
dnl "How to Cite Online Documents" is no longer online, that I can find.
dnl
dnl Revision 1.12  2009/04/27 20:16:58  black
dnl update CRC Press permission page.
dnl
dnl Revision 1.11  2009/02/04 14:48:30  black
dnl Replace hardcoded DADS URL root with included file.  Make created and
dnl modified lines m4 comments, instead of HTML comments, so they don't
dnl appear in the final HTML.
dnl
dnl Revision 1.10  2008/10/06 14:43:52  black
dnl Update reference - Collections Canada no longer has excerpts on-line,
dnl only a citation guide "based on the International Standard IO 690-2".
dnl Add RCS Log keyword
dnl
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en-US">
<head>
<title>citing and crediting DADS</title>
<!-- turn off Microsoft's added smart tags -->
<meta name="MSSmartTagsPreventParsing" content="TRUE">
<link rel="stylesheet" type="text/css" href="$ROOTDIR/dads.css">
include(`Pages/bitsReqHeadStuff.m4')
</head>
<body>
include(`Pages/bitsImageLogos.m4')
<center><font size="+1"><strong>Dictionary of Algorithms and Data Structures</strong></font></center>
<center><h1>Citation and Credit Notice</h1></center>

<p>
Some definitions are copyright CRC Press, such as
<a href="$ROOTDIR/HTML/depoissonization.html">depoissonization</a>.
You must get 
<a href="https://www.crcpress.com/contactus/rightspermissions">CRC Press
permission</a>
for those.  All others are public domain.
</p>

<p>
Many of the definitions, as well as the site itself, were originally developed at
the National Institute of Standards and Technology by employees of the
Federal Government in the course of their official duties.  Pursuant
to title 17 Section 105 of the United States Code these are not
subject to copyright protection and are in the public domain.
</p>

<p>
If you use definitions from the Dictionary, we would appreciate
acknowledgment.  If this site or the definitions are helpful, we would
appreciate a note expressing how valuable it is.
</p>

<h2>Citing the Dictionary</h2>

<p>
Here is a print citation.
<pre>
    Dictionary of Algorithms and Data Structures, Vreda Pieterse and Paul E. 
    Black eds., $ROOTDIR/, (ACCESS DATE).
</pre>
Put the latest date you accessed DADS in parentheses, for instance, 
30 October 2013.
</p>


<p>
Here is an HTML citation.
<pre>
In &lt;a href="$ROOTDIR/"&gt;Dictionary of 
Algorithms and Data Structures&lt;/a&gt; hosted by
&lt;a href="https://www.nist.gov/"&gt;National Institute of
Standards and Technology&lt;/a&gt;.
</pre>
</p>

<h2>Citing an Entry</h2>

<p>
Here is a bibtex citation for 
<a href="$ROOTDIR/HTML/rootedtree.html">rooted tree</a>.
<pre>
@Misc{dads:rt,
  author = {Paul M. Sant},
  title = {"rooted tree"},
  howpublished = {in \emph{Dictionary of Algorithms and Data Structures} [online], Vreda Pieterse and Paul E. Black eds.},
  month = {17 December}, % ENTRY MODIFIED DATE
  year = {2004},
  note =  {Available from: $ROOTDIR/HTML/rootedtree.html (accessed 4 July 2013)}, % LAST ACCESS DATE 
</pre>
The result should be something like this:<br><br>
Sant, Paul M. rooted tree. In <em>Dictionary of Algorithms and Data Structures</em> [online], Paul E. Black and Vreda Pieterse eds., 17 December 2004. Available from: $ROOTDIR/HTML/rootedtree.html. (accessed 4 July 2013)
</p>

<h2>Citation References</h2>

<p>
These try to follow ISO 690-2 Information and documentation -- Bibliographic references -- Part 2: Electronic documents or parts thereof, upon which
"How to Cite Online Documents" is based.
</p>

<hr>

Go to the
<a href="$ROOTDIR/">Dictionary of Algorithms and Data
Structures</a> home page.

<hr>

<em>Created
Thu Jun  2 11:21:13 2005
</em>
include(`Pages/bitsPaul.m4')
dnl following lines updated by emacs macros
<em>Updated
Mon Sep 18 10:13:44 2017
</em>
by <a href="https://hissa.nist.gov/~black/">Paul E. Black
</a>

<p>
This page's URL is
<a href="$ROOTDIR/Other/creditNotice.html">$ROOTDIR/Other/creditNotice.html</a>
</p>

<center>
<p>
include(`Pages/bitsHOSTis.m4')
</p>
</center>

</body>
</html>
dnl end of $Source$
