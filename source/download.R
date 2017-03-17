## This file is used for downloading all necessary for the project csv data files.
# In order to run this file you need to have R Working Directory set to the root of the project.
# Authors: Ivelin Angelov, Laura Bishop, Ethan Graham, Scott Gozdzialski

# Attempt to install downloader only in case not installed
if("downloader" %in% rownames(installed.packages()) == FALSE){
  install.packages("downloader", repos = structure(c(CRAN="http://cran.r-project.org")))
}
# Load package "downloader"
require(downloader)

# Download GDP data
url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
download.file(url = url, destfile = file.path("data", "gdp.csv"))
cat("GDP Data was downloaded successfully! \n")

# Download Country grups data
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url = url,destfile = file.path("data", "income_groups.csv"))
cat("EDS Country Data was downloaded successfully! \n")

