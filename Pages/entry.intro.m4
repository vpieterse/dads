dnl *created  "Thu Jun 28 20:15:51 2001" *by "Paul E. Black"
dnl *modified "Fri Nov  8 13:27:46 2013" *by "Paul E. Black"
dnl
dnl Introductory material for the web page of every entry.
dnl
dnl $Log$
dnl Fri Nov  8 13:50:43 2013  Paul E. Black
dnl Include bits of required HTML <head> stuff.  Add purpose of this file,
dnl a $Log$ line, and an end of file line.
dnl 
<!DOCTYPE HTML PUBLIC "-//IETF//DTD W3 HTML 2.0//EN">
<html lang="en-US">
<head>
<title>$TNAME</title>
<meta name="description"
  content="Definition of $TNAME,
	possibly with links to more information and implementations.">
<meta name="keywords" content="$TNAME">
<meta name="type" content="$TYPE">
<meta name="area" content="$AREA">
<!-- turn off Microsoft's added smart tags -->
<meta name="MSSmartTagsPreventParsing" content="TRUE">
<link rel="stylesheet" type="text/css" href="$ROOTDIR/dads.css">
include(`Pages/bitsReqHeadStuff.m4')
</head>
<body>
include(`Pages/bitsImageLogos.m4')
<h1>$DNAME</h1>
dnl end of $Source$
