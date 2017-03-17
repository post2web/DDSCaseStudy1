# Gross Domestic Product Analysis
Ivelin Angelov, Laura Bishop, Ethan Graham, Scott Gozdzialski  
10-03-2017  


# Introduction
The global economy is accelerating at a rapid pace.
The World Bank, which is the world's largest development institution, looks at influencing factors like climate change, conflict, food security, education, agriculture, finance, and trade.
Questions are being asked about Gross Domestic Product (GDP) and Income categories for 189 countries in which there is sufficient data to analyze. 

The data source for this analysis is from the World Bank's Education Statistics (http://datatopics.worldbank.org/education/) web site for basic information on a country, including income grouping, date of last census data, systems of trade, government accounting approach, and many others basic data points except GDP. The GDP information, also from the World Bank, is not a part of the Education Statistics information collection and dissemination. 

It is important to note that the World Bank's Education Statistics (EDSstat) does differentiate between countries that participate in the Organization of Economic Cooperation and Development (OECD). The OECD was founded in 1960 and contains 35 member countries today, including the United States, United Kingdom, and Germany.
The goal of this organization is to help developing countries create and sustain economic prosperity.
In this analysis, the  "Income Group" used in the ranking of GDP for a country does contain an indicator of whether a high income country is part of the OECD.<br/>

This analysis takes a closer look at the relationship between GDP and Income Groups.

## 1. With the merged data frame how many IDs matched?

Merging the Data from the EDStats with the GDP data, it is expected that some of the row will not perfectly match up.
Looking at the data from both sets and merging them together we end up with some data points that do not have information in the GDP, so we did not include those values in the data.


```r
cat('There are', nrow(Data), 'rows of clean merged data for further analysis.')
```

```
## There are 189 rows of clean merged data for further analysis.
```


## 2. With the the data frame in decending order by GDP(United States last) what is the 13th value?
So you maybe wondering where different countries lie within this list of countries or what country lies in which position.
Here is an example of which county lie at the thirteenth position if we order the data in decending order.
This lists row in unordered data frame, three letter country code, countyr name, GDP in millions of US dollars, and finaly which  Organization of Economic Cooperation and Developement group it belongs.


```r
# reorder by GDP
Data = Data[order(Data$GDP),]
# print 13-th
cat('The 13th country in the sorted dataset is:', as.character(Data$CountryName[13]))
```

```
## The 13th country in the sorted dataset is: St. Kitts and Nevis
```

## 3. What are the average GDP rankings for the "High Income: OECD" and "High Income:nonOECD" groups?

We have talked about different groups as classified by the Organization of Economic Cooperation and Development (OECD).
There are five different groups.
They are the high income and member of the OECD, the high income and non-member OECD, the upper middle income, the middle income, and the low income groups.
Now for us to look if there is a difference between being a member of the OECD makes a difference the only way we can do that is by comparing the the average incomes of the high income OECD to the high income nonOECD, since they are the only groups with a counter part.<br/> 


```r
Data$GDP.rankings = rank(Data$GDP)
OECD_rankings = Data$GDP.rankings[Data$Income.Group == "High income: OECD"]
cat('The "High income: OECD" group has an average GDP of', mean(OECD_rankings),'millions in US dollars.')
```

```
## The "High income: OECD" group has an average GDP of 157.0333 millions in US dollars.
```

```r
nonOECD_rankings = Data$GDP.rankings[Data$Income.Group == "High income: nonOECD"]
cat('The high income nonOECD group had an average GDP of', mean(nonOECD_rankings), 'millions in US dollars.')
```

```
## The high income nonOECD group had an average GDP of 98.34783 millions in US dollars.
```
You can see the OECD group has a higher average GDP.

## 4.1 Plot the GDP for all of the countries. Use ggplot2 to color your plot by Income Group.

It is hard to visualize all the data of the countries we have in our data frame in our minds.
To help with this we will plot that different groups in a chart below.

```r
# Load needed packages
require(ggplot2)
# Allows for setting up the ggplot
require(scales) 
# For conclusion
require (Hmisc) 
# For histograms in conclusion
require (lattice) 

# Gets rid of the exponential numbers on the Y axis
options(scipen=10000)  

# Sets up GGPLOT2 scatter plot
ggplot (Data, aes(x=Data$Income.Group, y=Data$GDP)) + 
  # Sets up Y axis with labels and range
  scale_y_continuous(
    name="GDP -- In USD$ Millions",
    labels= scales::comma,
    expand = c(0,0),
    limits=c(0, 20000000),
    breaks=seq(0,18000000, 2000000)
    ) + 
  # Sets up x axis for abbreviates of categorical variable to prevent overlap and promote readability
  scale_x_discrete(
    "Income Group",
    labels = c("Low income" = "LI", "High income: nonOECD" = "nHI", "High income: OECD" = "oHI", "Lower middle income" = "LMI", "Upper middle income" = "UMI")
    ) + 
  # Sets up aspect ratio so consistent with each output
  theme(aspect.ratio = 2/1) + 
  # Sets up colored points
  geom_point(aes(color = Data$Income.Group)) +  
  # Changes legend title
  scale_color_discrete (name="Income Group")
```

