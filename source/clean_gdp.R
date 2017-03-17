# This file is used to clean gdp.csv into gdp_tidy.csv
# In order to run this file you need to have R Working Directory set to the root of the project.
# Authors: Ivelin Angelov, Laura Bishop, Ethan Graham, Scott Gozdzialski

# Read EDS Country file
file_obj = file(file.path('data', "gdp.csv"))
df <- read.csv(file_obj, header = FALSE, sep = ',', skip = 5, nrows = 190)

# To answer all the questions for the Case Study 1 we only need columns: 'CountryCode', 'CountryName', and 'GDP'
# Get a subset of the needed columns:
df <- df[c('V1', 'V4', 'V5')]

# Rename the columns
names(df) <- c('CountryCode', 'CountryName', 'GDP')

# install stringi in case its not
if("stringi" %in% rownames(installed.packages()) == FALSE){
  install.packages("stringi", repos = structure(c(CRAN = "http://cran.r-project.org")))
}
# Load stringi if not loaded. 
# This package includes function stri_encode needed for fixing the encoding
require(stringi)
# Fix the encoding of the country names. The HTML tables will raise an error if there is encoding problems.
df$CountryName <- stri_encode(df$CountryName, "", "UTF-8")
df$CountryName <- stri_trans_general(df$CountryName, "Latin-ASCII")

# Trim empty space in CountryCode, CountryName and GDP. This would fix eventual merging and output problems.
df <- data.frame(lapply(df, trimws))

# Convert GDP to numeric
df$GDP <- gsub(",","", df$GDP)
df$GDP <- as.numeric(df$GDP)

# Since the GDP is what our analysis are based on, we want to exclude all rows without GDP value.
# Ensure that there is no NANs in GDP.
df <- df[is.finite(df$GDP), ]   
# In our case there were no rows filtered.

# Write the resulting tidy data into file data/gdp_tidy.csv
write.table(df, file.path('data', "gdp_tidy.csv"), row.names = FALSE)

cat("Country data was cleaned\n")