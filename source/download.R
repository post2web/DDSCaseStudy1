# R code to download csv files for the project

install.packages("downloader", repos = structure(c(CRAN="http://cran.r-project.org"))) 
require(downloader)

#Download EDS Country data
download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv',
              destfile = file.path("..", "data", "EDSTATS_Country.csv"))
cat("EDS Country Data downloaded")

#Download GDP data
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", 
							destfile = file.path("..", "data", "GDP.csv"))
cat("GDP Data downloaded\n")