dnl $Id: bitsSearch.m4,v 1.11 2009/06/04 19:26:18 black Exp $
dnl *created  "Wed Mar 26 11:04:15 2003" *by "Paul E. Black"
dnl *modified "Wed Oct 16 13:12:15 2013" *by "Paul E. Black"
dnl
dnl	A paragraph with explanation and HTML form for the search box
dnl
dnl $Log: bitsSearch.m4,v $
dnl Revision 1.11  2009/06/04 19:26:18  black
dnl update Google URL
dnl
dnl Revision 1.10  2009/02/04 14:58:14  black
dnl Replace hardcoded DADS URL root with an included file.
dnl
dnl Revision 1.9  2006/06/26 12:37:57  black
dnl Remove AlgoVista - the directory is empty.
dnl
dnl Revision 1.8  2006/04/03 14:09:12  black
dnl FirstGov search no longer responds to the form inputs, so replace it
dnl with Google site search.
dnl
dnl Revision 1.7  2006/03/20 18:17:01  black
dnl Add AlgoVista back.  It is online, again.
dnl
dnl Revision 1.6  2004/12/10 21:47:29  black
dnl Change HTML tags to lower case to conform to XHTML.
dnl
dnl Revision 1.5  2004/11/12 13:45:08  black
dnl Remove AlgoVista - off line, again.
dnl
dnl Revision 1.4  2004/05/11 16:33:20  black
dnl Add AlgoVista back: it is on line, again.
dnl
dnl Revision 1.3  2004/04/27 13:25:22  black
dnl Add alt description to text input box for accessibility.
dnl
dnl Revision 1.2  2003/12/02 18:34:11  black
dnl Remove link to AlgoVista - can no longer contact the server - found an
dnl email contact and sent an inquiry.
dnl
dnl
<p>
To look up words or phrases, enter them in the box, then click the
button.
</p>

dnl instructions at http://services.google.com/searchcode2.html?accept=on
<!-- Google SafeSearch -->
<FORM method=GET action="http://www.google.com/search">
<input type=hidden name=ie value=UTF-8>
<input type=hidden name=oe value=UTF-8>
<TABLE><tr><td>
<A HREF="http://www.google.com/webhp?safe=vss">
<IMG SRC="http://www.google.com/logos/Google_Safe.gif" 
border="0" ALT="Google"></A>
</td>
<td>
<INPUT TYPE=text name=q size=31 maxlength=255 value="">
<INPUT type=hidden name=safe value=strict>
<INPUT type=submit name=btnG VALUE="Google Search">
<small>
<input type=hidden name=domains value="$ROOTDIR"><br /><input type=radio name=sitesearch value=""> Web <input type=radio name=sitesearch value="$ROOTDIR" checked> DADS <br />
</small>
</td></tr></TABLE>
</FORM>
<!-- Google SafeSearch -->
dnl end of $Source: /home/black/DADS/Pages/RCS/bitsSearch.m4,v $
