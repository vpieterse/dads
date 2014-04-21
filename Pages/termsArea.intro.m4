dnl *created  "Wed Nov 18 08:51:04 1998" *by "Paul E. Black"
dnl *modified "Mon Apr 21 12:30:50 2014" *by "Paul E. Black"
dnl
dnl $Log$
dnl Mon Apr 21 12:33:32 2014  Paul E. Black
dnl Replace header tags used for formatting with format tags.  Note:
dnl format tags should be in CSS.
dnl 
dnl Fri Nov  8 13:56:20 2013  Paul E. Black
dnl Include bits of required HTML <head> stuff.  Move *created and
dnl *modified lines from HTML to m4 comment (dnl) area.  Add $Log$ and end
dnl of file line.
dnl 
<!DOCTYPE HTML PUBLIC "-//IETF//DTD W3 HTML 2.0//EN">
<html lang="en-US">
<head>
<title>Terms and Definitions Index by Area</title>
<meta name="description"
  content="Index by area to definitions of algorithms, data
structures, and CS problems"> 
<!-- turn off Microsoft's added smart tags -->
<meta name="MSSmartTagsPreventParsing" content="TRUE">
<link rel="stylesheet" type="text/css" href="$ROOTDIR/dads.css">
include(`Pages/bitsReqHeadStuff.m4')
</head>
<body>

<center> <h1>Index by Area</h1> </center>
<center> <strong>of</strong> </center>
<center> <h1><a href="terms.html">Algorithms and Data Structures</a></h1> </center>

<hr>

<p>
This is the web page of terms with definitions organized by area.
That is, whether the term deals with graphs, trees, sorting, etc.
We also list all 
<a href="termsImpl.html">entries with links to implementations</a>
and
<a href="termsType.html">entries by type</a>, for instance, whether it
is an algorithm, a definition, a problem, or a data structure.

<p>
We need people to contribute. include(`Pages/bitsFixDefn.m4'). 
You are welcome to make suggestions to expand and improve the DADS.
<hr>

<!-- this is joined with indexes and a conclusion to make a complete page -->
<!-- end of termsType.intro -->
dnl end of $Source$
