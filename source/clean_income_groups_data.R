# platform independent path for the data dir
data_dir = paste('..', .Platform$file.sep, 'data', sep = '')

#Read the GDP csv file
df <- read.csv(file.path(data_dir, "GDP.csv"), header = TRUE, encoding='UTF-8')

# To answer all the questions we need:
# CountryCode - to merge
# Income.Group - to answer the questions
df <- df[, c('CountryCode', 'Income.Group')]

# trim empty space in all columns
df <- data.frame(lapply(df, trimws))

# write the resulting tidy data
write.table(df, file.path(data_dir, "income_groups.csv"), row.names = FALSE)

cat("Income grpus data was cleaned\n")

