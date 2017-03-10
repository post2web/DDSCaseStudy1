# platform independent path for the data dir
data_dir = paste('..', .Platform$file.sep, 'data', sep = '')

#Read EDS Country file
file_obj = file(file.path(data_dir, "EDSTATS_Country.csv"))
df <- read.csv(file_obj, header = FALSE, sep = ',', skip = 5, nrows = 190)

# get a subset of rows with needed information
# THE numerical ids are not unique and are not needed for merging
df <- df[c('V1', 'V4', 'V5')]

# rename columns
names(df) <- c('CountryCode', 'CountryName', 'GDP')

# fix the encoding of the country names. Some have encoding problems
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
write.table(df, file.path(data_dir, "countries.csv"), row.names = FALSE)

cat("Country data was cleaned\n")
