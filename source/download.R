#For reproducibility using Rstudio Version 1.0.136

#R code to clean the data that is called from CleanCaseStudyMakefile
#Clean EDS and GDP data for Case Study 1 in class Doing Data Science 6306-404
#Goal is to use Country Short Name in column 'AE' in the EDS STATS Country file as the main sort key to answer questions about income.

#This needs to be unique for each person who downloads and runs the data. 
#setwd("/Users/laurabishop/Documents/Git Repositories/DDSCaseStudy1/data")

#Download ESD data

install.packages("downloader") 
library (downloader)
install.packages ("dplyr")
library(dplyr)
install.packages("RCurl")
library(RCurl)

download.file ("https://raw.githubusercontent.com/post2web/DDSCaseStudy1/master/data/EDSTATS_Country.csv", 
							 destfile ="EDSTATS_CountryDown.csv")
cat ("EDS Country Data downloaded\n")

#Read EDS Country file
EDSraw <- read.csv ("EDSTATS_CountryDown.csv", header = TRUE, sep = ',')
cat ("EDS read into raw data file - EDSraw\n")

#Download GDP data
download.file ("https://raw.githubusercontent.com/post2web/DDSCaseStudy1/master/data/GDP.csv", 
							 destfile ="GDPdown.csv")
#Read GDP Country file
GDPraw <- read.csv ("GDPdown.csv", header = TRUE, sep = ',')
cat ("GDP read into raw data file - GDPraw\n")
