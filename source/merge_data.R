# this ensures paths will work on windows
if (.Platform$OS.type == 'unix') {
  data_path = '../data/'
} else {
  data_path = '..\\data\\'
}

# load tidy country data
countries <- read.table(paste(data_path, "countries.csv", sep = ''), header = TRUE)

# load tidy income_groups data
income_groups <- read.table(paste(data_path, "income_groups.csv", sep = ''), header = TRUE)

# merged datasets
merged_data <- merge(countries, income_groups, by = 'CountryCode')

# write the resulting tidy data
write.table(merged_data, paste(data_path, "merged_data.csv", sep = ''), row.names = FALSE)

cat("Data was merged\n")