# Gross Domestic Product Analysis
Ivelin Angelov, Laura Bishop, Ethan Graham, Scott Gozdzialski  
10-03-2017  


#Introduction
The global economy is accelerating at a rapid pace.
The World Bank, which is the world's largest development institution, looks at influencing factors like climate change, conflict, food security, education, agriculture, finance, and trade.
Questions are being asked about Gross Domestic Product (GDP) and Income categories for 189 countries in which there is sufficient data to analyze. 

The data source for this analysis is from the World Bank's Education Statistics (http://datatopics.worldbank.org/education/) web site for basic information on a country, including income grouping, date of last census data, systems of trade, government accounting approach, and many others basic data points except GDP. The GDP information, also from the World Bank, is not a part of the Education Statistics information collection and dissemination. 

It is important to note that the World Bank's Education Statistics (EDSstat) does differentiate between countries that participate in the Organization of Economic Cooperation and Development (OECD). The OECD was founded in 1960 and contains 35 member countries today, including the United States, United Kingdom, and Germany.
The goal of this organization is to help developing countries create and sustain economic prosperity.
In this analysis, the  "Income Group" used in the ranking of GDP for a country does contain an indicator of whether a high income country is part of the OECD.<br/>

This analysis takes a closer look at the relationship between GDP and Income Groups.

###1. With the merged data frame how many IDs matched?

Merging the Data from the EDStats with the GDP data, it is expected that some of the row will not perfectly match up.
Looking at the data from both sets and merging them together we end up with some data points that do not have information in the GDP, so we did not include those values in the data.


```r
cat('There are', nrow(Data), 'rows of clean merged data for further analysis.')
```

```
## There are 189 rows of clean merged data for further analysis.
```


###2. With the the data frame in decending order by GDP(United States last) what is the 13th value?
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

###3. What are the average GDP rankings for the "High Income: OECD" and "High Income:nonOECD" groups?

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

###4. 1	Plot the GDP for all of the countries. Use ggplot2 to color your plot by Income Group.

It is hard to visualize all the data of the countries we have in our data frame in our minds.
To help with this we will plot that different groups in a chart below.

```r
# install ggplot2 and scales in case its not
if("ggplot2" %in% rownames(installed.packages()) == FALSE){
  install.packages("ggplot2", repos = structure(c(CRAN = "http://cran.r-project.org")))
}
if("scales" %in% rownames(installed.packages()) == FALSE){
  install.packages("scales", repos = structure(c(CRAN = "http://cran.r-project.org")))
}
if("Hmisc" %in% rownames(installed.packages()) == FALSE){
  install.packages("Hmisc", repos = structure(c(CRAN = "http://cran.r-project.org")))
}
if("lattice" %in% rownames(installed.packages()) == FALSE){
  install.packages("lattice", repos = structure(c(CRAN = "http://cran.r-project.org")))
}  
  
# load the packages
require(ggplot2)
```

```
## Loading required package: ggplot2
```

```r
require(scales)  # allows for setting up the ggplot
```

```
## Loading required package: scales
```

```r
require (Hmisc) # for conclusion
```

```
## Loading required package: Hmisc
```

```
## Loading required package: lattice
```

```
## Loading required package: survival
```

```
## Loading required package: Formula
```

```
## 
## Attaching package: 'Hmisc'
```

```
## The following objects are masked from 'package:base':
## 
##     format.pval, round.POSIXt, trunc.POSIXt, units
```

```r
require (lattice) # for histograms in conclusion

options(scipen=10000)  # gets rid of the exponential numbers on the Y axis

ggplot (Data, aes(x=Data$Income.Group, y=Data$GDP)) + # sets up GGPLOT2 scatter plot
  scale_y_continuous(name="GDP -- In USD$ Millions", labels= scales::comma, expand = c(0,0), limits=c(0, 20000000), breaks=seq(0,18000000, 2000000))  + #sets up Y axis with labels and range
  scale_x_discrete ("Income Group", labels = c("Low income" = "LI", "High income: nonOECD" = "nHI", "High income: OECD" = "oHI", "Lower middle income" = "LMI", "Upper middle income" = "UMI")) + # sets up x axis for abbreviates of categorical variable to prevent overlap and promote readability
  theme (aspect.ratio = 2/1) + #sets up aspect ratio so consistent with each output
  geom_point(aes(color = Data$Income.Group)) +  #sets up colored points
  scale_color_discrete (name="Income Group") #changes legend title
```

![](Analysis_files/figure-html/kable-1.png)<!-- -->

##5. Cut the GDP rankings into 5 seperate quantile groups. Making a table versus income group.
##   How many countries are "lower middle income" but within the 38 nations with the highest GDP?
Looking at the chart above we can see that the groups are not built on GDP alone.
The selection into the igh income and member of the OECD, the high income and non-member OECD, the upper middle income, the middle income, and the low income groups come from many variables.
With this knowledge we can see that some members of the lower income groups may have the higher GDP then members of the high income group.
So, how many of the countries in the top 38 GDPs are actual in the lower middle income?  


