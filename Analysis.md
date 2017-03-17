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
Looking at the data from both sets and merging them together we end up with some data points that do not have information in the GDP, so we removed the NA data from the data.
This left us with 

```r
nrow(Data)
```

```
## [1] 189
```
rows of clean merged data for further analysis.

###2. With the the data frame in decending order by GDP(United States last) what is the 13th value?
So you maybe wondering where different countries lie within this list of countries or what country lies in which position.
Here is an example of which county lie at the thirteenth position if we order the data in decending order.
This lists row in unordered data frame, three letter country code, countyr name, GDP in millions of US dollars, and finaly which  Organization of Economic Cooperation and Developement group it belongs.


```r
# reorder by GDP
Data = Data[order(Data$GDP),]
# print 13-th
print(Data[c(13), ])
```

```
##    CountryCode         CountryName GDP        Income.Group
## 93         KNA St. Kitts and Nevis 767 Upper middle income
```

###3. What are the average GDP rankings for the "High Income: OECD" and "High Income:nonOECD" groups?

We have talked about different groups as classified by the Organization of Economic Cooperation and Development (OECD).
There are five different groups.
They are the high income and member of the OECD, the high income and non-member OECD, the upper middle income, the middle income, and the low income groups.
Now for us to look if there is a difference between being a member of the OECD makes a difference the only way we can do that is by comparing the the average incomes of the high income OECD to the high income nonOECD, since they are the only groups with a counter part.<br/> 

the high income OECD group has an average GDP of 

```r
Data$GDP.rankings = rank(Data$GDP)
OECD_rankings = Data$GDP.rankings[Data$Income.Group == "High income: OECD"]
print(mean(OECD_rankings))
```

```
## [1] 157.0333
```
millions in US dollars.<br/>

The high income nonOECD group had an average GDP of 

```r
nonOECD_rankings = Data$GDP.rankings[Data$Income.Group == "High income: nonOECD"]
print(mean(nonOECD_rankings)) 
```

