output/01_import-and-tidy_ians-drug-trial_20171020.md:	code/01_import-and-tidy_ians-drug-trial_20171020.md
	mv code/*.md output/

code/01_import-and-tidy_ians-drug-trial_20171020.md:	code/01_import-and-tidy_ians-drug-trial_20171020.Rmd	code/ians-drug-trial_biochemistry-results_20171020.xls
	Rscript -e 'rmarkdown::render("$<")'

code/ians-drug-trial_biochemistry-results_20171020.xls:


