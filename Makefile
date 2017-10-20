all: output/01_import-and-tidy_ians-drug-trial_20171020.html output/01_import-and-tidy_ians-drug-trial_20171020.md

clean:
	rm -f output/*.*

code/%.md code/%.html: code/%.Rmd
	Rscript -e 'knitr::knit("$<", "$@")'

output/%.md: code/%.md
	mv code/*.md output/

output/%.html: code/%.html
	mv code/*.html output/
