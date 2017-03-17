# This file is used to clean income_groups.csv into income_groups_tidy.csv
# In order to run this file you need to have R Working Directory set to the root of the project.
# Authors: Ivelin Angelov, Laura Bishop, Ethan Graham, Scott Gozdzialski

# Read the GDP csv file
df <- read.csv(file.path('data', "income_groups.csv"), header = TRUE, encoding='UTF-8')

# To answer all the questions for the Case Study 1 we only need two columns from this file:
## 1. CountryCode - to merge
## 2. Income.Group - to answer the questions
# In order to keep the files clean of extra unneeded data we are only keeping the two columns
df <- df[, c('CountryCode', 'Income.Group')]

# Trim empty space in all columns. This would fix eventual merging and output problems.
df <- data.frame(lapply(df, trimws))

# Write the resulting tidy data in file data/income_groups_tidy.csv
write.table(df, file.path('data', "income_groups_tidy.csv"), row.names = FALSE)

cat("Income grpus data was cleaned\n")