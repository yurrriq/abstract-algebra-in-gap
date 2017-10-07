cpif    ?= | cpif
tangle   = notangle -R'$@' -filter btdefn $< ${cpif} $@
weave    = noweave -filter btdefn -n -delay -index $< ${cpif} $@
GAPROOT ?= /run/current-system/sw/share/gap/build-dir
gap     ?= ${GAPROOT}/bin/gap.sh


.SUFFIXES: .tex .pdf
.tex.pdf:
	latexmk --shell-escape -outdir=tex -pdf $<


all: \
	gap/PerfectNumbers.gd \
	gap/PerfectNumbers.gi \
	tst/PerfectNumbers.tst \
	tst/testall.g \
	doc \
	tex/aaig.pdf \
	check


check: *.g gap/*.gd gap/*.gi tst/*.g tst/*.tst
	@ ${gap} -l "${GAPROOT};." -q tst/testall.g


doc: makedoc.g *.g gap/*.gd gap/*.gi tst/*.tst
	@ ${gap} -b $<


gap/*.gd gap/*.gi tst/*.g tst/*.tst: aaig.nw
	${tangle}


tex/aaig.tex: aaig.nw
	${weave}
