# R code to download csv files for the project

install.packages("downloader") 
require(downloader)

#Download EDS Country data
download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv',
              destfile = "../data/EDSTATS_Country.csv")
cat("EDS Country Data downloaded")

#Download GDP data
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", 
							destfile ="../data/GDP.csv")
cat("GDP Data downloaded")
