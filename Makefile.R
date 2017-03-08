#For reproducibility using Rstudio Version 1.0.136

#R code to clean the data that is called from CleanCaseStudyMakefile
#Clean EDS and GDP data for Case Study 1 in class Doing Data Science 6306-404
#Goal is to use Country Short Name in column 'AE' in the EDS STATS Country file as the main sort key to answer questions about income.

#set your working directory to where the parent Github directory is located on your computer.
#This needs to be unique for each person who downloads and runs the data. 

#change working directory to source folder
location <- getwd()
setwd(paste(location,"/source",sep=""))



#Download data from the webiste into and put into a data frame of the raw data

source("download.R")


#Cleans the EDS and GPD data frames removing bad and missing data.  
#Also, changes GDP data frame GDP column into numeric 
source("clean.R")

#Merges the two data frames into one data frames. 
#note still has NAs for GDP only because the assignment said to work around NAs.
source("merge.R")

#return working directory back to project parent directory
setwd(location)

#Run the R markdown file and code
library('rmarkdown')
rmarkdown::render(paste(location,"/EducationvsGDP.Rmd",sep=""))
