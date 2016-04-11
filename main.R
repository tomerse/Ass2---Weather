source("Monthly.R")
library(ggmap)
library(ggplot2)


cities <- read.csv("cities.csv",colClasses=c("character","numeric","numeric","numeric"))

north_south_latitude = 38
east_west_longitude = -90.00



days<-31

numOfCities <- length(cities$City)

cities["North"] <- 1
cities["East_West"] <- "East"
cities["Average_Temperature"] <- 0.0
cities["Average_Humidity"] <- 0.0
cities["Average_Cloud_Cover"] <- 0.0

all_temp = array(0.0,days*numOfCities)
index_cur_arr = 1

for (i in 1:numOfCities) {
  data <- calcMonthAvg(cities$longitude[i],cities$latitude[i],days)
  cities$Average_Temperature[i] <- data[1]
  cities$Average_Humidity[i] <- data[2]
  cities$Average_Cloud_Cover[i] <- data[3]
  if (cities$latitude[i] < north_south_latitude)
  {
    cities$North[i] <- 0
  }
  if (cities$longitude[i] < east_west_longitude)
  {
    cities$East_West[i] <- "West"
  }
  for(j in index_cur_arr:(index_cur_arr+days-1))
    all_temp[j]<-data[4+((j-1) %% days)]
  
  index_cur_arr<-j+1
  
}

#average temperature
hist(all_temp, col = "blue")
abline(v=median(all_temp),col="magenta", lwd=2)

#Difference between temperature near sea and far from sea
boxplot(Average_Temperature ~ by_the_sea, data = cities , col="red", main="By The Sea Temperature Stats")

#Temperature histogram for north cities
#hist(subset(cities, North==1)$Average_Temperature, col="blue")

#Temperature histogram for south cities
#hist(subset(cities, North==0)$Average_Temperature, col="red")

#Comparison between north to south
#par(mfrow=c(2,1), mar=c(4,4,1,1))
#with(subset(cities, North == 0), plot(longitude, Average_Temperature, main = "South"))
#with(subset(cities, North == 1), plot(longitude, Average_Temperature, main = "North"))

#one chart to compare
with(cities, plot(longitude,Average_Temperature,col=North))

dev.off()
map <- get_map(location = c(lon = mean(cities$longitude), lat = mean(cities$latitude)), zoom = 4, maptype = "satellite", scale = 2)
# plotting the map with some points on it
ggmap(map)+geom_point(data=cities,aes(x=longitude, y=latitude, colour = Average_Temperature), size = 2) + scale_color_gradient(high ="red",low="blue")