# R code to download csv files for the project
# to run this file you need to be in the root of the project

# attempt to install downloader only in case not installed
if("downloader" %in% rownames(installed.packages()) == FALSE){
  install.packages("downloader", repos = structure(c(CRAN="http://cran.r-project.org")))
}
# load package downloader
require(downloader)

#Download GDP data
url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
download.file(url = url, destfile = file.path("data", "gdp.csv"))
cat("EDS Country Data downloaded")

#Download Country grups data
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url = url,destfile = file.path("data", "income_groups.csv"))
cat("GDP Data downloaded\n")
