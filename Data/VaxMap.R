setwd("~/git/MSF_PneumoniaVaccinePriceMap")
library(useful)
require(stringr)
require(ggplot2)
library(rworldmap)
sum(is.na(price$Price))

#read in data
price <- read.table("Data/VaccinePrices_051315.csv", sep=",", header = TRUE, stringsAsFactors = FALSE, na.strings=c("NA", "NULL"))
class(price$Price)

#overview map
priceDATA <- subset(price, price$Price != "NA")


countrymap <- joinCountryData2Map (priceDATA, joinCode = "NAME", nameJoinColumn = "Country")
plot(getMap())

mapCountryData(mapToPlot = countrymap, nameColumnToPlot = "Price", catMethod  = "categorical", addLegend = TRUE ,oceanCol = "black", lwd = 0.1, colourPalette = "heat" )


#countries with no data, and PCV in EPI schedule
priceNA_EPI <- subset(price, is.na(price$Price))
countrymap2 <- joinCountryData2Map (priceNA_EPI, joinCode = "NAME", nameJoinColumn = "Country")
plot(getMap())

mapCountryData(mapToPlot = countrymap2, nameColumnToPlot = "EPI", catMethod  = "categorical", addLegend = TRUE ,oceanCol = "black", lwd = 0.1, colourPalette = "heat" )