```r
if("DT" %in% rownames(installed.packages()) == FALSE){
  install.packages("DT", repos = structure(c(CRAN = "http://cran.r-project.org")))
}
require('DT')
```

```
## Loading required package: DT
```

```r
# Split the rankings to 5 quantile groups
OrderData <- Data[order(Data$GDP.rankings), c(1:4)]
colNames <- c("Country Name", "Country Code", "GDP in Millions USD$", "Income Group")
library(rhandsontable)
rhandsontable(
  OrderData[c('CountryName', 'CountryCode', 'GDP', 'Income.Group')],
  caption = "Ranking in Income Groups"
)
```

<!--html_preserve--><div id="htmlwidget-a72c08b3d0bc0fd3a674" style="width:672px;height:480px;" class="rhandsontable html-widget"></div>
<script type="application/json" data-for="htmlwidget-a72c08b3d0bc0fd3a674">{"x":{"data":[{"CountryName":"Tuvalu","CountryCode":"TUV","GDP":40,"Income.Group":"Lower middle income"},{"CountryName":"Kiribati","CountryCode":"KIR","GDP":175,"Income.Group":"Lower middle income"},{"CountryName":"Marshall Islands","CountryCode":"MHL","GDP":182,"Income.Group":"Lower middle income"},{"CountryName":"Palau","CountryCode":"PLW","GDP":228,"Income.Group":"Upper middle income"},{"CountryName":"S�o Tom� and Principe","CountryCode":"STP","GDP":263,"Income.Group":"Lower middle income"},{"CountryName":"Micronesia, Fed. Sts.","CountryCode":"FSM","GDP":326,"Income.Group":"Lower middle income"},{"CountryName":"Tonga","CountryCode":"TON","GDP":472,"Income.Group":"Lower middle income"},{"CountryName":"Dominica","CountryCode":"DMA","GDP":480,"Income.Group":"Upper middle income"},{"CountryName":"Comoros","CountryCode":"COM","GDP":596,"Income.Group":"Low income"},{"CountryName":"Samoa","CountryCode":"WSM","GDP":684,"Income.Group":"Lower middle income"},{"CountryName":"St. Vincent and the Grenadines","CountryCode":"VCT","GDP":713,"Income.Group":"Upper middle income"},{"CountryName":"Grenada","CountryCode":"GRD","GDP":767,"Income.Group":"Upper middle income"},{"CountryName":"St. Kitts and Nevis","CountryCode":"KNA","GDP":767,"Income.Group":"Upper middle income"},{"CountryName":"Vanuatu","CountryCode":"VUT","GDP":787,"Income.Group":"Lower middle income"},{"CountryName":"Guinea-Bissau","CountryCode":"GNB","GDP":822,"Income.Group":"Low income"},{"CountryName":"Gambia, The","CountryCode":"GMB","GDP":917,"Income.Group":"Low income"},{"CountryName":"Solomon Islands","CountryCode":"SLB","GDP":1008,"Income.Group":"Low income"},{"CountryName":"Seychelles","CountryCode":"SYC","GDP":1129,"Income.Group":"Upper middle income"},{"CountryName":"Antigua and Barbuda","CountryCode":"ATG","GDP":1134,"Income.Group":"Upper middle income"},{"CountryName":"St. Lucia","CountryCode":"LCA","GDP":1239,"Income.Group":"Upper middle income"},{"CountryName":"Timor-Leste","CountryCode":"TMP","GDP":1293,"Income.Group":"Lower middle income"},{"CountryName":"Belize","CountryCode":"BLZ","GDP":1493,"Income.Group":"Lower middle income"},{"CountryName":"Liberia","CountryCode":"LBR","GDP":1734,"Income.Group":"Low income"},{"CountryName":"Bhutan","CountryCode":"BTN","GDP":1780,"Income.Group":"Lower middle income"},{"CountryName":"Cape Verde","CountryCode":"CPV","GDP":1827,"Income.Group":"Lower middle income"},{"CountryName":"Central African Republic","CountryCode":"CAF","GDP":2184,"Income.Group":"Low income"},{"CountryName":"Maldives","CountryCode":"MDV","GDP":2222,"Income.Group":"Lower middle income"},{"CountryName":"Lesotho","CountryCode":"LSO","GDP":2448,"Income.Group":"Lower middle income"},{"CountryName":"Burundi","CountryCode":"BDI","GDP":2472,"Income.Group":"Low income"},{"CountryName":"Aruba","CountryCode":"ABW","GDP":2584,"Income.Group":"High income: nonOECD"},{"CountryName":"Guyana","CountryCode":"GUY","GDP":2851,"Income.Group":"Lower middle income"},{"CountryName":"Eritrea","CountryCode":"ERI","GDP":3092,"Income.Group":"Low income"},{"CountryName":"Swaziland","CountryCode":"SWZ","GDP":3744,"Income.Group":"Lower middle income"},{"CountryName":"Sierra Leone","CountryCode":"SLE","GDP":3796,"Income.Group":"Low income"},{"CountryName":"Togo","CountryCode":"TGO","GDP":3814,"Income.Group":"Low income"},{"CountryName":"Fiji","CountryCode":"FJI","GDP":3908,"Income.Group":"Upper middle income"},{"CountryName":"Mauritania","CountryCode":"MRT","GDP":4199,"Income.Group":"Low income"},{"CountryName":"Barbados","CountryCode":"BRB","GDP":4225,"Income.Group":"High income: nonOECD"},{"CountryName":"Malawi","CountryCode":"MWI","GDP":4264,"Income.Group":"Low income"},{"CountryName":"Montenegro","CountryCode":"MNE","GDP":4373,"Income.Group":"Upper middle income"},{"CountryName":"Suriname","CountryCode":"SUR","GDP":5012,"Income.Group":"Upper middle income"},{"CountryName":"Bermuda","CountryCode":"BMU","GDP":5474,"Income.Group":"High income: nonOECD"},{"CountryName":"Guinea","CountryCode":"GIN","GDP":5632,"Income.Group":"Low income"},{"CountryName":"Monaco","CountryCode":"MCO","GDP":6075,"Income.Group":"High income: nonOECD"},{"CountryName":"Kosovo","CountryCode":"KSV","GDP":6445,"Income.Group":"Lower middle income"},{"CountryName":"Kyrgyz Republic","CountryCode":"KGZ","GDP":6475,"Income.Group":"Low income"},{"CountryName":"Niger","CountryCode":"NER","GDP":6773,"Income.Group":"Low income"},{"CountryName":"Tajikistan","CountryCode":"TJK","GDP":6972,"Income.Group":"Low income"},{"CountryName":"Rwanda","CountryCode":"RWA","GDP":7103,"Income.Group":"Low income"},{"CountryName":"Moldova","CountryCode":"MDA","GDP":7253,"Income.Group":"Lower middle income"},{"CountryName":"Benin","CountryCode":"BEN","GDP":7557,"Income.Group":"Low income"},{"CountryName":"Haiti","CountryCode":"HTI","GDP":7843,"Income.Group":"Low income"},{"CountryName":"Bahamas, The","CountryCode":"BHS","GDP":8149,"Income.Group":"High income: nonOECD"},{"CountryName":"Malta","CountryCode":"MLT","GDP":8722,"Income.Group":"High income: nonOECD"},{"CountryName":"Lao PDR","CountryCode":"LAO","GDP":9418,"Income.Group":"Low income"},{"CountryName":"Macedonia, FYR","CountryCode":"MKD","GDP":9613,"Income.Group":"Upper middle income"},{"CountryName":"Zimbabwe","CountryCode":"ZWE","GDP":9802,"Income.Group":"Low income"},{"CountryName":"Armenia","CountryCode":"ARM","GDP":9951,"Income.Group":"Lower middle income"},{"CountryName":"Madagascar","CountryCode":"MDG","GDP":9975,"Income.Group":"Low income"},{"CountryName":"Mongolia","CountryCode":"MNG","GDP":10271,"Income.Group":"Lower middle income"},{"CountryName":"Mali","CountryCode":"MLI","GDP":10308,"Income.Group":"Low income"},{"CountryName":"Burkina Faso","CountryCode":"BFA","GDP":10441,"Income.Group":"Low income"},{"CountryName":"Mauritius","CountryCode":"MUS","GDP":10486,"Income.Group":"Upper middle income"},{"CountryName":"Nicaragua","CountryCode":"NIC","GDP":10507,"Income.Group":"Lower middle income"},{"CountryName":"Albania","CountryCode":"ALB","GDP":12648,"Income.Group":"Upper middle income"},{"CountryName":"Chad","CountryCode":"TCD","GDP":12887,"Income.Group":"Low income"},{"CountryName":"Namibia","CountryCode":"NAM","GDP":13072,"Income.Group":"Upper middle income"},{"CountryName":"Iceland","CountryCode":"ISL","GDP":13579,"Income.Group":"High income: OECD"},{"CountryName":"Congo, Rep.","CountryCode":"COG","GDP":13678,"Income.Group":"Lower middle income"},{"CountryName":"Cambodia","CountryCode":"KHM","GDP":14038,"Income.Group":"Low income"},{"CountryName":"Senegal","CountryCode":"SEN","GDP":14046,"Income.Group":"Lower middle income"},{"CountryName":"Mozambique","CountryCode":"MOZ","GDP":14244,"Income.Group":"Low income"},{"CountryName":"Botswana","CountryCode":"BWA","GDP":14504,"Income.Group":"Upper middle income"},{"CountryName":"Jamaica","CountryCode":"JAM","GDP":14755,"Income.Group":"Upper middle income"},{"CountryName":"Papua New Guinea","CountryCode":"PNG","GDP":15654,"Income.Group":"Lower middle income"},{"CountryName":"Georgia","CountryCode":"GEO","GDP":15747,"Income.Group":"Lower middle income"},{"CountryName":"Brunei Darussalam","CountryCode":"BRN","GDP":16954,"Income.Group":"High income: nonOECD"},{"CountryName":"Congo, Dem. Rep.","CountryCode":"ZAR","GDP":17204,"Income.Group":"Low income"},{"CountryName":"Bosnia and Herzegovina","CountryCode":"BIH","GDP":17466,"Income.Group":"Upper middle income"},{"CountryName":"Equatorial Guinea","CountryCode":"GNQ","GDP":17697,"Income.Group":"High income: nonOECD"},{"CountryName":"Gabon","CountryCode":"GAB","GDP":18377,"Income.Group":"Upper middle income"},{"CountryName":"Honduras","CountryCode":"HND","GDP":18434,"Income.Group":"Lower middle income"},{"CountryName":"Nepal","CountryCode":"NPL","GDP":18963,"Income.Group":"Low income"},{"CountryName":"Uganda","CountryCode":"UGA","GDP":19881,"Income.Group":"Low income"},{"CountryName":"Afghanistan","CountryCode":"AFG","GDP":20497,"Income.Group":"Low income"},{"CountryName":"Zambia","CountryCode":"ZMB","GDP":20678,"Income.Group":"Low income"},{"CountryName":"Estonia","CountryCode":"EST","GDP":22390,"Income.Group":"High income: nonOECD"},{"CountryName":"Cyprus","CountryCode":"CYP","GDP":22767,"Income.Group":"High income: nonOECD"},{"CountryName":"Trinidad and Tobago","CountryCode":"TTO","GDP":23320,"Income.Group":"High income: nonOECD"},{"CountryName":"El Salvador","CountryCode":"SLV","GDP":23864,"Income.Group":"Lower middle income"},{"CountryName":"C�te d'Ivoire","CountryCode":"CIV","GDP":24680,"Income.Group":"Lower middle income"},{"CountryName":"Cameroon","CountryCode":"CMR","GDP":25322,"Income.Group":"Lower middle income"},{"CountryName":"Paraguay","CountryCode":"PRY","GDP":25502,"Income.Group":"Lower middle income"},{"CountryName":"Bolivia","CountryCode":"BOL","GDP":27035,"Income.Group":"Lower middle income"},{"CountryName":"Tanzania","CountryCode":"TZA","GDP":28242,"Income.Group":"Low income"},{"CountryName":"Latvia","CountryCode":"LVA","GDP":28373,"Income.Group":"High income: nonOECD"},{"CountryName":"Bahrain","CountryCode":"BHR","GDP":29044,"Income.Group":"High income: nonOECD"},{"CountryName":"Jordan","CountryCode":"JOR","GDP":31015,"Income.Group":"Lower middle income"},{"CountryName":"Turkmenistan","CountryCode":"TKM","GDP":35164,"Income.Group":"Lower middle income"},{"CountryName":"Yemen, Rep.","CountryCode":"YEM","GDP":35646,"Income.Group":"Lower middle income"},{"CountryName":"Panama","CountryCode":"PAN","GDP":36253,"Income.Group":"Upper middle income"},{"CountryName":"Serbia","CountryCode":"SRB","GDP":37489,"Income.Group":"Upper middle income"},{"CountryName":"Kenya","CountryCode":"KEN","GDP":40697,"Income.Group":"Low income"},{"CountryName":"Ghana","CountryCode":"GHA","GDP":40711,"Income.Group":"Low income"},{"CountryName":"Ethiopia","CountryCode":"ETH","GDP":41605,"Income.Group":"Low income"},{"CountryName":"Lithuania","CountryCode":"LTU","GDP":42344,"Income.Group":"Upper middle income"},{"CountryName":"Lebanon","CountryCode":"LBN","GDP":42945,"Income.Group":"Upper middle income"},{"CountryName":"Macao SAR, China","CountryCode":"MAC","GDP":43582,"Income.Group":"High income: nonOECD"},{"CountryName":"Costa Rica","CountryCode":"CRI","GDP":45104,"Income.Group":"Upper middle income"},{"CountryName":"Slovenia","CountryCode":"SVN","GDP":45279,"Income.Group":"High income: OECD"},{"CountryName":"Tunisia","CountryCode":"TUN","GDP":45662,"Income.Group":"Lower middle income"},{"CountryName":"Uruguay","CountryCode":"URY","GDP":49920,"Income.Group":"Upper middle income"},{"CountryName":"Guatemala","CountryCode":"GTM","GDP":50234,"Income.Group":"Lower middle income"},{"CountryName":"Bulgaria","CountryCode":"BGR","GDP":50972,"Income.Group":"Upper middle income"},{"CountryName":"Uzbekistan","CountryCode":"UZB","GDP":51113,"Income.Group":"Lower middle income"},{"CountryName":"Luxembourg","CountryCode":"LUX","GDP":55178,"Income.Group":"High income: OECD"},{"CountryName":"Sudan","CountryCode":"SDN","GDP":58769,"Income.Group":"Lower middle income"},{"CountryName":"Dominican Republic","CountryCode":"DOM","GDP":59047,"Income.Group":"Upper middle income"},{"CountryName":"Croatia","CountryCode":"HRV","GDP":59228,"Income.Group":"High income: nonOECD"},{"CountryName":"Sri Lanka","CountryCode":"LKA","GDP":59423,"Income.Group":"Lower middle income"},{"CountryName":"Belarus","CountryCode":"BLR","GDP":63267,"Income.Group":"Upper middle income"},{"CountryName":"Azerbaijan","CountryCode":"AZE","GDP":66605,"Income.Group":"Upper middle income"},{"CountryName":"Cuba","CountryCode":"CUB","GDP":68234,"Income.Group":"Upper middle income"},{"CountryName":"Oman","CountryCode":"OMN","GDP":69972,"Income.Group":"High income: nonOECD"},{"CountryName":"Syrian Arab Republic","CountryCode":"SYR","GDP":73672,"Income.Group":"Lower middle income"},{"CountryName":"Ecuador","CountryCode":"ECU","GDP":84040,"Income.Group":"Lower middle income"},{"CountryName":"Slovak Republic","CountryCode":"SVK","GDP":91149,"Income.Group":"High income: OECD"},{"CountryName":"Morocco","CountryCode":"MAR","GDP":95982,"Income.Group":"Lower middle income"},{"CountryName":"Puerto Rico","CountryCode":"PRI","GDP":101496,"Income.Group":"High income: nonOECD"},{"CountryName":"Angola","CountryCode":"AGO","GDP":114147,"Income.Group":"Lower middle income"},{"CountryName":"Bangladesh","CountryCode":"BGD","GDP":116355,"Income.Group":"Low income"},{"CountryName":"Hungary","CountryCode":"HUN","GDP":124600,"Income.Group":"High income: OECD"},{"CountryName":"Vietnam","CountryCode":"VNM","GDP":155820,"Income.Group":"Lower middle income"},{"CountryName":"Kuwait","CountryCode":"KWT","GDP":160913,"Income.Group":"High income: nonOECD"},{"CountryName":"New Zealand","CountryCode":"NZL","GDP":167347,"Income.Group":"High income: OECD"},{"CountryName":"Qatar","CountryCode":"QAT","GDP":171476,"Income.Group":"High income: nonOECD"},{"CountryName":"Ukraine","CountryCode":"UKR","GDP":176309,"Income.Group":"Lower middle income"},{"CountryName":"Romania","CountryCode":"ROM","GDP":192711,"Income.Group":"Upper middle income"},{"CountryName":"Czech Republic","CountryCode":"CZE","GDP":196446,"Income.Group":"High income: OECD"},{"CountryName":"Kazakhstan","CountryCode":"KAZ","GDP":203521,"Income.Group":"Upper middle income"},{"CountryName":"Peru","CountryCode":"PER","GDP":203790,"Income.Group":"Upper middle income"},{"CountryName":"Algeria","CountryCode":"DZA","GDP":205789,"Income.Group":"Upper middle income"},{"CountryName":"Iraq","CountryCode":"IRQ","GDP":210280,"Income.Group":"Lower middle income"},{"CountryName":"Ireland","CountryCode":"IRL","GDP":210771,"Income.Group":"High income: OECD"},{"CountryName":"Portugal","CountryCode":"PRT","GDP":212274,"Income.Group":"High income: OECD"},{"CountryName":"Pakistan","CountryCode":"PAK","GDP":225143,"Income.Group":"Lower middle income"},{"CountryName":"Finland","CountryCode":"FIN","GDP":247546,"Income.Group":"High income: OECD"},{"CountryName":"Greece","CountryCode":"GRC","GDP":249099,"Income.Group":"High income: OECD"},{"CountryName":"Philippines","CountryCode":"PHL","GDP":250182,"Income.Group":"Lower middle income"},{"CountryName":"Israel","CountryCode":"ISR","GDP":258217,"Income.Group":"High income: OECD"},{"CountryName":"Nigeria","CountryCode":"NGA","GDP":262597,"Income.Group":"Lower middle income"},{"CountryName":"Egypt, Arab Rep.","CountryCode":"EGY","GDP":262832,"Income.Group":"Lower middle income"},{"CountryName":"Hong Kong SAR, China","CountryCode":"HKG","GDP":263259,"Income.Group":"High income: nonOECD"},{"CountryName":"Chile","CountryCode":"CHL","GDP":269869,"Income.Group":"Upper middle income"},{"CountryName":"Singapore","CountryCode":"SGP","GDP":274701,"Income.Group":"High income: nonOECD"},{"CountryName":"Malaysia","CountryCode":"MYS","GDP":305033,"Income.Group":"Upper middle income"},{"CountryName":"Denmark","CountryCode":"DNK","GDP":314887,"Income.Group":"High income: OECD"},{"CountryName":"United Arab Emirates","CountryCode":"ARE","GDP":348595,"Income.Group":"High income: nonOECD"},{"CountryName":"Thailand","CountryCode":"THA","GDP":365966,"Income.Group":"Lower middle income"},{"CountryName":"Colombia","CountryCode":"COL","GDP":369606,"Income.Group":"Upper middle income"},{"CountryName":"Venezuela, RB","CountryCode":"VEN","GDP":381286,"Income.Group":"Upper middle income"},{"CountryName":"South Africa","CountryCode":"ZAF","GDP":384313,"Income.Group":"Upper middle income"},{"CountryName":"Austria","CountryCode":"AUT","GDP":394708,"Income.Group":"High income: OECD"},{"CountryName":"Argentina","CountryCode":"ARG","GDP":475502,"Income.Group":"Upper middle income"},{"CountryName":"Belgium","CountryCode":"BEL","GDP":483262,"Income.Group":"High income: OECD"},{"CountryName":"Poland","CountryCode":"POL","GDP":489795,"Income.Group":"High income: OECD"},{"CountryName":"Norway","CountryCode":"NOR","GDP":499667,"Income.Group":"High income: OECD"},{"CountryName":"Iran, Islamic Rep.","CountryCode":"IRN","GDP":514060,"Income.Group":"Upper middle income"},{"CountryName":"Sweden","CountryCode":"SWE","GDP":523806,"Income.Group":"High income: OECD"},{"CountryName":"Switzerland","CountryCode":"CHE","GDP":631173,"Income.Group":"High income: OECD"},{"CountryName":"Saudi Arabia","CountryCode":"SAU","GDP":711050,"Income.Group":"High income: nonOECD"},{"CountryName":"Netherlands","CountryCode":"NLD","GDP":770555,"Income.Group":"High income: OECD"},{"CountryName":"Turkey","CountryCode":"TUR","GDP":789257,"Income.Group":"Upper middle income"},{"CountryName":"Indonesia","CountryCode":"IDN","GDP":878043,"Income.Group":"Lower middle income"},{"CountryName":"Korea, Rep.","CountryCode":"KOR","GDP":1129598,"Income.Group":"High income: OECD"},{"CountryName":"Mexico","CountryCode":"MEX","GDP":1178126,"Income.Group":"Upper middle income"},{"CountryName":"Spain","CountryCode":"ESP","GDP":1322965,"Income.Group":"High income: OECD"},{"CountryName":"Australia","CountryCode":"AUS","GDP":1532408,"Income.Group":"High income: OECD"},{"CountryName":"Canada","CountryCode":"CAN","GDP":1821424,"Income.Group":"High income: OECD"},{"CountryName":"India","CountryCode":"IND","GDP":1841710,"Income.Group":"Lower middle income"},{"CountryName":"Italy","CountryCode":"ITA","GDP":2014670,"Income.Group":"High income: OECD"},{"CountryName":"Russian Federation","CountryCode":"RUS","GDP":2014775,"Income.Group":"Upper middle income"},{"CountryName":"Brazil","CountryCode":"BRA","GDP":2252664,"Income.Group":"Upper middle income"},{"CountryName":"United Kingdom","CountryCode":"GBR","GDP":2471784,"Income.Group":"High income: OECD"},{"CountryName":"France","CountryCode":"FRA","GDP":2612878,"Income.Group":"High income: OECD"},{"CountryName":"Germany","CountryCode":"DEU","GDP":3428131,"Income.Group":"High income: OECD"},{"CountryName":"Japan","CountryCode":"JPN","GDP":5959718,"Income.Group":"High income: OECD"},{"CountryName":"China","CountryCode":"CHN","GDP":8227103,"Income.Group":"Lower middle income"},{"CountryName":"United States","CountryCode":"USA","GDP":16244600,"Income.Group":"High income: OECD"}],"rClass":"data.frame","rColClasses":{"CountryName":"factor","CountryCode":"factor","GDP":"integer","Income.Group":"factor"},"rColnames":["CountryName","CountryCode","GDP","Income.Group"],"rColHeaders":["CountryName","CountryCode","GDP","Income.Group"],"rRowHeaders":["173","92","113","137","155","59","169","46","39","184","180","69","93","183","66","65","151","161","8","100","168","22","99","28","40","30","111","102","12","1","71","52","160","152","164","57","120","26","122","117","156","23","64","108","95","90","125","166","146","109","14","75","19","116","97","114","189","7","110","118","115","15","121","127","4","163","124","82","37","91","149","119","29","85","138","62","27","187","20","67","60","73","130","175","2","188","54","43","170","153","35","36","142","24","174","105","18","86","167","185","134","154","89","63","55","103","98","106","41","158","171","177","70","17","179","104","148","48","74","101","21","11","42","132","162","50","157","107","140","3","16","76","182","96","131","143","176","144","44","88","135","49","81","79","141","133","56","68","136","83","126","51","72","33","150","123","47","5","165","38","181","186","10","6","13","139","129","80","159","32","147","128","172","77","94","112","53","9","31","78","84","145","25","61","58","45","87","34","178"],"rDataDim":[189,4],"selectCallback":false,"colHeaders":["CountryName","CountryCode","GDP","Income.Group"],"rowHeaders":["173","92","113","137","155","59","169","46","39","184","180","69","93","183","66","65","151","161","8","100","168","22","99","28","40","30","111","102","12","1","71","52","160","152","164","57","120","26","122","117","156","23","64","108","95","90","125","166","146","109","14","75","19","116","97","114","189","7","110","118","115","15","121","127","4","163","124","82","37","91","149","119","29","85","138","62","27","187","20","67","60","73","130","175","2","188","54","43","170","153","35","36","142","24","174","105","18","86","167","185","134","154","89","63","55","103","98","106","41","158","171","177","70","17","179","104","148","48","74","101","21","11","42","132","162","50","157","107","140","3","16","76","182","96","131","143","176","144","44","88","135","49","81","79","141","133","56","68","136","83","126","51","72","33","150","123","47","5","165","38","181","186","10","6","13","139","129","80","159","32","147","128","172","77","94","112","53","9","31","78","84","145","25","61","58","45","87","34","178"],"columns":[{"type":"dropdown","source":["Afghanistan","Albania","Algeria","Angola","Antigua and Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas, The","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Brunei Darussalam","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Dem. Rep.","Congo, Rep.","Costa Rica","Croatia","Cuba","Cyprus","Czech Republic","C�te d'Ivoire","Denmark","Dominica","Dominican Republic","Ecuador","Egypt, Arab Rep.","El Salvador","Equatorial Guinea","Eritrea","Estonia","Ethiopia","Fiji","Finland","France","Gabon","Gambia, The","Georgia","Germany","Ghana","Greece","Grenada","Guatemala","Guinea","Guinea-Bissau","Guyana","Haiti","Honduras","Hong Kong SAR, China","Hungary","Iceland","India","Indonesia","Iran, Islamic Rep.","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kiribati","Korea, Rep.","Kosovo","Kuwait","Kyrgyz Republic","Lao PDR","Latvia","Lebanon","Lesotho","Liberia","Lithuania","Luxembourg","Macao SAR, China","Macedonia, FYR","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Mauritania","Mauritius","Mexico","Micronesia, Fed. Sts.","Moldova","Monaco","Mongolia","Montenegro","Morocco","Mozambique","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palau","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Romania","Russian Federation","Rwanda","Samoa","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovak Republic","Slovenia","Solomon Islands","South Africa","Spain","Sri Lanka","St. Kitts and Nevis","St. Lucia","St. Vincent and the Grenadines","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syrian Arab Republic","S�o Tom� and Principe","Tajikistan","Tanzania","Thailand","Timor-Leste","Togo","Tonga","Trinidad and Tobago","Tunisia","Turkey","Turkmenistan","Tuvalu","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States","Uruguay","Uzbekistan","Vanuatu","Venezuela, RB","Vietnam","Yemen, Rep.","Zambia","Zimbabwe"],"allowInvalid":false,"renderer":"customRenderer","default":null},{"type":"dropdown","source":["ABW","AFG","AGO","ALB","ARE","ARG","ARM","ATG","AUS","AUT","AZE","BDI","BEL","BEN","BFA","BGD","BGR","BHR","BHS","BIH","BLR","BLZ","BMU","BOL","BRA","BRB","BRN","BTN","BWA","CAF","CAN","CHE","CHL","CHN","CIV","CMR","COG","COL","COM","CPV","CRI","CUB","CYP","CZE","DEU","DMA","DNK","DOM","DZA","ECU","EGY","ERI","ESP","EST","ETH","FIN","FJI","FRA","FSM","GAB","GBR","GEO","GHA","GIN","GMB","GNB","GNQ","GRC","GRD","GTM","GUY","HKG","HND","HRV","HTI","HUN","IDN","IND","IRL","IRN","IRQ","ISL","ISR","ITA","JAM","JOR","JPN","KAZ","KEN","KGZ","KHM","KIR","KNA","KOR","KSV","KWT","LAO","LBN","LBR","LCA","LKA","LSO","LTU","LUX","LVA","MAC","MAR","MCO","MDA","MDG","MDV","MEX","MHL","MKD","MLI","MLT","MNE","MNG","MOZ","MRT","MUS","MWI","MYS","NAM","NER","NGA","NIC","NLD","NOR","NPL","NZL","OMN","PAK","PAN","PER","PHL","PLW","PNG","POL","PRI","PRT","PRY","QAT","ROM","RUS","RWA","SAU","SDN","SEN","SGP","SLB","SLE","SLV","SRB","STP","SUR","SVK","SVN","SWE","SWZ","SYC","SYR","TCD","TGO","THA","TJK","TKM","TMP","TON","TTO","TUN","TUR","TUV","TZA","UGA","UKR","URY","USA","UZB","VCT","VEN","VNM","VUT","WSM","YEM","ZAF","ZAR","ZMB","ZWE"],"allowInvalid":false,"renderer":"customRenderer","default":null},{"type":"numeric","format":"0","renderer":"customRenderer","default":null},{"type":"dropdown","source":["High income: nonOECD","High income: OECD","Low income","Lower middle income","Upper middle income"],"allowInvalid":false,"renderer":"customRenderer","default":null}],"width":null,"height":null,"debug":0,"stretchH":"none","comments":false,"contextMenu":{"items":{"row_above":[],"row_below":[],"remove_row":[],"hsep3":{"name":"---------"},"undo":[],"redo":[],"hsep4":{"name":"---------"},"alignment":[]}},"caption":"Ranking in Income Groups"},"evals":["columns.0.renderer","columns.1.renderer","columns.2.renderer","columns.3.renderer"],"jsHooks":[]}</script><!--/html_preserve-->

