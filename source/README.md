*
# Data

This folder holds all the source files for the project.<br/>

## Description of files:
* donload.R - a script used for donloading the csv data files
  * downloads [GDP data](https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv) and saves it as gdp.csv
  * downloads [Country Income Grups data](https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv) and saves it as income_groups.csv
* clean_gdp.R - a script used for cleaning the gdp data
  * cleans data from gdp.csv and creates a tidy gdp_tidy.csv file
* clean_income_groups.R - a script used for cleaning the clean_income_groups data
  * cleans data from income_groups.csv and creates a tidy income_groups_tidy.csv file
* merge.R - a script used for merging the two datasets
  * merges the data from gdp_tidy.csv and income_groups_tidy.csv files and creates merged_data.csv
