# Makefile
# This is the project's Makefile.
This file will download, clean, and merge the data files needed for the analysis of the "Case Study 1" prject.

#### <font color='red'>In order to Knit this file you need to have R Working Directory set to the root of the project.</font>

### Download all necessary for the project csv data files.
The files are downloaded from their original location as given by the assignment.

```r
# Run the script in source/download.R
# All paths will be created according to the host OS requirements
source(file.path("source", "download.R"), verbose=FALSE)
```

```
## EDS Country Data was downloaded successfully! 
## GDP Data was downloaded successfully!
```
### This cell will tidy the data files.

```r
source(file.path("source", "clean_gdp.R"))
```

```
## Country data was cleaned
```

```r
source(file.path("source", "clean_income_groups.R"))
```

```
## Income grpus data was cleaned
```
### Merge data the cleaned data files.

```r
source(file.path("source", "merge.R"))
```

```
## Data was merged
```
### Render the Analysis into a HTML file.

```r
rmarkdown::render("Analysis.Rmd")
```

```
## 
  |                                                                       
  |                                                                 |   0%
  |                                                                       
  |...                                                              |   4%
##   ordinary text without R code
## 
## 
  |                                                                       
  |......                                                           |   9%
## label: unnamed-chunk-1 (with options) 
## List of 1
##  $ echo: logi FALSE
## 
## 
  |                                                                       
  |........                                                         |  13%
##   ordinary text without R code
## 
## 
  |                                                                       
  |...........                                                      |  17%
## label: unnamed-chunk-2
## 
  |                                                                       
  |..............                                                   |  22%
##   ordinary text without R code
## 
## 
  |                                                                       
  |.................                                                |  26%
## label: unnamed-chunk-3
## 
  |                                                                       
  |....................                                             |  30%
##   ordinary text without R code
## 
## 
  |                                                                       
  |.......................                                          |  35%
## label: unnamed-chunk-4
## 
  |                                                                       
  |.........................                                        |  39%
##   ordinary text without R code
## 
## 
  |                                                                       
  |............................                                     |  43%
## label: kable
```

```
## 
  |                                                                       
  |...............................                                  |  48%
##   ordinary text without R code
## 
## 
  |                                                                       
  |..................................                               |  52%
## label: unnamed-chunk-5
## 
  |                                                                       
  |.....................................                            |  57%
##   ordinary text without R code
## 
## 
  |                                                                       
  |........................................                         |  61%
## label: unnamed-chunk-6
## 
  |                                                                       
  |..........................................                       |  65%
##   ordinary text without R code
## 
## 
  |                                                                       
  |.............................................                    |  70%
## label: unnamed-chunk-7
```

```
## 
  |                                                                       
  |................................................                 |  74%
##   ordinary text without R code
## 
## 
  |                                                                       
  |...................................................              |  78%
## label: unnamed-chunk-8
```

```
## 
  |                                                                       
  |......................................................           |  83%
##   ordinary text without R code
## 
## 
  |                                                                       
  |.........................................................        |  87%
## label: unnamed-chunk-9
## 
  |                                                                       
  |...........................................................      |  91%
##   ordinary text without R code
## 
## 
  |                                                                       
  |..............................................................   |  96%
## label: unnamed-chunk-10
## 
  |                                                                       
  |.................................................................| 100%
##   ordinary text without R code
## 
## 
## /Applications/RStudio.app/Contents/MacOS/pandoc/pandoc +RTS -K512m -RTS Analysis.utf8.md --to html --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash --output Analysis.html --smart --email-obfuscation none --self-contained --standalone --section-divs --template /Library/Frameworks/R.framework/Versions/3.3/Resources/library/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --variable 'theme:bootstrap' --include-in-header /var/folders/df/2w6dv0r11pb69jhk8lzjjb_m0000gn/T//RtmpiTRiYR/rmarkdown-str1232f6a0f6170.html --mathjax --variable 'mathjax-url:https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML'
```
