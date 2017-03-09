# R code to download csv files for the project

install.packages("downloader", repos = structure(c(CRAN="http://cran.r-project.org"))) 
require(downloader)

if (.Platform$OS.type == 'unix') {
  data_path = '../data/'
} else {
  data_path = '..\\data\\'
}

#Download EDS Country data
download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv',
              destfile = paste(data_path, "EDSTATS_Country.csv", sep = ''))
cat("EDS Country Data downloaded")

#Download GDP data
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", 
							destfile = paste(data_path, "GDP.csv", sep = ''))

cat("GDP Data downloaded\n")
