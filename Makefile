all: docs/tidy_ih-trial_20171020.html

clean:
	rm -f docs/*.* rm -f data/*.*

data/ih-trial_results_20171020.xlsx: code/mk-data_ih-trial_20171020.R
	Rscript -e 'source("$<")'

code/tidy_ih-trial_20171020.html code/%.csv: code/tidy_ih-trial_20171020.Rmd data/ih-trial_results_20171020.xlsx
	Rscript -e 'rmarkdown::render(input = "$<", revealjs::revealjs_presentation(theme = "default",transition = "fade", highlight = "zenburn"))'

docs/tidy_ih-trial_20171020.html: code/tidy_ih-trial_20171020.html
	mv code/tidy_ih-trial_20171020.html docs/	
