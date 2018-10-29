dnl *created  "Wed Jan  9 12:03:53 2002" *by "Paul E. Black"
dnl *modified "Mon Oct 29 13:46:36 2018" *by "Paul E. Black"
dnl
dnl This is run through m4 then joined with an introduction and 
dnl the entries to make a complete terms page.
dnl
dnl $Log$
dnl Fri Nov  8 13:49:35 2013  Paul E. Black
dnl Include bits of required HTML <head> stuff.  Add $Log$ and end of file lines.
dnl 
dnl Revision 2.0  Fri Jul 13 09:26:43 SAST 2012  vreda
dnl Use another file for image at the top of the page
dnl
dnl Revision 1.7  2010/09/27 17:14:52  black
dnl Use another file for the DADS root instead of hard-coding it here.
dnl Also add RCS keywords since m4 macro expansion can remove them.
dnl
<!DOCTYPE HTML PUBLIC "-//IETF//DTD W3 HTML 2.0//EN">
<html lang="en-US">
<head>
<title>Contributors to the Dictionary of Algorithms and Data Structures</title>
<meta name="description"
  content="Contributors to the Dictionary of Algorithms, Data
  Structures, and Classical Computer Science problems, with some
  contact information.">
<meta name="keywords" content="contributor, author">
<!-- turn off Microsoft's added smart tags -->
<meta name="MSSmartTagsPreventParsing" content="TRUE">
<link rel="stylesheet" type="text/css" href="$ROOTDIR/dads.css">
include(`Pages/bitsReqHeadStuff.m4')
</head>
<body>
<center>
<a href="https://www.nist.gov/" target="_blank"><img
src="../Images/webidblue_1linecentr.gif" border=0 height=43 width=229
alt="NIST"></a>
</center>
<center> <h1>Contributors</h1> </center>
<center> <h2>to the</h2> </center>
<center> <h1>Dictionary of Algorithms and Data Structures</h1> </center>

<p>
This is a list of most of those defining the over 1100 terms in the
<a href="$ROOTDIR/">Dictionary of Algorithms and Data
Structures</a>.  In addition, we received corrections and
suggestions from many others not listed here.  The quality and breadth of the
Dictionary wouldn't be possible without them.  We are grateful.
</p>

<!-- this is joined with authors from authors.data and a conclusion to make a
	complete page -->
dnl end of $Source$
