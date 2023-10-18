all: pdf clean docx odt

pdf: ADEMP-PreReg.tex bibliography.bib
	pdflatex ADEMP-PreReg
	biber ADEMP-PreReg
	pdflatex ADEMP-PreReg
	pdflatex ADEMP-PreReg

# make sure that pandoc and pandoc-citeproc are installed
# e.g., in Ubuntu: sudo apt install pandoc pandoc-citeproc
docx: ADEMP-PreReg.tex bibliography.bib
	pandoc --bibliography=bibliography.bib -o ADEMP-PreReg.docx ADEMP-PreReg.tex

odt: ADEMP-PreReg.tex bibliography.bib
	pandoc --bibliography=bibliography.bib -o ADEMP-PreReg.odt ADEMP-PreReg.tex

clean:
	rm ADEMP-PreReg.aux ADEMP-PreReg.blg ADEMP-PreReg.log ADEMP-PreReg.bbl ADEMP-PreReg.out ADEMP-PreReg.bcf ADEMP-PreReg.run.xml
