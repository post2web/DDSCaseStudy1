# this ensures paths will work on windows
if (.Platform$OS.type == 'unix') {
  data_path = '../data/'
} else {
  data_path = '..\\data\\'
}

#Read EDS Country file
file_obj = file(paste(data_path, "EDSTATS_Country.csv", sep = ''))
df <- read.csv(file_obj, header = FALSE, sep = ',', skip = 5, nrows = 190)

# get a subset of rows with needed information
# THE numerical ids are not unique and are not needed for merging
df <- df[c('V1', 'V4', 'V5')]

# rename columns
names(df) <- c('CountryCode', 'CountryName', 'GDP')

# fix in encoding
library(stringi)
df$CountryName <- stri_encode(df$CountryName, "", "UTF-8")
df$CountryName <- stri_trans_general(df$CountryName, "Latin-ASCII")


# trim empty space in CountryCode, CountryName and GDP
df <- data.frame(lapply(df, trimws))

# convert GDP to numeric
df$GDP <- gsub(",","", df$GDP)
df$GDP <- as.numeric(df$GDP)

# ensure that there is no NANs in GDP
df <- df[is.finite(df$GDP), ]

# write the resulting tidy data
write.table(df, paste(data_path, "countries.csv", sep = ''), row.names = FALSE)

cat("Country data was cleaned\n")
