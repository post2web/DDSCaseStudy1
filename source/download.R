# R code to download csv files for the project

# attempt to install downloader only in case not installed
if("downloader" %in% rownames(installed.packages()) == FALSE){
  install.packages("downloader", repos = structure(c(CRAN="http://cran.r-project.org")))
}
# load package downloader
require(downloader)

#Download EDS Country data
download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv',
              destfile = file.path("..", "data", "EDSTATS_Country.csv"))
cat("EDS Country Data downloaded")

#Download GDP data
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", 
							destfile = file.path("..", "data", "GDP.csv"))
cat("GDP Data downloaded\n")
