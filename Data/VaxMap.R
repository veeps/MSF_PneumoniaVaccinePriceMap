setwd("~/git/vaxprices")
library(useful)
require(stringr)
require(ggplot2)


#read in data
price <- read.table("VaxPrices_042915.csv", sep=",", header = TRUE, stringsAsFactors = FALSE)
GDP <- read.table("GDP.csv", sep=",", header = TRUE, stringsAsFactors=FALSE)

#merge data
priceGDP <- merge (x=price, y=GDP,
                   by.x=c("CountryCode"),
                   by.y=c("CountryCode"),
                   all.x=TRUE)

#remove questionmarks
priceGDP$Price <- gsub("[:?:]", "", priceGDP$Price, perl = FALSE)
sum(is.na(priceGDP$Price))
priceGDP$Price <- as.numeric(priceGDP$Price)

class(priceGDP$Price)
#scatter plot
g <- ggplot(priceGDP, aes(x=GDP, y=Price))
scatterplot <- g + geom_point(aes(color =Grouping)) 



#overview map
priceDATA <- subset(priceGDP, priceGDP$Price != "NA")


countrymap <- joinCountryData2Map (priceDATA, joinCode = "NAME", nameJoinColumn = "Country")
plot(getMap())

mapCountryData(mapToPlot = countrymap, nameColumnToPlot = "Price", catMethod  = "categorical", addLegend = FALSE ,oceanCol = "black", lwd = 0.1, colourPalette = "heat" )
