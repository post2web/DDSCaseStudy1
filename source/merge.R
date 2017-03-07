#For reproducibility using Rstudio Version 1.0.136

#R code to clean the data that is called from CleanCaseStudyMakefile
#Clean EDS and GDP data for Case Study 1 in class Doing Data Science 6306-404
#Goal is to use Country Short Name in column 'AE' in the EDS STATS Country file as the main sort key to answer questions about income.

#This needs to be unique for each person who downloads and runs the data. 
#setwd("/Users/laurabishop/Documents/Git Repositories/DDSCaseStudy1/data")

#Merge the EDSdata to the GPDdata into a new dataframe
EDSandGDPdata <- merge (EDSdata,GDPdata)