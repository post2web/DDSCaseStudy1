# This file is used to merge income_groups_tidy.csv + gdp_tidy.csv -> merged_data.csv
# In order to run this file you need to have R Working Directory set to the root of the project.
# Authors: Ivelin Angelov, Laura Bishop, Ethan Graham, Scott Gozdzialski

# Load tidy GDP data
gdp <- read.table(file.path('data', "gdp_tidy.csv"), header = TRUE)

# Load tidy income groups data
income_groups <- read.table(file.path('data', "income_groups_tidy.csv"), header = TRUE)

# Merged datasets on column "CountryCode"
merged_data <- merge(gdp, income_groups, by = 'CountryCode')

# Write the resulting tidy data into file data/merged_data.csv
write.table(merged_data, file.path('data', "merged_data.csv"), row.names = FALSE)

cat("Data was merged\n")