```r
top38 <- tail(Data, n = 38)
# an answer to the question: How many countries are "lower middle income" but within the 38 nations with the highest GDP
cat('There are', NROW(top38[top38$Income.Group == 'Lower middle income', ]), 'countries "lower middle income" but within the 38 nations with the highest GDP')
```

```
## There are 5 countries "lower middle income" but within the 38 nations with the highest GDP
```
##Conclusion
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

![](Analysis_files/figure-html/unnamed-chunk-7-1.png)<!-- -->
  
This is due to a few countries with large GDP, like the United States at $16,244,600 Million.
The right skewedness also indicates the mean is greater than the median, making the median at $28,240 Million a better overall indicator of GDP across the data set.<br/>

A smooth scatterplot of GDP does not visually confirm a linear relationship.  

```r
smoothScatter (Data$GDP, ylab="GDP in Millions USD$")
```

![](Analysis_files/figure-html/unnamed-chunk-8-1.png)<!-- -->
  
A second look at the category breakdown shows unexpected assignment of countries to Income Group categories.
Below is a subset of the Income Group by countries with a GDP greater than $1,000,000 Million.

```r
cutoff <- Data[Data$GDP >= 1000000,]
datatable(
  cutoff[,-5:-6],
  options = list(pageLength = 15, searching = FALSE),
  caption = "Ranking in Income Groups"
)
```

