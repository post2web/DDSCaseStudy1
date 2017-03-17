# DDSCaseStudy1

## Instructions for running the project
* Clone the repo (or pull new changes):<br>
* Open Makefile.Rmd with RStudio
* Knit the Makefile.Rmd

## Troubleshooting
* Make sure you have working directory set as the root of the project

## Files and folders
* Makefile.Rmd - build the project in a Makefile stile
* Analysis.Rmd - contains all analysis of the data
* data - a folder container for the data files
* source - a folder containing all scripts used for downloading and cleaning
* source/download.R - a script used for downloading the csv data files
  * downloads [GDP data](https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv) and saves it as gdp.csv
  * downloads [Country Income Grups data](https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv) and saves it as income_groups.csv
* source/clean_gdp.R - a script used for cleaning the gdp data
  * cleans data from gdp.csv and creates a tidy gdp_tidy.csv file
* source/clean_income_groups.R - a script used for cleaning the clean_income_groups data
  * cleans data from income_groups.csv and creates a tidy income_groups_tidy.csv file
* source/merge.R - a script used for merging the two datasets
  * merges the data from gdp_tidy.csv and income_groups_tidy.csv files and creates merged_data.csv

To start contributing you can use git from command line or use [GitHub Desktop](https://desktop.github.com)

###Instructions for contributing with git from command line:

* Clone the repo (only once):<br>
```sh
git clone https://github.com/post2web/DDSCaseStudy1.git
```
* Sync with the repo:<br>
```sh
git pull
```
* Make changes - edit/create/delete files and folders.
* Send your changes to github.<br/>
```sh
# contribute all the changes your made
git add -A
# commit the changes to your local git
git commit -m "description of changes"
# send the changes to github
git push
```

### Todo list: ( push as soon as you make a change )
- [ ] Coment the code base
- [ ] Add text to the R Markdown files
- [ ] Make the output of the R Markdown files pretty - lvb started.
