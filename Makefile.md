# Makefile
Ivelin Angelov, Laura Bishop, Ethan Graham, Scott Gozdzialski  
# This is the project's Makefile.
This file will execute the tasks: download, clean, merge and render
All tasks are in separate cells and represent steps towards the final data analysis of the "Case Study 1" prject.
In order to keep the project modular and easy to maintain, we keep the code for all tasks into separate R files.

#### <font color='red'>In order to Knit this file you need to have R Working Directory set to the root of the project.</font>

## Download
This taks is used for downloading of all necessary for the project csv data files.
The files are downloaded from their original locations as given by the assignment.
After execution two files will be created: data/gdp.csv and data/income_groups.csv

```r
source(file.path("source", "download.R"), verbose=FALSE)
```

```
## GDP Data was downloaded successfully! 
## EDS Country Data was downloaded successfully!
```

```r
# For details see source/download.R
```
## Tidy
This cell will tidy the data files.
After execution, two files will be created: data/gdp_tidy.csv and data/income_groups_tidy.csv

```r
# Cleans gdp data: gdp.csv -> gdp_tidy.csv
source(file.path("source", "clean_gdp.R"))
```

```
## Country data was cleaned successfully!
```

```r
# Cleans income groups data: income_groups.csv -> income_groups_tidy.csv
source(file.path("source", "clean_income_groups.R"))
```

```
## Income grpus data was cleaned successfully!
```

```r
# For details see source/clean_gdp.R and source/clean_income_groups.R
```
## Merge
This cell will merge thw two cleaned data files: data/clean_gdp.csv and data/clean_income_groups.csv into data/merged_data.csv

```r
# clean_gdp.csv + clean_income_groups.csv -> merged_data.csv
source(file.path("source", "merge.R"))
```

```
## The two data files were merged successfully!
```

```r
# For details see source/merge.R
```
## Render
This taks will render the Analysis into a HTML file. 
Analysis.Rmd contains all the data analysis for the project.

```r
#rmarkdown::render("Analysis.Rmd")
# For details see Analysis.Rmd
```