<!--html_preserve--><div id="htmlwidget-3e6969de7355a30cbd48" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-3e6969de7355a30cbd48">{"x":{"filter":"none","caption":"<caption>Ranking in Income Groups\u003c/caption>","data":[["94","112","53","9","31","78","84","145","25","61","58","45","87","34","178"],["KOR","MEX","ESP","AUS","CAN","IND","ITA","RUS","BRA","GBR","FRA","DEU","JPN","CHN","USA"],["Korea, Rep.","Mexico","Spain","Australia","Canada","India","Italy","Russian Federation","Brazil","United Kingdom","France","Germany","Japan","China","United States"],[1129598,1178126,1322965,1532408,1821424,1841710,2014670,2014775,2252664,2471784,2612878,3428131,5959718,8227103,16244600],["High income: OECD","Upper middle income","High income: OECD","High income: OECD","High income: OECD","Lower middle income","High income: OECD","Upper middle income","Upper middle income","High income: OECD","High income: OECD","High income: OECD","High income: OECD","Lower middle income","High income: OECD"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> \u003c/th>\n      <th>CountryCode\u003c/th>\n      <th>CountryName\u003c/th>\n      <th>GDP\u003c/th>\n      <th>Income.Group\u003c/th>\n    \u003c/tr>\n  \u003c/thead>\n\u003c/table>","options":{"pageLength":15,"searching":false,"columnDefs":[{"className":"dt-right","targets":3},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false,"lengthMenu":[10,15,25,50,100]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
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
