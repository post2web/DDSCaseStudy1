# Makefile

download data files

```r
source(file.path("source", "download.R"))
```

```
## Loading required package: downloader
```

```
## EDS Country Data downloadedGDP Data downloaded
```
Tidy data

```r
source(file.path("source", "clean_gdp.R"))
```

```
## Loading required package: stringi
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
Merge data

```r
source(file.path("source", "merge.R"))
```

```
## Data was merged
```


Render the Analysis

```r
rmarkdown::render("Analysis.Rmd")
```

```
## 
## 
## processing file: Analysis.Rmd
```

```
## 
  |                                                                       
  |                                                                 |   0%
  |                                                                       
  |.....                                                            |   8%
##   ordinary text without R code
## 
## 
  |                                                                       
  |..........                                                       |  15%
## label: unnamed-chunk-1 (with options) 
## List of 1
##  $ echo: logi FALSE
## 
## 
  |                                                                       
  |...............                                                  |  23%
##   ordinary text without R code
## 
## 
  |                                                                       
  |....................                                             |  31%
## label: unnamed-chunk-2
## 
  |                                                                       
  |.........................                                        |  38%
##   ordinary text without R code
## 
## 
  |                                                                       
  |..............................                                   |  46%
## label: unnamed-chunk-3
## 
  |                                                                       
  |...................................                              |  54%
##   ordinary text without R code
## 
## 
  |                                                                       
  |........................................                         |  62%
## label: unnamed-chunk-4
## 
  |                                                                       
  |.............................................                    |  69%
##   ordinary text without R code
## 
## 
  |                                                                       
  |..................................................               |  77%
## label: kable
```

```
## 
  |                                                                       
  |.......................................................          |  85%
##   ordinary text without R code
## 
## 
  |                                                                       
  |............................................................     |  92%
## label: unnamed-chunk-5
## 
  |                                                                       
  |.................................................................| 100%
##   ordinary text without R code
```

```
## output file: Analysis.knit.md
```

```
## /Applications/RStudio.app/Contents/MacOS/pandoc/pandoc +RTS -K512m -RTS Analysis.utf8.md --to html --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash --output Analysis.html --smart --email-obfuscation none --self-contained --standalone --section-divs --template /Library/Frameworks/R.framework/Versions/3.3/Resources/library/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --variable 'theme:bootstrap' --include-in-header /var/folders/df/2w6dv0r11pb69jhk8lzjjb_m0000gn/T//Rtmp2QZvW2/rmarkdown-str79e12e49db80.html --mathjax --variable 'mathjax-url:https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML'
```

```
## 
## Output created: Analysis.html
```

