# $Id: Makefile,v 1.56 2012/01/06 17:06:55 black Exp $
# *created  "Tue Nov 17 11:55:10 1998" *by "Paul E. Black"
# *modified "Mon Dec  3 15:44:54 2018" *by "Paul E. Black"
#
# $Log$
# Wed Feb 22 15:17:48 2017  Paul E. Black,,,
# If index.html is older than terms.html or is missing, make it a link
# to terms.html.
# 
# Tue Nov  8 14:08:57 2016  Paul E. Black
# Change chkhtml. & followed by # is ok - it is a hex encoding.
# 
# Fri Sep  2 08:55:34 2016  Paul E. Black
# Remove m4 comment lines, which start with dnl, before extracting words
# to check spelling.
# 
# Tue May 20 11:15:40 2014  Paul E. Black
# Dont spell check m4 macro files: many comments and file names.
# Besides any content appears in other files eventually, which are
# checked.  Fix typo.
# 
# Wed May  7 16:33:53 2014  Paul E. Black
# Fix misspelling and typo.  Remove mention of chklatex in default: it
# will probably never be used again.  Remove dependency of bits
# Demarcate.m4 on bits Fix Defn.m4 since it doesnt include it anymore.
# Remove taraudit rule: I dont think it will be useful - auterms is
# gone.  Add (better) comments to two rules.
# 
# Fri Nov  8 16:40:36 2013  Paul E. Black
# change for new (NIST mandated) required HTML <head> stuff: bitsReqHeadStuff.m4
# add or improve explanation in some places.  Add $Log$ line.
# Since there is no longer an RCS subdirectory under Terms, we can tar
# Terms, instead of specifying Terms/*.trm
# 
# Revision 2.0
# - Replaced cp --forced and --protected with -f and -p for UNIX compatibility 
# - Updated dependencies of the files in PAGES

TARFILE=dads.tar
PROGRAMS=mkterms mkauthors mkcommon.pl macroReplace.pl mksiteNIST.pl mksiteFastar.pl
PAGES=Pages
DIRS=Images Sources ${PAGES} bin aaaaTestDir
FILES=Makefile *Test.trm aaaaTestScript *.data dads.css dads.spell htmlWarnings .gitignore README dictAlgoDataStruc2013.pdf
OUTDIR=Target
HTMLDIR=${OUTDIR}/HTML
OTHERDIR=${OUTDIR}/Other
IMAGESDIR=${OUTDIR}/Images

default:
	@echo targets are site, spell, chkhtml, tar, undefs, configFastar, and configNIST

# various rules to update pieces of the Dictionary site
site: ${PAGES}/entry.intro ${PAGES}/entry.concl \
	${PAGES}/terms.intro ${PAGES}/terms.concl \
	${PAGES}/terms2.intro ${PAGES}/terms2.concl \
	${PAGES}/terms2page.intro ${PAGES}/terms2page.concl \
	${PAGES}/termsArea.intro ${PAGES}/termsArea.concl \
	${PAGES}/termsImpl.intro ${PAGES}/termsImpl.concl \
	${PAGES}/termsType.intro ${PAGES}/termsType.concl \
	${PAGES}/ui.intro ${PAGES}/ui.concl \
	${PAGES}/twolevelExplain.html \
	mksite.pl terms \
	${OUTDIR}/favicon.ico ${OUTDIR}/dads.css \
	${OUTDIR}/index.html ${OUTDIR}/twolevelExplain.html \
	${OTHERDIR}/contrib.html ${OTHERDIR}/creditNotice.html \
	${IMAGESDIR}/index.html \
	${HTMLDIR}/index.html
	@echo Remember to copy any new Images

# convert .trm files into .html
terms: 
	./mkterms

# This rule is here because bitsFixDefn.m4 includes bitsEmail.m4 and 
# bitsFixDefn.m4 is included by other files.  If not for this rule,
# a change to bitsEmail wouldn't be noticed by make.
${PAGES}/bitsFixDefn.m4: ${PAGES}/bitsEmail.m4
	touch --reference=$^ $@

# create or copy other files
${PAGES}/entry.intro: ${PAGES}/entry.intro.m4 \
		${PAGES}/bitsReqHeadStuff.m4 \
		${PAGES}/bitsImageLogos.m4
	m4 $@.m4 > $@

${PAGES}/entry.concl: ${PAGES}/entry.concl.m4 \
		${PAGES}/bitsFixDefn.m4
	m4 $@.m4 > $@

