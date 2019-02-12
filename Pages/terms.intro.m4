dnl *created  "Fri Sep  4 16:39:08 1998" *by "Paul E. Black"
dnl *modified "Wed Dec 12 13:07:20 2018" *by "Paul E. Black"
dnl
dnl $Log: terms.intro.m4,v $
dnl Tue Feb 12 10:41:53 2019  Paul E. Black
dnl Add (back) note seeking someone to take over DADS.
dnl 
dnl Tue May  6 13:45:32 2014  Paul E. Black
dnl Put the need-help anchor by itself, instead of wrapping it around the
dnl include, in order to remove nested anchors.  Also include bits Fix
dnl Defn here explicitly, rather than doing it through bits Demarcate.
dnl 
dnl Fri Nov  8 13:52:54 2013  Paul E. Black
dnl Include bits of required HTML <head> stuff.  Move all HTML stuff
dnl *after* the m4-commented-out header stuff.  Add end of file line.
dnl 
dnl Revision 2.2  2013/09/20  14:16:11 vreda
dnl Used double quotes for the 'target = "_blank"' anchor
dnl
dnl $Log: terms.intro.m4,v $
dnl Revision 2.1  2013/09/05 12:31:47  vreda
dnl made the link to Glossary of algorithms open in new window
dnl
dnl Revision 2.0  Thu Jul 12 18:38:13 SAST 2012  vreda
dnl Remove reference to NIST exit page and
dnl add the use of bitsImageLogos.m4
dnl
dnl Revision 1.40  2012/02/02 16:18:09  black
dnl add the name of the group, FASTAR, who will take over DADS and link to
dnl their site.
dnl
dnl Revision 1.39  2012/01/27 13:40:54  black
dnl remove date: people might think DADS is moving in Jan 2012
dnl
dnl Revision 1.38  2012/01/26 22:11:40  black
dnl change "Phase Out" to "Moving"
dnl
dnl Revision 1.37  2012/01/26 22:09:41  black
dnl change Phase Out notice to say it is moving to Stellenbosch, Pretoria,
dnl and Eindhoven.
dnl
dnl Revision 1.36  2012/01/11 20:22:32  black
dnl Add note about DADS phasing out and ask people to contact me.
dnl
dnl Revision 1.35  2011/12/06 20:59:10  black
dnl Include new NIST exit script bit, instead of hardcoding the URL
dnl
dnl Revision 1.34  2009/11/04 13:59:43  black
dnl Update URL for BABEL Glossary of Computer Oriented Abbreviations and Acronyms
dnl
dnl Revision 1.33  2009/04/14 16:17:56  black
dnl Remove FOLDOC link - appears to be off-line.  There are mirrors, but
dnl the terms are probably incorporated in wikipedia.
dnl
dnl Revision 1.32  2009/02/04 14:32:02  black
dnl Replace hardcoded DADS URL root with included file.  Change some RCS
dnl and other "admin" stuff from HTML comments, which appear in the final
dnl HTML page, into m4 "comments", which do not.
dnl
dnl Revision 1.31  2007/02/12 16:47:50  black
dnl Remove ICRA/PICS labeling - they changed the site name and format, and
dnl I don't have time now to redo it.
dnl
dnl Revision 1.30  2006/09/20 13:40:34  black
dnl Use a far more standard spelling of archetypical.
dnl
dnl Revision 1.29  2006/04/03 13:21:35  black
dnl Update FOLDOC URL
dnl
dnl Revision 1.28  2006/03/20 18:10:50  black
dnl Add m4 macro header so RCS inserts log comments
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en-US">

<!-- 		  EDIT terms.intro.m4 NOT terms.intro			-->

<head>
<title>Dictionary of Algorithms and Data Structures</title>
<meta name="description"
  content="Definitions of algorithms, data structures, and classical
  Computer Science problems.
	Some entries have links to implementations and more information.">
<meta name="keywords" content="algorithm, data structure, traveling
salesman, sorting, searching, tree, hash, graph">
<!-- turn off Microsoft's added smart tags -->
<meta name="MSSmartTagsPreventParsing" content="TRUE">
<link rel="SHORTCUT ICON"
	href="$ROOTDIR/favicon.ico">
<link rel="stylesheet" type="text/css" href="$ROOTDIR/dads.css">
include(`Pages/bitsReqHeadStuff.m4')
</head>
<body>

include(`Pages/bitsImageLogos.m4')
<center> <h1>Dictionary of Algorithms and Data Structures</h1> </center>

<p>
This web site is hosted by
include(`Pages/bitsHostedBy.m4')
Development of this dictionary started in 1998 
under the editorship of Paul E. Black. </p>

<p>
<strong>
After 20 years, DADS needs to move.  If you are interested in
taking over DADS, please contact 
include(`Pages/bitsEmail.m4').
</strong>
</p>

<p>
This is a dictionary of algorithms, algorithmic techniques, 
data structures, archetypal problems, and related definitions.
Algorithms include common functions, such as
<a href="HTML/ackermann.html">Ackermann's function</a>.
Problems include 
<a href="HTML/travelingSalesman.html">traveling salesman</a> and
<a href="HTML/byzantine.html">Byzantine generals</a>.
Some entries have links to <a href="termsImpl.html">implementations</a>
and more information.
Index pages list entries by 
<a href="termsArea.html">area</a> and by
<a href="termsType.html">type</a>.
The <a href="terms2.html">two-level
index</a> has a total download 1/20 as big as this page.
</p>

<p>
Don't use this site to cheat.  Teachers, contact us if we can help.
</p>

<p>
include(`Pages/bitsDemarcate.m4')
<a name="needHelp"><!-- entries without definitions link here --></a>
include(`Pages/bitsFixDefn.m4')
</p>

<p>
Some terms with a leading variable, such as <em>n</em>-way,
<em>m</em>-dimensional, or <em>p</em>-branching, are under
<a href="#K"><em>k</em>-</a>.
You may find useful entries in
<a href="http://www.arcelect.com/babel99.htm" target="_blank">A
Glossary of Computer Oriented Abbreviations and Acronyms</a>.
</p>

<hr>

include(`Pages/bitsSearch.m4')

<hr>
dnl This is run through m4 then joined with the entries and a conclusion to 
dnl make a complete page
dnl
dnl end of $Source$
