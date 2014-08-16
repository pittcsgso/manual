# Requires pandoc, available from http://johnmacfarlane.net/pandoc/
# If it is not in your PATH, specify its location here:
PANDOC=	pandoc

MD_FILES=	$(wildcard *.md)


pdf:	main.tex tex_files
# Use --latex-engine to point to a PDFLaTeX engine if not accessible from path.
# pdflatex is available from http://www.tug.org/applications/pdftex/
	$(PANDOC) main.tex -o csgso-manual.pdf --chapters -N --toc --toc-depth=2 \
		-M documentclass="report" \
		-M geometry="margin=1.25in" \
		-M title="\Huge{\textbf{CS-GSO Manual of Operations}}" \
		-M author="Computer Science Graduate Student Organization\\\\at the University of Pittsburgh" \
		-M date="$(shell git log -1 --format='Compiled in PDF\LaTeX{} from commit \texttt{%h};\\\\\small{authored by %an <\texttt{%ae}>;\\\\dated \textbf{%aD}.}')"

tex_files:	tex/ $(patsubst %.md,tex/%.tex,$(MD_FILES))
tex/:
	mkdir -p tex
tex/%.tex:	%.md
	$(PANDOC) $*.md -o tex/$*.tex


clean:
	rm -rf tex

.PHONY: pdf tex_files clean