${PAGES}/terms.intro: ${PAGES}/terms.intro.m4 \
		${PAGES}/bitsDemarcate.m4 ${PAGES}/bitsHostedBy.m4 \
		${PAGES}/bitsReqHeadStuff.m4 \
		${PAGES}/bitsSearch.m4  \
		${PAGES}/bitsImageLogos.m4
	m4 $@.m4 > $@

${PAGES}/terms.concl: ${PAGES}/terms.concl.m4 \
		${PAGES}/bibliography.m4 \
		${PAGES}/bitsPaul.m4
	m4 $@.m4 > $@

${PAGES}/terms2.intro: ${PAGES}/terms2.intro.m4 \
		${PAGES}/bitsReqHeadStuff.m4 \
		${PAGES}/bitsImageLogos.m4
	m4 $@.m4 > $@

${PAGES}/terms2.concl: ${PAGES}/terms2.concl.m4
	m4 $@.m4 > $@

${PAGES}/terms2page.intro: ${PAGES}/terms2page.intro.m4 \
		${PAGES}/bitsReqHeadStuff.m4
	m4 $@.m4 > $@

${PAGES}/terms2page.concl: ${PAGES}/terms2page.concl.m4 \
		${PAGES}/bitsHostedBy.m4
	m4 $@.m4 > $@

${PAGES}/termsArea.intro: ${PAGES}/termsArea.intro.m4 \
		${PAGES}/bitsReqHeadStuff.m4 \
		${PAGES}/bitsFixDefn.m4
	m4 $@.m4 > $@

${PAGES}/termsArea.concl: ${PAGES}/termsArea.concl.m4 \
		${PAGES}/bitsPaul.m4
	m4 $@.m4 > $@

${PAGES}/termsImpl.intro: ${PAGES}/termsImpl.intro.m4 \
		${PAGES}/bitsReqHeadStuff.m4 \
		${PAGES}/bitsFixDefn.m4
	m4 $@.m4 > $@

${PAGES}/termsImpl.concl: ${PAGES}/termsImpl.concl.m4 \
		${PAGES}/bitsPaul.m4 \
		${PAGES}/bitsHOSTis.m4
	m4 $@.m4 > $@

${PAGES}/termsType.intro: ${PAGES}/termsType.intro.m4 \
		${PAGES}/bitsReqHeadStuff.m4 \
		${PAGES}/bitsFixDefn.m4
	m4 $@.m4 > $@

${PAGES}/termsType.concl: ${PAGES}/termsType.concl.m4 \
		${PAGES}/bitsPaul.m4 \
		${PAGES}/bitsHOSTis.m4
	m4 $@.m4 > $@

${PAGES}/ui.intro: ${PAGES}/ui.intro.m4 \
		${PAGES}/bitsReqHeadStuff.m4 \
		${PAGES}/bitsImageLogos.m4 ${PAGES}/bitsFixDefn.m4
	m4 $@.m4 > $@

${PAGES}/ui.concl: ${PAGES}/ui.concl.m4 \
		${PAGES}/bitsPaul.m4 \
		${PAGES}/bitsHOSTis.m4
	m4 $@.m4 > $@

${PAGES}/creditNotice.html: ${PAGES}/creditNotice.html.m4 \
		${PAGES}/bitsReqHeadStuff.m4 \
		${PAGES}/bitsPaul.m4 \
		${PAGES}/bitsImageLogos.m4 \
		${PAGES}/bitsHOSTis.m4 
	m4 $@.m4 > $@

${PAGES}/HTMLindex.html: ${PAGES}/HTMLindex.html.m4 \
		${PAGES}/bitsReqHeadStuff.m4 \
		${PAGES}/bitsPaul.m4 \
		${PAGES}/bitsImageLogos.m4 \
		${PAGES}/bitsHOSTis.m4 
	m4 $@.m4 > $@

${PAGES}/twolevelExplain.html: ${PAGES}/twolevelExplain.html.m4 \
		${PAGES}/bitsDemarcate.m4 ${PAGES}/bitsHostedBy.m4 \
		${PAGES}/bitsReqHeadStuff.m4 \
		${PAGES}/bitsSearch.m4  \
		${PAGES}/bitsPaul.m4 \
		${PAGES}/bitsImageLogos.m4 		
	m4 $@.m4 > $@

${PAGES}/contrib.intro: ${PAGES}/contrib.intro.m4 \
		${PAGES}/bitsReqHeadStuff.m4 \
		${PAGES}/bitsImageLogos.m4
	m4 $@.m4 > $@

