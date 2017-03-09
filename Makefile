all: download tidy
	
download:
	cd ./source/ && Rscript ./download.R

tidy:
	cd source/ && \
	Rscript clean_country_data.R && \
	Rscript clean_income_groups_data.R && \
	Rscript merge_data.R

clean:
	rm -f data/EDSTATS_Country.csv data/GDP.csv data/countries.csv data/income_groups.csv data/merged_data.csv 