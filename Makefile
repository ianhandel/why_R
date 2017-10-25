all: docs/tidy_ih-trial_20171020.html docs/analyse_ih-trial_20171020.html

clean:
	rm -f docs/*.*
	rm -f data/*.*

docs/tidy_ih-trial_20171020.html data/ih-trial_results_20171020_tidied.csv: code/tidy_ih-trial_20171020.Rmd data/ih-trial_results_20171020.xlsx
	Rscript -e 'rmarkdown::render("$<", revealjs::revealjs_presentation(theme = "default",transition = "fade", highlight = "zenburn"))'
	mv code/tidy_ih-trial_20171020.html docs/
	
docs/analyse_ih-trial_20171020.html: code/analyse_ih-trial_20171020.Rmd data/ih-trial_results_20171020_tidy.csv
	Rscript -e 'rmarkdown::render("$<")'
	mv code/analyse_ih-trial_20171020.html docs/

data/ih-trial_results_20171020.xlsx: code/mk-data_ih-trial_20171020.R
	Rscript -e 'source("$<")'


