
all: hanson_crypto_final

hanson_crypto_final: approach.tex introduction.tex hanson_crypto_final.tex citations.bib relatedwork.tex
	latex hanson_crypto_final
	latex hanson_crypto_final
	bibtex hanson_crypto_final.aux
	latex hanson_crypto_final
	latex hanson_crypto_final
	latex hanson_crypto_final
	dvipdfm hanson_crypto_final.dvi

clean:
	rm -fv *.aux *.log *.dvi *.pdf *.bbl *.blg
