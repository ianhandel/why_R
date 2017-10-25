all: docs/tidy_ih-trial_20171020.html

clean:
	rm -f docs/*.*
	rm -f data/*.*

docs/tidy_ih-trial_20171020.html code/ih-trial_results_20171020_tidied.csv: data/ih-trial_results_20171020.xlsx
	Rscript -e 'rmarkdown::render("code/tidy_ih-trial_20171020.Rmd", revealjs::revealjs_presentation(theme = "default",transition = "fade", highlight = "zenburn"))'
	mv code/tidy_ih-trial_20171020.html docs/

data/ih-trial_results_20171020.xlsx: code/mk-data_ih-trial_20171020.R
	Rscript -e 'source("$<")'


