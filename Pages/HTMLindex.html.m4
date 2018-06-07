dnl $Id: HTMLindex.html.m4,v 1.9 2011/12/06 20:58:02 black Exp $
dnl *created  "Thu Oct  3 09:04:38 2002" *by "Paul E. Black"
dnl *modified "Mon May 21 08:29:14 2018" *by "Paul E. Black"
dnl
dnl $Log: HTMLindex.html.m4,v $
dnl Thu Jun  7 13:05:45 2018  Paul E. Black
dnl Update URL for aynbrowser campaign
dnl 
dnl Fri Nov  8 13:48:51 2013  Paul E. Black
dnl Include bits of required HTML <head> stuff.  Add end of file line.
dnl 
dnl Revision 2.0  Fri Jul 13 12:42:44 SAST 2012  vreda
dnl Remove NIST exit script bit, and introduced other bits
dnl
dnl Revision 1.9  2011/12/06 20:58:02  black
dnl Include new NIST exit script bit, instead of hardcoding the URL
dnl
dnl Revision 1.8  2009/02/04 15:10:16  black
dnl Replace hardcoded DADS URL root with included file.  Make created and
dnl modified into m4 "comments", instead of HTML comments, so they don't
dnl appear in the final HTML page.
dnl
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en-US">
<head>
<title>Dictionary of Algorithms and Data Structures</title>
<!-- turn off Microsoft's added smart tags -->
<meta name="MSSmartTagsPreventParsing" content="TRUE">
<meta http-equiv="refresh" content="15; URL=$ROOTDIR/">
<link rel="stylesheet" type="text/css" href="$ROOTDIR/dads.css">
include(`Pages/bitsReqHeadStuff.m4')
</head>
<body>
include(`Pages/bitsImageLogos.m4')
<center><h1>Dictionary of Algorithms and Data Structures</h1></center>

<p>
Click the following link to go to the main page of the
<a href="$ROOTDIR/">Dictionary of Algorithms and Data
Structures</a> (or your browser should reference it in 15 seconds).
You can also start with a much shorter 
<a href="$ROOTDIR/terms2.html">two-level index</a>.
The two-level index trades a little less convenience (two clicks) for
a download of about 1/20th the size.
</p>

<hr>

<center>
<p>
<a href="https://anybrowser.org/campaign/"> 
<img src="../Images/anybrowser4.gif" width="88" height="31" 
 alt="Viewable With Any Browser" BORDER="0"></a>
</p>
</center>

<hr>

<em>Created
Thu Oct  3 09:06:12 2002
</em>
include(`Pages/bitsPaul.m4')
dnl following lines updated by emacs macros
<em>Updated
Mon May 21 08:29:14 2018
</em>
by <a href="https://hissa.nist.gov/~black/">Paul E. Black
</a>

<center>
<p>
include(`Pages/bitsHOSTis.m4')
</p>
</center>

</body>
</html>
dnl end of $Source$