```
## [1] 98.34783
```
millions in US dollars.
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
  install.packages("lattice", repos =structure(c(CRAN = "http://cran.r-project.org")))
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
# Split the rankings to 5 quantile groups
OrderData <- Data[order(Data$GDP.rankings), c(1:4)]
colNames <- c("Country Name", "Country Code", "GDP in Millions USD$", "Income Group")
knitr::kable (OrderData[c('CountryName', 'CountryCode', 'GDP', 'Income.Group')], col.names = colNames, align = 'c', caption = "Ranking in Income Group")
```



Table: Ranking in Income Group

                Country Name             Country Code    GDP in Millions USD$        Income Group     
----  --------------------------------  --------------  ----------------------  ----------------------
173                Tuvalu                    TUV                  40             Lower middle income  
92                Kiribati                   KIR                 175             Lower middle income  
113           Marshall Islands               MHL                 182             Lower middle income  
137                Palau                     PLW                 228             Upper middle income  
155        S�o Tom� and Principe             STP                 263             Lower middle income  
59         Micronesia, Fed. Sts.             FSM                 326             Lower middle income  
169                Tonga                     TON                 472             Lower middle income  
46                Dominica                   DMA                 480             Upper middle income  
39                Comoros                    COM                 596                  Low income      
184                Samoa                     WSM                 684             Lower middle income  
180    St. Vincent and the Grenadines        VCT                 713             Upper middle income  
69                Grenada                    GRD                 767             Upper middle income  
93          St. Kitts and Nevis              KNA                 767             Upper middle income  
183               Vanuatu                    VUT                 787             Lower middle income  
66             Guinea-Bissau                 GNB                 822                  Low income      
65              Gambia, The                  GMB                 917                  Low income      
151           Solomon Islands                SLB                 1008                 Low income      
161              Seychelles                  SYC                 1129            Upper middle income  
8           Antigua and Barbuda              ATG                 1134            Upper middle income  
100              St. Lucia                   LCA                 1239            Upper middle income  
168             Timor-Leste                  TMP                 1293            Lower middle income  
22                 Belize                    BLZ                 1493            Lower middle income  
99                Liberia                    LBR                 1734                 Low income      
28                 Bhutan                    BTN                 1780            Lower middle income  
40               Cape Verde                  CPV                 1827            Lower middle income  
30        Central African Republic           CAF                 2184                 Low income      
111               Maldives                   MDV                 2222            Lower middle income  
102               Lesotho                    LSO                 2448            Lower middle income  
12                Burundi                    BDI                 2472                 Low income      
1                  Aruba                     ABW                 2584            High income: nonOECD 
71                 Guyana                    GUY                 2851            Lower middle income  
52                Eritrea                    ERI                 3092                 Low income      
160              Swaziland                   SWZ                 3744            Lower middle income  
152             Sierra Leone                 SLE                 3796                 Low income      
164                 Togo                     TGO                 3814                 Low income      
57                  Fiji                     FJI                 3908            Upper middle income  
120              Mauritania                  MRT                 4199                 Low income      
26                Barbados                   BRB                 4225            High income: nonOECD 
122                Malawi                    MWI                 4264                 Low income      
117              Montenegro                  MNE                 4373            Upper middle income  
156               Suriname                   SUR                 5012            Upper middle income  
23                Bermuda                    BMU                 5474            High income: nonOECD 
64                 Guinea                    GIN                 5632                 Low income      
108                Monaco                    MCO                 6075            High income: nonOECD 
95                 Kosovo                    KSV                 6445            Lower middle income  
90            Kyrgyz Republic                KGZ                 6475                 Low income      
125                Niger                     NER                 6773                 Low income      
166              Tajikistan                  TJK                 6972                 Low income      
146                Rwanda                    RWA                 7103                 Low income      
109               Moldova                    MDA                 7253            Lower middle income  
14                 Benin                     BEN                 7557                 Low income      
75                 Haiti                     HTI                 7843                 Low income      
19              Bahamas, The                 BHS                 8149            High income: nonOECD 
116                Malta                     MLT                 8722            High income: nonOECD 
97                Lao PDR                    LAO                 9418                 Low income      
114            Macedonia, FYR                MKD                 9613            Upper middle income  
189               Zimbabwe                   ZWE                 9802                 Low income      
7                 Armenia                    ARM                 9951            Lower middle income  
110              Madagascar                  MDG                 9975                 Low income      
118               Mongolia                   MNG                10271            Lower middle income  
115                 Mali                     MLI                10308                 Low income      
15              Burkina Faso                 BFA                10441                 Low income      
121              Mauritius                   MUS                10486            Upper middle income  
127              Nicaragua                   NIC                10507            Lower middle income  
4                 Albania                    ALB                12648            Upper middle income  
163                 Chad                     TCD                12887                 Low income      
124               Namibia                    NAM                13072            Upper middle income  
82                Iceland                    ISL                13579             High income: OECD   
37              Congo, Rep.                  COG                13678            Lower middle income  
91                Cambodia                   KHM                14038                 Low income      
149               Senegal                    SEN                14046            Lower middle income  
119              Mozambique                  MOZ                14244                 Low income      
29                Botswana                   BWA                14504            Upper middle income  
85                Jamaica                    JAM                14755            Upper middle income  
138           Papua New Guinea               PNG                15654            Lower middle income  
62                Georgia                    GEO                15747            Lower middle income  
27           Brunei Darussalam               BRN                16954            High income: nonOECD 
187           Congo, Dem. Rep.               ZAR                17204                 Low income      
20         Bosnia and Herzegovina            BIH                17466            Upper middle income  
67           Equatorial Guinea               GNQ                17697            High income: nonOECD 
60                 Gabon                     GAB                18377            Upper middle income  
73                Honduras                   HND                18434            Lower middle income  
130                Nepal                     NPL                18963                 Low income      
175                Uganda                    UGA                19881                 Low income      
2               Afghanistan                  AFG                20497                 Low income      
188                Zambia                    ZMB                20678                 Low income      
54                Estonia                    EST                22390            High income: nonOECD 
43                 Cyprus                    CYP                22767            High income: nonOECD 
170         Trinidad and Tobago              TTO                23320            High income: nonOECD 
153             El Salvador                  SLV                23864            Lower middle income  
35             C�te d'Ivoire                 CIV                24680            Lower middle income  
36                Cameroon                   CMR                25322            Lower middle income  
142               Paraguay                   PRY                25502            Lower middle income  
24                Bolivia                    BOL                27035            Lower middle income  
174               Tanzania                   TZA                28242                 Low income      
105                Latvia                    LVA                28373            High income: nonOECD 
18                Bahrain                    BHR                29044            High income: nonOECD 
86                 Jordan                    JOR                31015            Lower middle income  
167             Turkmenistan                 TKM                35164            Lower middle income  
185             Yemen, Rep.                  YEM                35646            Lower middle income  
134                Panama                    PAN                36253            Upper middle income  
154                Serbia                    SRB                37489            Upper middle income  
89                 Kenya                     KEN                40697                 Low income      
63                 Ghana                     GHA                40711                 Low income      
55                Ethiopia                   ETH                41605                 Low income      
103              Lithuania                   LTU                42344            Upper middle income  
98                Lebanon                    LBN                42945            Upper middle income  
106           Macao SAR, China               MAC                43582            High income: nonOECD 
41               Costa Rica                  CRI                45104            Upper middle income  
158               Slovenia                   SVN                45279             High income: OECD   
171               Tunisia                    TUN                45662            Lower middle income  
177               Uruguay                    URY                49920            Upper middle income  
70               Guatemala                   GTM                50234            Lower middle income  
17                Bulgaria                   BGR                50972            Upper middle income  
179              Uzbekistan                  UZB                51113            Lower middle income  
104              Luxembourg                  LUX                55178             High income: OECD   
148                Sudan                     SDN                58769            Lower middle income  
48           Dominican Republic              DOM                59047            Upper middle income  
74                Croatia                    HRV                59228            High income: nonOECD 
101              Sri Lanka                   LKA                59423            Lower middle income  
21                Belarus                    BLR                63267            Upper middle income  
11               Azerbaijan                  AZE                66605            Upper middle income  
42                  Cuba                     CUB                68234            Upper middle income  
132                 Oman                     OMN                69972            High income: nonOECD 
162         Syrian Arab Republic             SYR                73672            Lower middle income  
50                Ecuador                    ECU                84040            Lower middle income  
157           Slovak Republic                SVK                91149             High income: OECD   
107               Morocco                    MAR                95982            Lower middle income  
140             Puerto Rico                  PRI                101496           High income: nonOECD 
3                  Angola                    AGO                114147           Lower middle income  
16               Bangladesh                  BGD                116355                Low income      
76                Hungary                    HUN                124600            High income: OECD   
182               Vietnam                    VNM                155820           Lower middle income  
96                 Kuwait                    KWT                160913           High income: nonOECD 
131             New Zealand                  NZL                167347            High income: OECD   
143                Qatar                     QAT                171476           High income: nonOECD 
176               Ukraine                    UKR                176309           Lower middle income  
144               Romania                    ROM                192711           Upper middle income  
44             Czech Republic                CZE                196446            High income: OECD   
88               Kazakhstan                  KAZ                203521           Upper middle income  
135                 Peru                     PER                203790           Upper middle income  
49                Algeria                    DZA                205789           Upper middle income  
81                  Iraq                     IRQ                210280           Lower middle income  
79                Ireland                    IRL                210771            High income: OECD   
141               Portugal                   PRT                212274            High income: OECD   
133               Pakistan                   PAK                225143           Lower middle income  
56                Finland                    FIN                247546            High income: OECD   
68                 Greece                    GRC                249099            High income: OECD   
136             Philippines                  PHL                250182           Lower middle income  
83                 Israel                    ISR                258217            High income: OECD   
126               Nigeria                    NGA                262597           Lower middle income  
51            Egypt, Arab Rep.               EGY                262832           Lower middle income  
72          Hong Kong SAR, China             HKG                263259           High income: nonOECD 
33                 Chile                     CHL                269869           Upper middle income  
150              Singapore                   SGP                274701           High income: nonOECD 
123               Malaysia                   MYS                305033           Upper middle income  
47                Denmark                    DNK                314887            High income: OECD   
5           United Arab Emirates             ARE                348595           High income: nonOECD 
165               Thailand                   THA                365966           Lower middle income  
38                Colombia                   COL                369606           Upper middle income  
181            Venezuela, RB                 VEN                381286           Upper middle income  
186             South Africa                 ZAF                384313           Upper middle income  
10                Austria                    AUT                394708            High income: OECD   
6                Argentina                   ARG                475502           Upper middle income  
13                Belgium                    BEL                483262            High income: OECD   
139                Poland                    POL                489795            High income: OECD   
129                Norway                    NOR                499667            High income: OECD   
80           Iran, Islamic Rep.              IRN                514060           Upper middle income  
159                Sweden                    SWE                523806            High income: OECD   
32              Switzerland                  CHE                631173            High income: OECD   
147             Saudi Arabia                 SAU                711050           High income: nonOECD 
128             Netherlands                  NLD                770555            High income: OECD   
172                Turkey                    TUR                789257           Upper middle income  
77               Indonesia                   IDN                878043           Lower middle income  
94              Korea, Rep.                  KOR               1129598            High income: OECD   
112                Mexico                    MEX               1178126           Upper middle income  
53                 Spain                     ESP               1322965            High income: OECD   
9                Australia                   AUS               1532408            High income: OECD   
31                 Canada                    CAN               1821424            High income: OECD   
78                 India                     IND               1841710           Lower middle income  
84                 Italy                     ITA               2014670            High income: OECD   
145          Russian Federation              RUS               2014775           Upper middle income  
25                 Brazil                    BRA               2252664           Upper middle income  
61             United Kingdom                GBR               2471784            High income: OECD   
58                 France                    FRA               2612878            High income: OECD   
45                Germany                    DEU               3428131            High income: OECD   
87                 Japan                     JPN               5959718            High income: OECD   
34                 China                     CHN               8227103           Lower middle income  
178            United States                 USA               16244600           High income: OECD   

```r
top38 <- tail(Data, n = 38)
# this answer: How many countries are "lower middle income" but within the 38 nations with the highest GDP
print(NROW(top38[top38$Income.Group == 'Lower middle income', ]))
```

```
## [1] 5
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
cutoff <- Data[Data$GDP >= 1000000,]
print (cutoff[,-5:-6])
```

```
##     CountryCode        CountryName      GDP        Income.Group
## 94          KOR        Korea, Rep.  1129598   High income: OECD
## 112         MEX             Mexico  1178126 Upper middle income
## 53          ESP              Spain  1322965   High income: OECD
## 9           AUS          Australia  1532408   High income: OECD
## 31          CAN             Canada  1821424   High income: OECD
## 78          IND              India  1841710 Lower middle income
## 84          ITA              Italy  2014670   High income: OECD
## 145         RUS Russian Federation  2014775 Upper middle income
## 25          BRA             Brazil  2252664 Upper middle income
## 61          GBR     United Kingdom  2471784   High income: OECD
## 58          FRA             France  2612878   High income: OECD
## 45          DEU            Germany  3428131   High income: OECD
## 87          JPN              Japan  5959718   High income: OECD
## 34          CHN              China  8227103 Lower middle income
## 178         USA      United States 16244600   High income: OECD
```
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