![](Analysis_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

## 5. Cut the GDP rankings into 5 seperate quantile groups. Making a table versus income group. How many countries are "lower middle income" but within the 38 nations with the highest GDP?
Looking at the chart above we can see that the groups are not built on GDP alone.
The selection into the igh income and member of the OECD, the high income and non-member OECD, the upper middle income, the middle income, and the low income groups come from many variables.
With this knowledge we can see that some members of the lower income groups may have the higher GDP then members of the high income group.
So, how many of the countries in the top 38 GDPs are actual in the lower middle income?  


```r
# Split the rankings to 5 quantile groups
OrderData <- Data[order(Data$GDP.rankings), c(1:4)]
colNames <- c("Country Name", "Country Code", "GDP in Millions USD$", "Income Group")
# Load the thml table package
require('htmlTable')
# Print a table
htmlTable(
  OrderData[c('CountryName', 'CountryCode', 'GDP', 'Income.Group')],
  caption = "Ranking in Income Groups"
)
```

<!--html_preserve--><table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='5' style='text-align: left;'>
Ranking in Income Groups</td></tr>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>CountryName</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>CountryCode</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>GDP</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Income.Group</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>173</td>
<td style='text-align: center;'>Tuvalu</td>
<td style='text-align: center;'>TUV</td>
<td style='text-align: center;'>40</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>92</td>
<td style='text-align: center;'>Kiribati</td>
<td style='text-align: center;'>KIR</td>
<td style='text-align: center;'>175</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>113</td>
<td style='text-align: center;'>Marshall Islands</td>
<td style='text-align: center;'>MHL</td>
<td style='text-align: center;'>182</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>137</td>
<td style='text-align: center;'>Palau</td>
<td style='text-align: center;'>PLW</td>
<td style='text-align: center;'>228</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>155</td>
<td style='text-align: center;'>S�o Tom� and Principe</td>
<td style='text-align: center;'>STP</td>
<td style='text-align: center;'>263</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>59</td>
<td style='text-align: center;'>Micronesia, Fed. Sts.</td>
<td style='text-align: center;'>FSM</td>
<td style='text-align: center;'>326</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>169</td>
<td style='text-align: center;'>Tonga</td>
<td style='text-align: center;'>TON</td>
<td style='text-align: center;'>472</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>46</td>
<td style='text-align: center;'>Dominica</td>
<td style='text-align: center;'>DMA</td>
<td style='text-align: center;'>480</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>39</td>
<td style='text-align: center;'>Comoros</td>
<td style='text-align: center;'>COM</td>
<td style='text-align: center;'>596</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>184</td>
<td style='text-align: center;'>Samoa</td>
<td style='text-align: center;'>WSM</td>
<td style='text-align: center;'>684</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>180</td>
<td style='text-align: center;'>St. Vincent and the Grenadines</td>
<td style='text-align: center;'>VCT</td>
<td style='text-align: center;'>713</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>69</td>
<td style='text-align: center;'>Grenada</td>
<td style='text-align: center;'>GRD</td>
<td style='text-align: center;'>767</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>93</td>
<td style='text-align: center;'>St. Kitts and Nevis</td>
<td style='text-align: center;'>KNA</td>
<td style='text-align: center;'>767</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>183</td>
<td style='text-align: center;'>Vanuatu</td>
<td style='text-align: center;'>VUT</td>
<td style='text-align: center;'>787</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>66</td>
<td style='text-align: center;'>Guinea-Bissau</td>
<td style='text-align: center;'>GNB</td>
<td style='text-align: center;'>822</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>65</td>
<td style='text-align: center;'>Gambia, The</td>
<td style='text-align: center;'>GMB</td>
<td style='text-align: center;'>917</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>151</td>
<td style='text-align: center;'>Solomon Islands</td>
<td style='text-align: center;'>SLB</td>
<td style='text-align: center;'>1008</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>161</td>
<td style='text-align: center;'>Seychelles</td>
<td style='text-align: center;'>SYC</td>
<td style='text-align: center;'>1129</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>8</td>
<td style='text-align: center;'>Antigua and Barbuda</td>
<td style='text-align: center;'>ATG</td>
<td style='text-align: center;'>1134</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>100</td>
<td style='text-align: center;'>St. Lucia</td>
<td style='text-align: center;'>LCA</td>
<td style='text-align: center;'>1239</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>168</td>
<td style='text-align: center;'>Timor-Leste</td>
<td style='text-align: center;'>TMP</td>
<td style='text-align: center;'>1293</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>22</td>
<td style='text-align: center;'>Belize</td>
<td style='text-align: center;'>BLZ</td>
<td style='text-align: center;'>1493</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>99</td>
<td style='text-align: center;'>Liberia</td>
<td style='text-align: center;'>LBR</td>
<td style='text-align: center;'>1734</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>28</td>
<td style='text-align: center;'>Bhutan</td>
<td style='text-align: center;'>BTN</td>
<td style='text-align: center;'>1780</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>40</td>
<td style='text-align: center;'>Cape Verde</td>
<td style='text-align: center;'>CPV</td>
<td style='text-align: center;'>1827</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>30</td>
<td style='text-align: center;'>Central African Republic</td>
<td style='text-align: center;'>CAF</td>
<td style='text-align: center;'>2184</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>111</td>
<td style='text-align: center;'>Maldives</td>
<td style='text-align: center;'>MDV</td>
<td style='text-align: center;'>2222</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>102</td>
<td style='text-align: center;'>Lesotho</td>
<td style='text-align: center;'>LSO</td>
<td style='text-align: center;'>2448</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>12</td>
<td style='text-align: center;'>Burundi</td>
<td style='text-align: center;'>BDI</td>
<td style='text-align: center;'>2472</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>Aruba</td>
<td style='text-align: center;'>ABW</td>
<td style='text-align: center;'>2584</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>71</td>
<td style='text-align: center;'>Guyana</td>
<td style='text-align: center;'>GUY</td>
<td style='text-align: center;'>2851</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>52</td>
<td style='text-align: center;'>Eritrea</td>
<td style='text-align: center;'>ERI</td>
<td style='text-align: center;'>3092</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>160</td>
<td style='text-align: center;'>Swaziland</td>
<td style='text-align: center;'>SWZ</td>
<td style='text-align: center;'>3744</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>152</td>
<td style='text-align: center;'>Sierra Leone</td>
<td style='text-align: center;'>SLE</td>
<td style='text-align: center;'>3796</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>164</td>
<td style='text-align: center;'>Togo</td>
<td style='text-align: center;'>TGO</td>
<td style='text-align: center;'>3814</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>57</td>
<td style='text-align: center;'>Fiji</td>
<td style='text-align: center;'>FJI</td>
<td style='text-align: center;'>3908</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>120</td>
<td style='text-align: center;'>Mauritania</td>
<td style='text-align: center;'>MRT</td>
<td style='text-align: center;'>4199</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>26</td>
<td style='text-align: center;'>Barbados</td>
<td style='text-align: center;'>BRB</td>
<td style='text-align: center;'>4225</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>122</td>
<td style='text-align: center;'>Malawi</td>
<td style='text-align: center;'>MWI</td>
<td style='text-align: center;'>4264</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>117</td>
<td style='text-align: center;'>Montenegro</td>
<td style='text-align: center;'>MNE</td>
<td style='text-align: center;'>4373</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>156</td>
<td style='text-align: center;'>Suriname</td>
<td style='text-align: center;'>SUR</td>
<td style='text-align: center;'>5012</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>23</td>
<td style='text-align: center;'>Bermuda</td>
<td style='text-align: center;'>BMU</td>
<td style='text-align: center;'>5474</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>64</td>
<td style='text-align: center;'>Guinea</td>
<td style='text-align: center;'>GIN</td>
<td style='text-align: center;'>5632</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>108</td>
<td style='text-align: center;'>Monaco</td>
<td style='text-align: center;'>MCO</td>
<td style='text-align: center;'>6075</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>95</td>
<td style='text-align: center;'>Kosovo</td>
<td style='text-align: center;'>KSV</td>
<td style='text-align: center;'>6445</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>90</td>
<td style='text-align: center;'>Kyrgyz Republic</td>
<td style='text-align: center;'>KGZ</td>
<td style='text-align: center;'>6475</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>125</td>
<td style='text-align: center;'>Niger</td>
<td style='text-align: center;'>NER</td>
<td style='text-align: center;'>6773</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>166</td>
<td style='text-align: center;'>Tajikistan</td>
<td style='text-align: center;'>TJK</td>
<td style='text-align: center;'>6972</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>146</td>
<td style='text-align: center;'>Rwanda</td>
<td style='text-align: center;'>RWA</td>
<td style='text-align: center;'>7103</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>109</td>
<td style='text-align: center;'>Moldova</td>
<td style='text-align: center;'>MDA</td>
<td style='text-align: center;'>7253</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>14</td>
<td style='text-align: center;'>Benin</td>
<td style='text-align: center;'>BEN</td>
<td style='text-align: center;'>7557</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>75</td>
<td style='text-align: center;'>Haiti</td>
<td style='text-align: center;'>HTI</td>
<td style='text-align: center;'>7843</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>19</td>
<td style='text-align: center;'>Bahamas, The</td>
<td style='text-align: center;'>BHS</td>
<td style='text-align: center;'>8149</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>116</td>
<td style='text-align: center;'>Malta</td>
<td style='text-align: center;'>MLT</td>
<td style='text-align: center;'>8722</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>97</td>
<td style='text-align: center;'>Lao PDR</td>
<td style='text-align: center;'>LAO</td>
<td style='text-align: center;'>9418</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>114</td>
<td style='text-align: center;'>Macedonia, FYR</td>
<td style='text-align: center;'>MKD</td>
<td style='text-align: center;'>9613</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>189</td>
<td style='text-align: center;'>Zimbabwe</td>
<td style='text-align: center;'>ZWE</td>
<td style='text-align: center;'>9802</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>7</td>
<td style='text-align: center;'>Armenia</td>
<td style='text-align: center;'>ARM</td>
<td style='text-align: center;'>9951</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>110</td>
<td style='text-align: center;'>Madagascar</td>
<td style='text-align: center;'>MDG</td>
<td style='text-align: center;'>9975</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>118</td>
<td style='text-align: center;'>Mongolia</td>
<td style='text-align: center;'>MNG</td>
<td style='text-align: center;'>10271</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>115</td>
<td style='text-align: center;'>Mali</td>
<td style='text-align: center;'>MLI</td>
<td style='text-align: center;'>10308</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>15</td>
<td style='text-align: center;'>Burkina Faso</td>
<td style='text-align: center;'>BFA</td>
<td style='text-align: center;'>10441</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>121</td>
<td style='text-align: center;'>Mauritius</td>
<td style='text-align: center;'>MUS</td>
<td style='text-align: center;'>10486</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>127</td>
<td style='text-align: center;'>Nicaragua</td>
<td style='text-align: center;'>NIC</td>
<td style='text-align: center;'>10507</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>4</td>
<td style='text-align: center;'>Albania</td>
<td style='text-align: center;'>ALB</td>
<td style='text-align: center;'>12648</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>163</td>
<td style='text-align: center;'>Chad</td>
<td style='text-align: center;'>TCD</td>
<td style='text-align: center;'>12887</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>124</td>
<td style='text-align: center;'>Namibia</td>
<td style='text-align: center;'>NAM</td>
<td style='text-align: center;'>13072</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>82</td>
<td style='text-align: center;'>Iceland</td>
<td style='text-align: center;'>ISL</td>
<td style='text-align: center;'>13579</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>37</td>
<td style='text-align: center;'>Congo, Rep.</td>
<td style='text-align: center;'>COG</td>
<td style='text-align: center;'>13678</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>91</td>
<td style='text-align: center;'>Cambodia</td>
<td style='text-align: center;'>KHM</td>
<td style='text-align: center;'>14038</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>149</td>
<td style='text-align: center;'>Senegal</td>
<td style='text-align: center;'>SEN</td>
<td style='text-align: center;'>14046</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>119</td>
<td style='text-align: center;'>Mozambique</td>
<td style='text-align: center;'>MOZ</td>
<td style='text-align: center;'>14244</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>29</td>
<td style='text-align: center;'>Botswana</td>
<td style='text-align: center;'>BWA</td>
<td style='text-align: center;'>14504</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>85</td>
<td style='text-align: center;'>Jamaica</td>
<td style='text-align: center;'>JAM</td>
<td style='text-align: center;'>14755</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>138</td>
<td style='text-align: center;'>Papua New Guinea</td>
<td style='text-align: center;'>PNG</td>
<td style='text-align: center;'>15654</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>62</td>
<td style='text-align: center;'>Georgia</td>
<td style='text-align: center;'>GEO</td>
<td style='text-align: center;'>15747</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>27</td>
<td style='text-align: center;'>Brunei Darussalam</td>
<td style='text-align: center;'>BRN</td>
<td style='text-align: center;'>16954</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>187</td>
<td style='text-align: center;'>Congo, Dem. Rep.</td>
<td style='text-align: center;'>ZAR</td>
<td style='text-align: center;'>17204</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>20</td>
<td style='text-align: center;'>Bosnia and Herzegovina</td>
<td style='text-align: center;'>BIH</td>
<td style='text-align: center;'>17466</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>67</td>
<td style='text-align: center;'>Equatorial Guinea</td>
<td style='text-align: center;'>GNQ</td>
<td style='text-align: center;'>17697</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>60</td>
<td style='text-align: center;'>Gabon</td>
<td style='text-align: center;'>GAB</td>
<td style='text-align: center;'>18377</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>73</td>
<td style='text-align: center;'>Honduras</td>
<td style='text-align: center;'>HND</td>
<td style='text-align: center;'>18434</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>130</td>
<td style='text-align: center;'>Nepal</td>
<td style='text-align: center;'>NPL</td>
<td style='text-align: center;'>18963</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>175</td>
<td style='text-align: center;'>Uganda</td>
<td style='text-align: center;'>UGA</td>
<td style='text-align: center;'>19881</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>2</td>
<td style='text-align: center;'>Afghanistan</td>
<td style='text-align: center;'>AFG</td>
<td style='text-align: center;'>20497</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>188</td>
<td style='text-align: center;'>Zambia</td>
<td style='text-align: center;'>ZMB</td>
<td style='text-align: center;'>20678</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>54</td>
<td style='text-align: center;'>Estonia</td>
<td style='text-align: center;'>EST</td>
<td style='text-align: center;'>22390</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>43</td>
<td style='text-align: center;'>Cyprus</td>
<td style='text-align: center;'>CYP</td>
<td style='text-align: center;'>22767</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>170</td>
<td style='text-align: center;'>Trinidad and Tobago</td>
<td style='text-align: center;'>TTO</td>
<td style='text-align: center;'>23320</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>153</td>
<td style='text-align: center;'>El Salvador</td>
<td style='text-align: center;'>SLV</td>
<td style='text-align: center;'>23864</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>35</td>
<td style='text-align: center;'>C�te d'Ivoire</td>
<td style='text-align: center;'>CIV</td>
<td style='text-align: center;'>24680</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>36</td>
<td style='text-align: center;'>Cameroon</td>
<td style='text-align: center;'>CMR</td>
<td style='text-align: center;'>25322</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>142</td>
<td style='text-align: center;'>Paraguay</td>
<td style='text-align: center;'>PRY</td>
<td style='text-align: center;'>25502</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>24</td>
<td style='text-align: center;'>Bolivia</td>
<td style='text-align: center;'>BOL</td>
<td style='text-align: center;'>27035</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>174</td>
<td style='text-align: center;'>Tanzania</td>
<td style='text-align: center;'>TZA</td>
<td style='text-align: center;'>28242</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>105</td>
<td style='text-align: center;'>Latvia</td>
<td style='text-align: center;'>LVA</td>
<td style='text-align: center;'>28373</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>18</td>
<td style='text-align: center;'>Bahrain</td>
<td style='text-align: center;'>BHR</td>
<td style='text-align: center;'>29044</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>86</td>
<td style='text-align: center;'>Jordan</td>
<td style='text-align: center;'>JOR</td>
<td style='text-align: center;'>31015</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>167</td>
<td style='text-align: center;'>Turkmenistan</td>
<td style='text-align: center;'>TKM</td>
<td style='text-align: center;'>35164</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>185</td>
<td style='text-align: center;'>Yemen, Rep.</td>
<td style='text-align: center;'>YEM</td>
<td style='text-align: center;'>35646</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>134</td>
<td style='text-align: center;'>Panama</td>
<td style='text-align: center;'>PAN</td>
<td style='text-align: center;'>36253</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>154</td>
<td style='text-align: center;'>Serbia</td>
<td style='text-align: center;'>SRB</td>
<td style='text-align: center;'>37489</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>89</td>
<td style='text-align: center;'>Kenya</td>
<td style='text-align: center;'>KEN</td>
<td style='text-align: center;'>40697</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>63</td>
<td style='text-align: center;'>Ghana</td>
<td style='text-align: center;'>GHA</td>
<td style='text-align: center;'>40711</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>55</td>
<td style='text-align: center;'>Ethiopia</td>
<td style='text-align: center;'>ETH</td>
<td style='text-align: center;'>41605</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>103</td>
<td style='text-align: center;'>Lithuania</td>
<td style='text-align: center;'>LTU</td>
<td style='text-align: center;'>42344</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>98</td>
<td style='text-align: center;'>Lebanon</td>
<td style='text-align: center;'>LBN</td>
<td style='text-align: center;'>42945</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>106</td>
<td style='text-align: center;'>Macao SAR, China</td>
<td style='text-align: center;'>MAC</td>
<td style='text-align: center;'>43582</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>41</td>
<td style='text-align: center;'>Costa Rica</td>
<td style='text-align: center;'>CRI</td>
<td style='text-align: center;'>45104</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>158</td>
<td style='text-align: center;'>Slovenia</td>
<td style='text-align: center;'>SVN</td>
<td style='text-align: center;'>45279</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>171</td>
<td style='text-align: center;'>Tunisia</td>
<td style='text-align: center;'>TUN</td>
<td style='text-align: center;'>45662</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>177</td>
<td style='text-align: center;'>Uruguay</td>
<td style='text-align: center;'>URY</td>
<td style='text-align: center;'>49920</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>70</td>
<td style='text-align: center;'>Guatemala</td>
<td style='text-align: center;'>GTM</td>
<td style='text-align: center;'>50234</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>17</td>
<td style='text-align: center;'>Bulgaria</td>
<td style='text-align: center;'>BGR</td>
<td style='text-align: center;'>50972</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>179</td>
<td style='text-align: center;'>Uzbekistan</td>
<td style='text-align: center;'>UZB</td>
<td style='text-align: center;'>51113</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>104</td>
<td style='text-align: center;'>Luxembourg</td>
<td style='text-align: center;'>LUX</td>
<td style='text-align: center;'>55178</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>148</td>
<td style='text-align: center;'>Sudan</td>
<td style='text-align: center;'>SDN</td>
<td style='text-align: center;'>58769</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>48</td>
<td style='text-align: center;'>Dominican Republic</td>
<td style='text-align: center;'>DOM</td>
<td style='text-align: center;'>59047</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>74</td>
<td style='text-align: center;'>Croatia</td>
<td style='text-align: center;'>HRV</td>
<td style='text-align: center;'>59228</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>101</td>
<td style='text-align: center;'>Sri Lanka</td>
<td style='text-align: center;'>LKA</td>
<td style='text-align: center;'>59423</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>21</td>
<td style='text-align: center;'>Belarus</td>
<td style='text-align: center;'>BLR</td>
<td style='text-align: center;'>63267</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>11</td>
<td style='text-align: center;'>Azerbaijan</td>
<td style='text-align: center;'>AZE</td>
<td style='text-align: center;'>66605</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>42</td>
<td style='text-align: center;'>Cuba</td>
<td style='text-align: center;'>CUB</td>
<td style='text-align: center;'>68234</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>132</td>
<td style='text-align: center;'>Oman</td>
<td style='text-align: center;'>OMN</td>
<td style='text-align: center;'>69972</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>162</td>
<td style='text-align: center;'>Syrian Arab Republic</td>
<td style='text-align: center;'>SYR</td>
<td style='text-align: center;'>73672</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>50</td>
<td style='text-align: center;'>Ecuador</td>
<td style='text-align: center;'>ECU</td>
<td style='text-align: center;'>84040</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>157</td>
<td style='text-align: center;'>Slovak Republic</td>
<td style='text-align: center;'>SVK</td>
<td style='text-align: center;'>91149</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>107</td>
<td style='text-align: center;'>Morocco</td>
<td style='text-align: center;'>MAR</td>
<td style='text-align: center;'>95982</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>140</td>
<td style='text-align: center;'>Puerto Rico</td>
<td style='text-align: center;'>PRI</td>
<td style='text-align: center;'>101496</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>3</td>
<td style='text-align: center;'>Angola</td>
<td style='text-align: center;'>AGO</td>
<td style='text-align: center;'>114147</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>16</td>
<td style='text-align: center;'>Bangladesh</td>
<td style='text-align: center;'>BGD</td>
<td style='text-align: center;'>116355</td>
<td style='text-align: center;'>Low income</td>
</tr>
<tr>
<td style='text-align: left;'>76</td>
<td style='text-align: center;'>Hungary</td>
<td style='text-align: center;'>HUN</td>
<td style='text-align: center;'>124600</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>182</td>
<td style='text-align: center;'>Vietnam</td>
<td style='text-align: center;'>VNM</td>
<td style='text-align: center;'>155820</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>96</td>
<td style='text-align: center;'>Kuwait</td>
<td style='text-align: center;'>KWT</td>
<td style='text-align: center;'>160913</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>131</td>
<td style='text-align: center;'>New Zealand</td>
<td style='text-align: center;'>NZL</td>
<td style='text-align: center;'>167347</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>143</td>
<td style='text-align: center;'>Qatar</td>
<td style='text-align: center;'>QAT</td>
<td style='text-align: center;'>171476</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>176</td>
<td style='text-align: center;'>Ukraine</td>
<td style='text-align: center;'>UKR</td>
<td style='text-align: center;'>176309</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>144</td>
<td style='text-align: center;'>Romania</td>
<td style='text-align: center;'>ROM</td>
<td style='text-align: center;'>192711</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>44</td>
<td style='text-align: center;'>Czech Republic</td>
<td style='text-align: center;'>CZE</td>
<td style='text-align: center;'>196446</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>88</td>
<td style='text-align: center;'>Kazakhstan</td>
<td style='text-align: center;'>KAZ</td>
<td style='text-align: center;'>203521</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>135</td>
<td style='text-align: center;'>Peru</td>
<td style='text-align: center;'>PER</td>
<td style='text-align: center;'>203790</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>49</td>
<td style='text-align: center;'>Algeria</td>
<td style='text-align: center;'>DZA</td>
<td style='text-align: center;'>205789</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>81</td>
<td style='text-align: center;'>Iraq</td>
<td style='text-align: center;'>IRQ</td>
<td style='text-align: center;'>210280</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>79</td>
<td style='text-align: center;'>Ireland</td>
<td style='text-align: center;'>IRL</td>
<td style='text-align: center;'>210771</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>141</td>
<td style='text-align: center;'>Portugal</td>
<td style='text-align: center;'>PRT</td>
<td style='text-align: center;'>212274</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>133</td>
<td style='text-align: center;'>Pakistan</td>
<td style='text-align: center;'>PAK</td>
<td style='text-align: center;'>225143</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>56</td>
<td style='text-align: center;'>Finland</td>
<td style='text-align: center;'>FIN</td>
<td style='text-align: center;'>247546</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>68</td>
<td style='text-align: center;'>Greece</td>
<td style='text-align: center;'>GRC</td>
<td style='text-align: center;'>249099</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>136</td>
<td style='text-align: center;'>Philippines</td>
<td style='text-align: center;'>PHL</td>
<td style='text-align: center;'>250182</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>83</td>
<td style='text-align: center;'>Israel</td>
<td style='text-align: center;'>ISR</td>
<td style='text-align: center;'>258217</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>126</td>
<td style='text-align: center;'>Nigeria</td>
<td style='text-align: center;'>NGA</td>
<td style='text-align: center;'>262597</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>51</td>
<td style='text-align: center;'>Egypt, Arab Rep.</td>
<td style='text-align: center;'>EGY</td>
<td style='text-align: center;'>262832</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>72</td>
<td style='text-align: center;'>Hong Kong SAR, China</td>
<td style='text-align: center;'>HKG</td>
<td style='text-align: center;'>263259</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>33</td>
<td style='text-align: center;'>Chile</td>
<td style='text-align: center;'>CHL</td>
<td style='text-align: center;'>269869</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>150</td>
<td style='text-align: center;'>Singapore</td>
<td style='text-align: center;'>SGP</td>
<td style='text-align: center;'>274701</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>123</td>
<td style='text-align: center;'>Malaysia</td>
<td style='text-align: center;'>MYS</td>
<td style='text-align: center;'>305033</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>47</td>
<td style='text-align: center;'>Denmark</td>
<td style='text-align: center;'>DNK</td>
<td style='text-align: center;'>314887</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>5</td>
<td style='text-align: center;'>United Arab Emirates</td>
<td style='text-align: center;'>ARE</td>
<td style='text-align: center;'>348595</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>165</td>
<td style='text-align: center;'>Thailand</td>
<td style='text-align: center;'>THA</td>
<td style='text-align: center;'>365966</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>38</td>
<td style='text-align: center;'>Colombia</td>
<td style='text-align: center;'>COL</td>
<td style='text-align: center;'>369606</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>181</td>
<td style='text-align: center;'>Venezuela, RB</td>
<td style='text-align: center;'>VEN</td>
<td style='text-align: center;'>381286</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>186</td>
<td style='text-align: center;'>South Africa</td>
<td style='text-align: center;'>ZAF</td>
<td style='text-align: center;'>384313</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>10</td>
<td style='text-align: center;'>Austria</td>
<td style='text-align: center;'>AUT</td>
<td style='text-align: center;'>394708</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>6</td>
<td style='text-align: center;'>Argentina</td>
<td style='text-align: center;'>ARG</td>
<td style='text-align: center;'>475502</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>13</td>
<td style='text-align: center;'>Belgium</td>
<td style='text-align: center;'>BEL</td>
<td style='text-align: center;'>483262</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>139</td>
<td style='text-align: center;'>Poland</td>
<td style='text-align: center;'>POL</td>
<td style='text-align: center;'>489795</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>129</td>
<td style='text-align: center;'>Norway</td>
<td style='text-align: center;'>NOR</td>
<td style='text-align: center;'>499667</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>80</td>
<td style='text-align: center;'>Iran, Islamic Rep.</td>
<td style='text-align: center;'>IRN</td>
<td style='text-align: center;'>514060</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>159</td>
<td style='text-align: center;'>Sweden</td>
<td style='text-align: center;'>SWE</td>
<td style='text-align: center;'>523806</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>32</td>
<td style='text-align: center;'>Switzerland</td>
<td style='text-align: center;'>CHE</td>
<td style='text-align: center;'>631173</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>147</td>
<td style='text-align: center;'>Saudi Arabia</td>
<td style='text-align: center;'>SAU</td>
<td style='text-align: center;'>711050</td>
<td style='text-align: center;'>High income: nonOECD</td>
</tr>
<tr>
<td style='text-align: left;'>128</td>
<td style='text-align: center;'>Netherlands</td>
<td style='text-align: center;'>NLD</td>
<td style='text-align: center;'>770555</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>172</td>
<td style='text-align: center;'>Turkey</td>
<td style='text-align: center;'>TUR</td>
<td style='text-align: center;'>789257</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>77</td>
<td style='text-align: center;'>Indonesia</td>
<td style='text-align: center;'>IDN</td>
<td style='text-align: center;'>878043</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>94</td>
<td style='text-align: center;'>Korea, Rep.</td>
<td style='text-align: center;'>KOR</td>
<td style='text-align: center;'>1129598</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>112</td>
<td style='text-align: center;'>Mexico</td>
<td style='text-align: center;'>MEX</td>
<td style='text-align: center;'>1178126</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>53</td>
<td style='text-align: center;'>Spain</td>
<td style='text-align: center;'>ESP</td>
<td style='text-align: center;'>1322965</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>9</td>
<td style='text-align: center;'>Australia</td>
<td style='text-align: center;'>AUS</td>
<td style='text-align: center;'>1532408</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>31</td>
<td style='text-align: center;'>Canada</td>
<td style='text-align: center;'>CAN</td>
<td style='text-align: center;'>1821424</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>78</td>
<td style='text-align: center;'>India</td>
<td style='text-align: center;'>IND</td>
<td style='text-align: center;'>1841710</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>84</td>
<td style='text-align: center;'>Italy</td>
<td style='text-align: center;'>ITA</td>
<td style='text-align: center;'>2014670</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>145</td>
<td style='text-align: center;'>Russian Federation</td>
<td style='text-align: center;'>RUS</td>
<td style='text-align: center;'>2014775</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>25</td>
<td style='text-align: center;'>Brazil</td>
<td style='text-align: center;'>BRA</td>
<td style='text-align: center;'>2252664</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>61</td>
<td style='text-align: center;'>United Kingdom</td>
<td style='text-align: center;'>GBR</td>
<td style='text-align: center;'>2471784</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>58</td>
<td style='text-align: center;'>France</td>
<td style='text-align: center;'>FRA</td>
<td style='text-align: center;'>2612878</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>45</td>
<td style='text-align: center;'>Germany</td>
<td style='text-align: center;'>DEU</td>
<td style='text-align: center;'>3428131</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>87</td>
<td style='text-align: center;'>Japan</td>
<td style='text-align: center;'>JPN</td>
<td style='text-align: center;'>5959718</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>34</td>
<td style='text-align: center;'>China</td>
<td style='text-align: center;'>CHN</td>
<td style='text-align: center;'>8227103</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>178</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>United States</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>USA</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>16244600</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>High income: OECD</td>
</tr>
</tbody>
</table><!--/html_preserve-->

```r
top38 <- tail(Data, n = 38)
# An answer to the question: How many countries are "lower middle income" but within the 38 nations with the highest GDP
cat('There are', NROW(top38[top38$Income.Group == 'Lower middle income', ]), 'countries "lower middle income" but within the 38 nations with the highest GDP')
```

```
## There are 5 countries "lower middle income" but within the 38 nations with the highest GDP
```
## Conclusion
There are many factors that influence a country's GDP and overall prosperity.
This data analysis effort looks at GDP and the categories of Income Group as provided by the World Bank data.
Many thing were looked at in this analysis of Gross Domestic Products of different contries around the world.
This took multiple steps to get here.

The first thing we had to do was get the data in a clean a usable format.
The cleaning and merging of the different dataframes left us with some incomplete records so we had to determine the number of usable records before we could go further into this study, we had 189 usable records.<br/>

It was then time to look into specific question, we wanted to look at a specific data point from the data when ordered in a decending order, finding the 13th nation from the top when sorted in decending order is St. Kitts and Nevis.
Afterwards, we wanted to see amoungst the OECD and nonOECD groups was there a difference in their GDP, where we say the OECD high income group has a higher average GDP than the nonOECD high income gruop.
We then wanted to visualized the data.
Finally after seeing the data we were courious about how strong GDP is in the OECD scoring and checked the number of nations in the top 38 GDPs that were ranked in the OECD lower middle income group, which is 5.

###Conclusion

There are many factors that influence a country's GDP and overall prosperity.
This data analysis effort looks at GDP and the categories of Income Group as provided by the World Bank data.
The Income Group is made up of High Income: non OECD; High Income: OECD, Upper Middle Income; Lower Middle Income; and Low Income.
All conclusions were measured in millions of USD$.<br/>

Initial testing of this data includes a t-test, scatterplot and histogram of GDP.
For the mean GDP t-test, we reject the null hypothesis that GDP = 0 based on a 95% confidence level that the true GDP mean is between $170,839.4 Million and $588,353.7 Million (pvalue = 0.0004264).


```r
GDPmatrix <- matrix(Data$GDP)
t.test(GDPmatrix)
```

```
## 
## 	One Sample t-test
## 
## data:  GDPmatrix
## t = 3.587, df = 188, p-value = 0.0004264
## alternative hypothesis: true mean is not equal to 0
## 95 percent confidence interval:
##  170839.4 588353.7
## sample estimates:
## mean of x 
##  379596.5
```
  
The histogram of GDP shows a severe right skew, indicating an asysmetrical distribution.  


```r
col1 <- c("Min", "1st Qu.", "Median", "Mean", "3rd Qu.", "Max.")
summary(Data$GDP, "html", caption = "Summary Statistics of GDP", col.names=col1, align='c' )
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##       40     6972    28240   379600   205800 16240000
```

```r
hist(Data$GDP, breaks=5, main= "Histogram of GDP Data\n In Millions USD$", xlab = "GDP", ylab="Millions USD$", col="blue")
```

![](Analysis_files/figure-html/unnamed-chunk-8-1.png)<!-- -->
  
This is due to a few countries with large GDP, like the United States at $16,244,600 Million.
The right skewedness also indicates the mean is greater than the median, making the median at $28,240 Million a better overall indicator of GDP across the data set.<br/>

A smooth scatterplot of GDP does not visually confirm a linear relationship.  

```r
smoothScatter (Data$GDP, ylab="GDP in Millions USD$")
```

![](Analysis_files/figure-html/unnamed-chunk-9-1.png)<!-- -->
  
A second look at the category breakdown shows unexpected assignment of countries to Income Group categories.
Below is a subset of the Income Group by countries with a GDP greater than $1,000,000 Million.

```r
require('htmlTable')
cutoff <- Data[Data$GDP >= 1000000,]
htmlTable(
  cutoff[,-5:-6],
  caption = "Ranking in Income Groups"
)
```

<!--html_preserve--><table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='5' style='text-align: left;'>
Ranking in Income Groups</td></tr>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>CountryCode</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>CountryName</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>GDP</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Income.Group</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>94</td>
<td style='text-align: center;'>KOR</td>
<td style='text-align: center;'>Korea, Rep.</td>
<td style='text-align: center;'>1129598</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>112</td>
<td style='text-align: center;'>MEX</td>
<td style='text-align: center;'>Mexico</td>
<td style='text-align: center;'>1178126</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>53</td>
<td style='text-align: center;'>ESP</td>
<td style='text-align: center;'>Spain</td>
<td style='text-align: center;'>1322965</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>9</td>
<td style='text-align: center;'>AUS</td>
<td style='text-align: center;'>Australia</td>
<td style='text-align: center;'>1532408</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>31</td>
<td style='text-align: center;'>CAN</td>
<td style='text-align: center;'>Canada</td>
<td style='text-align: center;'>1821424</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>78</td>
<td style='text-align: center;'>IND</td>
<td style='text-align: center;'>India</td>
<td style='text-align: center;'>1841710</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='text-align: left;'>84</td>
<td style='text-align: center;'>ITA</td>
<td style='text-align: center;'>Italy</td>
<td style='text-align: center;'>2014670</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>145</td>
<td style='text-align: center;'>RUS</td>
<td style='text-align: center;'>Russian Federation</td>
<td style='text-align: center;'>2014775</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>25</td>
<td style='text-align: center;'>BRA</td>
<td style='text-align: center;'>Brazil</td>
<td style='text-align: center;'>2252664</td>
<td style='text-align: center;'>Upper middle income</td>
</tr>
<tr>
<td style='text-align: left;'>61</td>
<td style='text-align: center;'>GBR</td>
<td style='text-align: center;'>United Kingdom</td>
<td style='text-align: center;'>2471784</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>58</td>
<td style='text-align: center;'>FRA</td>
<td style='text-align: center;'>France</td>
<td style='text-align: center;'>2612878</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>45</td>
<td style='text-align: center;'>DEU</td>
<td style='text-align: center;'>Germany</td>
<td style='text-align: center;'>3428131</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>87</td>
<td style='text-align: center;'>JPN</td>
<td style='text-align: center;'>Japan</td>
<td style='text-align: center;'>5959718</td>
<td style='text-align: center;'>High income: OECD</td>
</tr>
<tr>
<td style='text-align: left;'>34</td>
<td style='text-align: center;'>CHN</td>
<td style='text-align: center;'>China</td>
<td style='text-align: center;'>8227103</td>
<td style='text-align: center;'>Lower middle income</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>178</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>USA</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>United States</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>16244600</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>High income: OECD</td>
</tr>
</tbody>
</table><!--/html_preserve-->
We see India with a GDP of $1,841,710 Million and yet its Income Group is Lower Middle Income.
Additionally, China is the second largest GDP in this list of 189 countries at $8,227,103 Million.
And yet, it is in the Lower Middle Income category as well.
It is unknown what other attributes contribute to the assigning of countries to Income Group subcategories.
As a warning, more information would be needed to explain the assignment to Income Group.<br/>

The better approach to test the significance of the GDP related to Income Group is to use the Krusal-Wallis test, which tests for statistical difference across the Income Groups based on median.
The Krusal- Wallis test indicates that the median of the five Income Groups are not the same (p-value= 0.000000000003617, df=4, chi-squared = 59.544).

```r
kruskal.test(Data$GDP ~ Data$Income.Group, data = Data)
```

```
## 
## 	Kruskal-Wallis rank sum test
## 
## data:  Data$GDP by Data$Income.Group
## Kruskal-Wallis chi-squared = 59.544, df = 4, p-value =
## 0.000000000003617
```
From this limited data, we can determine 

###Holding area:  TEMP!!   
How do i subset Data$Income.Group for only the 2 HIgh Income factors to run post hoc test against each other. I think there may be useful data in the increased GDP of OECD countries vs those that are not.

GDPmatrix <- matrix(Data$GDP)
rcorr (GDPmatrix, Data$Income.Group, type=c("pearson", "spearman"))
chisq.test (GDPmatrix)
