# this file is used to clean income_groups.csv -> income_groups_tidy.csv
# authors: Ivelin Angelov, Laura Bishop, Ethan Graham, Scott Gozdzialski

# Read the GDP csv file
df <- read.csv(file.path('data', "income_groups.csv"), header = TRUE, encoding='UTF-8')

# To answer all the questions we need:
# CountryCode - to merge
# Income.Group - to answer the questions
df <- df[, c('CountryCode', 'Income.Group')]

# trim empty space in all columns
df <- data.frame(lapply(df, trimws))

# write the resulting tidy data
write.table(df, file.path('data', "income_groups_tidy.csv"), row.names = FALSE)

cat("Income grpus data was cleaned\n")

