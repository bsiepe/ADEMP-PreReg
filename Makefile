all: pdf docx clean

pdf: ADEMP-PreReg.tex bibliography.bib
	pdflatex ADEMP-PreReg
	biber ADEMP-PreReg
	pdflatex ADEMP-PreReg
	pdflatex ADEMP-PreReg

# preprocess tex for pandoc conversion to docx and odt
preprocess: ADEMP-PreReg.tex configurations.tex bibliography.bib
	grep '\\title{' configurations.tex > title.tex
	sed -n '/\\begin{titlepage}/,/\\end{titlepage}/{/\\begin{titlepage}/d;/\\end{titlepage}/d;p}' \
  configurations.tex > titlepage.tex
	sed -e '/\\input{configurations.tex}/{r title.tex' -e 'd}' \
  -e 's/\\instructions//g' \
  -e 's/\\explanation/\\textit{Explanation: }/g' \
  -e 's/\\begin{examplebox}/\\textit{Example: }/g' \
  -e '/\\end{examplebox}/d' \
  -e '/\\maketitlepage/{r titlepage.tex' -e 'd}' \
  ADEMP-PreReg.tex > ADEMP-PreReg-preprocessed.tex

# make sure that pandoc and pandoc-citeproc are installed
# e.g., in Ubuntu: sudo apt install pandoc pandoc-citeproc
docx: preprocess
	pandoc --bibliography=bibliography.bib --reference-doc reference.docx \
  -o ADEMP-PreReg.docx ADEMP-PreReg-preprocessed.tex

odt: preprocess
	pandoc --bibliography=bibliography.bib -o ADEMP-PreReg.odt ADEMP-PreReg-preprocessed.tex

clean:
	rm ADEMP-PreReg.aux ADEMP-PreReg.blg ADEMP-PreReg.log ADEMP-PreReg.bbl ADEMP-PreReg.out ADEMP-PreReg.bcf ADEMP-PreReg.run.xml ADEMP-PreReg-preprocessed.tex title.tex titlepage.tex
