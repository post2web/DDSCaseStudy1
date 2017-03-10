# this file is used to merge income_groups_tidy.csv + gdp_tidy.csv -> merged_data.csv
# platform independent path for the data dir

# load tidy country data
gdp <- read.table(file.path('data', "gdp_tidy.csv"), header = TRUE)

# load tidy income_groups data
income_groups <- read.table(file.path('data', "income_groups_tidy.csv"), header = TRUE)

# merged datasets
merged_data <- merge(gdp, income_groups, by = 'CountryCode')

# write the resulting tidy data
write.table(merged_data, file.path('data', "merged_data.csv"), row.names = FALSE)

cat("Data was merged\n")

