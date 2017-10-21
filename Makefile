all: output/01_import-and-tidy_ians-drug-trial_20171020.html

clean:
	rm -f output/*.*

code/%.html: code/%.Rmd
	Rscript -e 'knitr::knit("$<", "$@")'

output/%.html: code/%.html
	mv code/*.html output/