${PAGES}/contrib.concl: ${PAGES}/contrib.concl.m4 \
		${PAGES}/bitsPaul.m4 \
		${PAGES}/bitsHOSTis.m4
	m4 $@.m4 > $@

${OTHERDIR}/creditNotice.html: ${PAGES}/creditNotice.html
	./macroReplace.pl $^ > $@

${OTHERDIR}/contrib.html: ${PAGES}/contrib.intro ${PAGES}/contrib.concl authors.data
	./mkauthors

# make sure index.html is a link to terms.html
${OUTDIR}/index.html: ${OUTDIR}/terms.html
	rm $@
	ln -s terms.html $@

# make sure favicon.ico is present and up-to-date
${OUTDIR}/favicon.ico: Images/dads.ico
	cp -p -f $^ $@

# make sure style sheet is present and up-to-date
${OUTDIR}/dads.css: dads.css
	cp -p -f $^ $@

${OUTDIR}/twolevelExplain.html: ${PAGES}/twolevelExplain.html
	./macroReplace.pl $^ > $@

${HTMLDIR}/index.html: ${PAGES}/HTMLindex.html
	./macroReplace.pl $^ > $@

# copy Images index files
${IMAGESDIR}/index.html: Images/index.html
	cp -p -f $^ $@

images:
	cp -p -f -r Images ${OUTDIR}

#=========================================================================
#
# configure DADS for Fastar or for NIST
#
# Note: the generic files depend on the site-specific versions so that
# if the site-specific versions change, the user is notified to run
# make config* again.
#
#=========================================================================

${PAGES}/bitsImageLogos.m4: ${PAGES}/bitsImageLogosFastar.m4 ${PAGES}/bitsImageLogosNIST.m4
	$(error RUN make configFastar OR make configNIST - bitsImageLogos)

${PAGES}/bitsHostedBy.m4: ${PAGES}/bitsHostedByFastar.m4 ${PAGES}/bitsHostedByNIST.m4
	$(error RUN make configFastar OR make configNIST - bitsHostedBy)

${PAGES}/bitsHOSTis.m4: ${PAGES}/bitsHOSTisFastar.m4 ${PAGES}/bitsHOSTisNIST.m4
	$(error RUN make configFastar OR make configNIST - bitsHOSTis)

${PAGES}/bitsReqHeadStuff.m4: ${PAGES}/bitsReqHeadStuffFastar.m4 ${PAGES}/bitsReqHeadStuffNIST.m4
	$(error RUN make configFastar OR make configNIST - bitsReqHeadStuff)

mksite.pl: mksiteFastar.pl mksiteNIST.pl
	$(error RUN make configFastar OR make configNIST - mksite)

# Note: copy all files, which gives them a recent time stamp.  Don't use
# cp -p: if you're changing from one site to another, you may install a
# *newer* version, which breaks the above checks.  Also don't make these
# copies time-dependent, since you may want to install another site's
# version, which may a *newer* version.
configFastar:
	cp ${PAGES}/bitsImageLogosFastar.m4 ${PAGES}/bitsImageLogos.m4
	cp ${PAGES}/bitsHostedByFastar.m4 ${PAGES}/bitsHostedBy.m4
	cp ${PAGES}/bitsHOSTisFastar.m4 ${PAGES}/bitsHOSTis.m4
	cp ${PAGES}/bitsReqHeadStuffFastar.m4 ${PAGES}/bitsReqHeadStuff.m4
	cp mksiteFastar.pl mksite.pl
	@echo done

configNIST:
	cp ${PAGES}/bitsImageLogosNIST.m4 ${PAGES}/bitsImageLogos.m4
	cp ${PAGES}/bitsHostedByNIST.m4 ${PAGES}/bitsHostedBy.m4
	cp ${PAGES}/bitsHOSTisNIST.m4 ${PAGES}/bitsHOSTis.m4
	cp ${PAGES}/bitsReqHeadStuffNIST.m4 ${PAGES}/bitsReqHeadStuff.m4
	cp mksiteNIST.pl mksite.pl
	@echo done

#=========================================================================
#
# various scripts, actions, checks, etc.
#
#=========================================================================

