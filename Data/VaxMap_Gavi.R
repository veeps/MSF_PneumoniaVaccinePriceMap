setwd("~/git/MSF_PneumoniaVaccinePriceMap")
library(useful)
require(stringr)
require(ggplot2)
library(rworldmap)
sum(is.na(price$Price))

#read in data
price <- read.table("Data/VaccinePrices_051515.csv", sep=",", header = TRUE, stringsAsFactors = FALSE, na.strings=c("NA", "NULL"))
class(price$PercentDeaths)

#overview map
priceDATA <- subset(price, price$Price != "NA")


countrymap <- joinCountryData2Map (price, joinCode = "NAME", nameJoinColumn = "Country")
plot(getMap())

#filter for Gavi only countries
priceGavi <- subset(price,Grouping=="Gavi" | Grouping=="Gavi Graduating")
gavimap <- joinCountryData2Map (priceGavi, joinCode = "NAME", nameJoinColumn = "Country")
mapCountryData(mapToPlot = gavimap, nameColumnToPlot = "Grouping", catMethod  = "categorical", addLegend = TRUE ,oceanCol = "white", lwd = 0.4, colourPalette=c("#4094cb","#bbd96a"))

#filter for high pneumonia burden
highDeaths <- subset(price,PercentDeaths >= 24)
deathmap <- joinCountryData2Map (highDeaths, joinCode = "NAME", nameJoinColumn = "Country")
mapCountryData(mapToPlot = deathmap, nameColumnToPlot = "PercentDeaths", catMethod  = "numerical", addLegend = TRUE ,oceanCol = "white", lwd = 0.4, colourPalette = "heat" )

#filter for no EPI countries & high deaths
highEpiNA <- subset(highDeaths,EPI == "No")
epimap <- joinCountryData2Map (priceNA, joinCode = "NAME", nameJoinColumn = "Country")
mapCountryData(mapToPlot = epimap, nameColumnToPlot = "PercentDeaths", catMethod  = "numerical", addLegend = TRUE ,oceanCol = "white", lwd = 0.4, colourPalette = "heat" )



#filter for no EPI countries
epieNA <- subset(price,EPI == "No")
epimap <- joinCountryData2Map (priceNA, joinCode = "NAME", nameJoinColumn = "Country")
mapCountryData(mapToPlot = epimap, nameColumnToPlot = "PercentDeaths", catMethod  = "numerical", addLegend = TRUE ,oceanCol = "white", lwd = 0.4, colourPalette = "heat" )


#countries with no data, and PCV in EPI schedule
priceNA_EPI <- subset(price, is.na(price$Price))
countrymap2 <- joinCountryData2Map (priceNA_EPI, joinCode = "NAME", nameJoinColumn = "Country")
plot(getMap())

mapCountryData(mapToPlot = countrymap2, nameColumnToPlot = "EPI", catMethod  = "categorical", addLegend = TRUE ,oceanCol = "black", lwd = 0.1, colourPalette = "heat" )



