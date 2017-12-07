all: docs/tidy_ih-trial_20171020.html docs/analyse_ih-trial_20171020.html docs/analyse_ih-trial_20171020.docx

clean:
	rm -f docs/*.*
	rm -f data/*.*
	rm -f code/*.html
	rm -f code/*.docx
	rm -f code/*.pdf

code/tidy_ih-trial_20171020.html data/ih-trial_results_20171020_tidy.csv: code/tidy_ih-trial_20171020.Rmd data/ih-trial_results_20171020.xlsx
	Rscript -e 'rmarkdown::render("$<")'
	
docs/tidy_ih-trial_20171020.html: code/tidy_ih-trial_20171020.html
	cp -f code/tidy_ih-trial_20171020.html docs/
	
code/analyse_ih-trial_20171020.html: code/analyse_ih-trial_20171020.Rmd data/ih-trial_results_20171020_tidy.csv
	Rscript -e 'rmarkdown::render("$<")'
	
docs/analyse_ih-trial_20171020.html: code/analyse_ih-trial_20171020.html
	cp -f code/analyse_ih-trial_20171020.html docs/

data/ih-trial_results_20171020.xlsx data/ih-trial_results_20171203.xlsx: code/make-data_ih-trial_20171020.R
	Rscript -e 'source("$<")'



code/analyse_ih-trial_20171020.docx: code/analyse_ih-trial_20171020.Rmd data/ih-trial_results_20171020_tidy.csv
	Rscript -e 'rmarkdown::render("$<", output_format = "word_document")'
	
docs/analyse_ih-trial_20171020.docx: code/analyse_ih-trial_20171020.docx
	cp -f code/analyse_ih-trial_20171020.docx docs/
