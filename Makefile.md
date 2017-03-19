# Makefile
Ivelin Angelov, Laura Bishop, Ethan Graham, Scott Gozdzialski  
# This is the project's Makefile.
This file will execute the tasks: dependencies, download, clean, merge and render
All tasks are in separate cells and represent steps towards the final data analysis of the "Case Study 1" prject.
In order to keep the project modular and easy to maintain, we keep the code for all tasks into separate R files.

#### <font color='red'>In order to Knit this file you need to have R Working Directory set to the root of the project.</font>

## Dependencies
Before we start, we make sure all packages needed for the project are installed.

```r
needed_packages = c('downloader', 'ggplot2', 'scales', 'Hmisc', 'lattice', 'htmlTable')
for (needed_package in needed_packages) {
  if(needed_package %in% rownames(installed.packages()) == FALSE) {
    install.packages(needed_package, repos = structure(c(CRAN = "http://cran.r-project.org")))
  }
}
```

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
rmarkdown::render("Analysis.Rmd")
```

```
## 
  |                                                                       
  |                                                                 |   0%
  |                                                                       
  |......                                                           |   9%
##   ordinary text without R code
## 
## 
  |                                                                       
  |............                                                     |  18%
## label: unnamed-chunk-1
## 
  |                                                                       
  |..................                                               |  27%
##   ordinary text without R code
## 
## 
  |                                                                       
  |........................                                         |  36%
## label: unnamed-chunk-2
## 
  |                                                                       
  |..............................                                   |  45%
##   ordinary text without R code
## 
## 
  |                                                                       
  |...................................                              |  55%
## label: unnamed-chunk-3
## 
  |                                                                       
  |.........................................                        |  64%
##   ordinary text without R code
## 
## 
  |                                                                       
  |...............................................                  |  73%
## label: unnamed-chunk-4 (with options) 
## List of 1
##  $ message: symbol F
```

```
## 
  |                                                                       
  |.....................................................            |  82%
##   ordinary text without R code
## 
## 
  |                                                                       
  |...........................................................      |  91%
## label: unnamed-chunk-5 (with options) 
## List of 1
##  $ message: symbol F
## 
## 
  |                                                                       
  |.................................................................| 100%
##   ordinary text without R code
## 
## 
## /Applications/RStudio.app/Contents/MacOS/pandoc/pandoc +RTS -K512m -RTS Analysis.utf8.md --to html --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash --output Analysis.html --smart --email-obfuscation none --self-contained --standalone --section-divs --template /Library/Frameworks/R.framework/Versions/3.3/Resources/library/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --variable 'theme:bootstrap' --include-in-header /var/folders/df/2w6dv0r11pb69jhk8lzjjb_m0000gn/T//Rtmp5DEopp/rmarkdown-str167242212aaba.html --mathjax --variable 'mathjax-url:https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML'
```

```r
# For details see Analysis.Rmd
```
