# platform independent path for the data dir
data_dir = paste('..', .Platform$file.sep, 'data', sep = '')
# load tidy country data
countries <- read.table(file.path(data_dir, "countries.csv"), header = TRUE)

# load tidy income_groups data
income_groups <- read.table(file.path(data_dir, "income_groups.csv"), header = TRUE)

# merged datasets
merged_data <- merge(countries, income_groups, by = 'CountryCode')

# write the resulting tidy data
write.table(merged_data, file.path(data_dir, "merged_data.csv"), row.names = FALSE)

cat("Data was merged\n")
