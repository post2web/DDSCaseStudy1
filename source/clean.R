cat ("Looking at the raw data\n")

class(EDSraw)
str(EDSraw)
head (EDSraw, 10)
tail (EDSraw, 10)
summary (EDSraw)
dim(EDSraw)

#Pulling only the data we need for the Case Study - Country Code, Short Name, Long Name, Income Group and rearranging for readability
cols <- c(1:3, 31)
EDSdata <- EDSraw [1:234, cols]
names (EDSdata)
str(EDSdata$Income.Group)
EDSdata<- subset(EDSdata, select=c(CountryCode, Short.Name, Long.Name, Income.Group))

cat ("Start the clean up and keep only necessary variables\n This includes Country Code, Long Name, Income Group, Short Name")


#Making string variables characters and numeric variables integers.  NOT SURE I REALLY NEED TO DO THIS> 
#EDSdata$CountryCode <-(as.character(EDSdata$CountryCode))
#EDSdata$Short.Name <- (as.character(EDSdata$Short.Name))
#EDSdata$Long.Name <- (as.character (EDSdata$Long.Name))

str(EDSdata$CountryCode)
str(EDSdata$Short.Name)
str(EDSdata$Long.Name)
#cat ("Made character variables characgter types\n")

EDSdata <- arrange (EDSdata, Short.Name)
EDSdata <- EDSdata [order (EDSdata$Short.Name, EDSdata$Income.Group),]
cat ("Arranged data alphabetically by Country Short Name in descending order and then by Income Groups\n")



#Removing Regional Observations like Euro area, Europe & Central Asia
EDSdata <- subset (x=EDSdata, Short.Name != "West Bank and Gaza")
EDSdata <- subset (x=EDSdata, Short.Name != "World")
EDSdata <- subset (x=EDSdata, Short.Name != "Sub-Saharan Africa (all income levels)")
EDSdata <- subset (x=EDSdata, Short.Name != "Sub-Saharan Africa (developing only)")
EDSdata <- subset (x=EDSdata, Short.Name != "S\xe3o Tom\xe9 and Principe")
EDSdata <- subset (x=EDSdata, Short.Name != "Middle East & North Africa (developing only)")
EDSdata <- subset (x=EDSdata, Short.Name != "Middle East & North Africa (all income levels)")
EDSdata <- subset (x=EDSdata, Short.Name != "Low & middle income")
EDSdata <- subset (x=EDSdata, Short.Name != "Lower middle income")
EDSdata <- subset (x=EDSdata, Short.Name != "Low income")
EDSdata <- subset (x=EDSdata, Short.Name != "Least developed countries: UN classification")
EDSdata <- subset (x=EDSdata, Short.Name != "Latin America & Caribbean (all income levels)")
EDSdata <- subset (x=EDSdata, Short.Name != "Middle income")
EDSdata <- subset (x=EDSdata, Short.Name != "Latin America & Caribbean (developing only)")
EDSdata <- subset (x=EDSdata, Short.Name != "Heavily indebted poor countries (HIPC)")
EDSdata <- subset (x=EDSdata, Short.Name != "High income")
EDSdata <- subset (x=EDSdata, Short.Name != "Latin America & Caribbean (developing only)")
EDSdata <- subset (x=EDSdata, Short.Name != "Euro area")
EDSdata <- subset (x=EDSdata, Short.Name != "Europe & Central Asia (developing only)")
EDSdata <- subset (x=EDSdata, Short.Name != "Europe & Central Asia (all income levels)")
EDSdata <- subset (x=EDSdata, Short.Name != "East Asia & Pacific (developing only)")
EDSdata <- subset (x=EDSdata, Short.Name != "East Asia & Pacific (all income levels)")
EDSdata <- subset (x=EDSdata, Short.Name != "C\xf4te d'Ivoire")
EDSdata <- subset (x=EDSdata, Short.Name != "Upper middle income")
EDSdata <- subset (x=EDSdata, Short.Name != "High income: nonOECD")
EDSdata <- subset (x=EDSdata, Short.Name != "High income: OECD")
EDSdata <- subset (x=EDSdata, Short.Name != "North America")
EDSdata <- subset (x=EDSdata, Short.Name != "South Asia")
cat ("Removed non country Short Names\n")
str(EDSdata)

cat ("Looking at the raw data\n")

class(GDPraw)
str(GDPraw)
head (GDPraw, 10)
tail (GDPraw, 10)
summary (GDPraw)
dim(GDPraw)

#Remove the first 4 Rows that are not needed.
GDPdata <- GDPraw [-c(1:4), ]
head(GDPdata, 10)

#Remove the bottom of GDPclean comments and  area GDP list, ie world, sub-sahara, east asiaa & pacific, etc. 
GDPdata <- GDPdata[-237:-216,]

#Remove the the unused columns from the data.frame (using keep as the variable we change to drop the columns)
keep <- c(1,5)
GDPdata <- GDPdata[,keep]

#Name columns COuntrycode and GPD
colnames(GDPdata) <- c("CountryCode","GDP")


#Remove commas from the GDP, first change GDPdata$GDP to character string, then remove the commas, finally convert to numeric
GDPdata$GDP <- as.character(GDPdata$GDP)
GDPdata$GDP <- gsub(",","", GDPdata$GDP)
GDPdata$GDP <- as.numeric(GDPdata$GDP)

#Remove empty lines from data frames
GDPdata <- subset (x=GDPdata, CountryCode !="")


