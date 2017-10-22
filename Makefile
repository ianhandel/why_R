all: output/01_import-and-tidy_ians-drug-trial_20171020.html

clean:
	rm -f output/*.* rm -f data/*.xlsx
	
code/01_import-and-tidy_ians-drug-trial_20171020.Rmd data/ians-drug-trial_biochemistry-results_20171020.xlsx:
	Rscript -e 'source("code/00_make-data_ians-drug-trial_20171020.R")'

code/01_import-and-tidy_ians-drug-trial_20171020.html: code/01_import-and-tidy_ians-drug-trial_20171020.Rmd data/ians-drug-trial_biochemistry-results_20171020.xlsx
	Rscript -e 'rmarkdown::render(input = "$<", revealjs::revealjs_presentation(theme = "night", transition = "fade", highlight = "espresso"))'
	
output/01_import-and-tidy_ians-drug-trial_20171020.html: code/01_import-and-tidy_ians-drug-trial_20171020.html
	mv code/01_import-and-tidy_ians-drug-trial_20171020.html output/
