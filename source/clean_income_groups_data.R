# this ensures paths will work on windows
if (.Platform$OS.type == 'unix') {
  data_path = '../data/'
} else {
  data_path = '..\\data\\'
}

#Read the GDP csv file
df <- read.csv(paste(data_path, "GDP.csv", sep = ''), header = TRUE)

# To answer all the questions we need:
# CountryCode - to merge
# Income.Group - to answer the questions
df <- df[, c('CountryCode', 'Income.Group')]

# trim empty space in CountryCode, CountryName and GDP
df <- data.frame(lapply(df, trimws))

# write the resulting tidy data
write.table(df, paste(data_path, "income_groups.csv", sep = ''), sep = ',', row.names = FALSE)