# report undefined terms
undefs:
	@cd Terms; perl -nwe 'if(/NAME=(.*)/){$$nam=$$1;if(length($$nam)<8){$$nmtabs="\t\t\t"}elsif(length($$nam)<16){$$nmtabs="\t\t"}else{$$nmtabs="\t"};if(length($$ARGV)<15){$$tabs="\t\t"}else{$$tabs="\t"}};if (/DEFN=/){$$nodefn = /DEFN=$$/};print "$$ARGV:$$tabs$$nam$$nmtabs$$1\n" if ($$nodefn && /AUTHOR=(.*)/)' *.trm

# the perl command removes
#	* comment lines (start with # or dnl)
#	* any m4 macro file (files ending with .m4)
#	* WEB= lines since they often have "misspellings"
#	* URL's (stuff in href's or src's)
#	* email addresses (stuff around @ signs)
#	* HTML escapes (&...;) (&?acute; into ? and &?uml; into ?e)
#	* LaTeX macros (\macroName)
# and breaks input into words: apostrophes (\047) and letters.
# Remove any trailing 's on (long) words -- it's probably a possessive.
# There are so many entries we must pass spell just a simple list of words
# The '-' before diff means ignore "error" when grep finds no misspellings
spell:
	perl -nwe 'next if /^#/||/^dnl /;next if $$ARGV=~/[.]m4$$/;next if /^\@WEB=/;s/(href|src)="[^"]*"//gio;s/[-\w\d.]+@[-\w\d.]+//go;s/&(.)acute;/$$1/go;s/&(.)uml;/$$1e/go;s/&[^;]+;//go;s/\\\w*//go;tr/\047a-zA-Z/\012/cs;print;' ${PAGES}/* *.data Terms/*.trm | perl -pwe "s/'s// if /[a-zA-Z][a-zA-Z][a-zA-Z]'s$$/" | sort --ignore-case -u | spell > dads.spell.new
	-diff dads.spell.new dads.spell | grep '^<'

tar:
	tar -pcf ${TARFILE} ${PROGRAMS} ${FILES} ${DIRS} Terms

# find .trm files newer than the tar file, that is, needing to be tar'd
findnew:
	find Terms -name "*.trm" -newer ${TARFILE} -print
	find Images -type f -newer ${TARFILE} -print

# check the final HTML for any problems
# the first perl breaks output (at <LI>, <P>, <PRE>, <TR..> and <BR>) to 
#   reduce the size of diff's to make it easier to spot the problem
# the second perl looks for
#   * backslashes (\), carets (^), or dollar signs ($)
#   * underscores (_) that are not in doublequotes (HREF's)
#   * any doubled quotes (`` or '' \047 in octal ascii since shell eats '')
#   * any doubled periods (not in HREF or math expression)
#   * lone ampersand (& instead of &amp;)
#   * dangling href's (Unknown HyperREFerences)  $$ makes entry unique so 
#	it shows up in every run.
#   * invalid URL in NIST exit script
chkhtml:
	(cd ${HTMLDIR};perl -pwe 's/(<LI>|(?=.)<P>|<PRE>|<TR)/ in $$ARGV\n$$1/gi;s|(<BR ?/?>)|$$1 in $$ARGV\n|gi;s/(.)\n$$/$$1 in $$ARGV\n/' *.html) | perl -nwe 'print "BACKSLASH, CARET, or DOLLAR SIGN\n$$_" if /[\\^\$$]/o;print "UNDERSCORE\n$$_" if /_[^"]*("[^"]+"[^"]*)*$$/o;print "DOUBLED QUOTES\n$$_" if /(``|\047\047)/o;print "DOUBLED PERIODS\n$$_" if /[^".][.][.][^.a-z]/o;print "LONE AMPERSAND\n$$_" if /&[^a-zA-Z#]/o;print "DANGLING HREF ($$$$)\n$$_" if /href="\#/o; print "BAD URL\n$$_" if (/url=(?!(https?|ftp|gopher):)/)' > htmlWarnings.new
	-diff -b htmlWarnings.new htmlWarnings

# This rule was used when sending the terms to Taz for the print Dictionary
# check the final LaTeX for any problems
#    look for angle brackets (<>), carets (^), or underscores (_)
#    that are not in dollar signs (math mode) or for ampersands (&)
chklatex:
	perl -nwe '$$n=$$_ if $$namenext;$$namenext=/^$$/;print "CARETS, UNDERSCORES, or ANGLE BRACKETS not in math mode or DOUBLED DOLLARS or AMPERSANDS in $$n$$_" if /\$$\$$|&/ || /^[^\$$]*(\$$[^\$$]+\$$[^\$$]*)*[_^<>]/o' termFinal.txt

# end of $Source: /home/black/DADS/RCS/Makefile,v $
