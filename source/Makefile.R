#For reproducibility using Rstudio Version 1.0.136

#R code to clean the data that is called from CleanCaseStudyMakefile
#Clean EDS and GDP data for Case Study 1 in class Doing Data Science 6306-404
#Goal is to use Country Short Name in column 'AE' in the EDS STATS Country file as the main sort key to answer questions about income.

#This needs to be unique for each person who downloads and runs the data. 

setwd("C:/Users/Scott's/Documents/GitHub/DDSCaseStudy1/source")

#Download data from the webiste into and put into a data frame of the raw data
source("download.R")


#Cleans the EDS and GPD data frames removing bad and missing data.  
#Also, changes GDP data frame GDP column into numeric 
source("clean.R")

#Merges the two data frames into one data frames. 
#note still has NAs for GDP only because the assignment said to work around NAs.
source("merge.R")
