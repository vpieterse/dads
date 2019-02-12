dnl *created  "Thu Jun 28 20:15:51 2001" *by "Paul E. Black"
dnl *modified "Thu Jan 31 15:37:45 2019" *by "Paul E. Black"
dnl
dnl Introductory material for the web page of every entry.
dnl
dnl $Log$
dnl Tue Feb 12 10:44:02 2019  Paul E. Black
dnl Include NIST logo directly, instead of via an M4 bit.  The path to the
dnl logo is different for the terms and for "top level" files, so we
dnl really need TWO bits, one for each level.
dnl 
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
<center>
<a href="https://www.nist.gov/" target="_blank"><img
src="../Images/webidblue_1linecentr.gif" border=0 height=43 width=229
alt="NIST"></a>
</center>
<h1>$DNAME</h1>
dnl end of $Source$
