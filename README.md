---
title: "Ass2--US Temperatures in January 2016"   
author: "Tomer Belzer & Tomer Segal"   
date: "April 12, 2016"   
output: html_document
---

#Ass2--US Temperatures in January 2016

## Description:
This report describes the average temperature of 21 main cities in the US during January 2016.   
The cities are:    
NYC, LA, Las Vegas, Houston, New Orleans, Seattle,    
Albuquerque, Cleavland, Miami,   
Chicago, Minneapolis, Boston, San Francisco, Denver, Salt Lake City,    
Frankfort, Memphis, Des Moines, Oklahoma, Boise, Atlanta.   


In order to get our data, we used "The Dark Sky Forecast API":    
https://developer.forecast.io/,
and the library "Rforecastio" from https://github.com/hrbrmstr/Rforecastio.   
Here you can see an example request for latitude 37.77, longitude -122, date 2016-03-01T12:00:00-0400:   
https://api.forecast.io/forecast/792fc046ce6c4b0077cf634699cdd9fe/37.77,-122,2016-03-01T12:00:00-0400.   
Example for the same request from our code:   
```{r}
day <- get_forecast_for(37.77,-122, "2016-03-01T12:00:00-0400")
```   
We had 21(cities)*31(days)=651 records.   
For each record, we extracted the daily average temperature.   

## Our Finding:   
1)  	The next histogram displays the average temperature of all  651 measured days:   
```{r}
hist(all_temp, col = "blue")   
abline(v=median(all_temp),col="magenta", lwd=2)
```
  
 ![alt text][1]
 
 As you can see, the average is around 7 Celsius degrees (the pink line).
 
 2)	Temperature difference between cities located by the sea and far from sea:   
 ```{r}
 boxplot(Average_Temperature ~ by_the_sea, data = cities , col="red", main="By The Sea Temperature Stats")
 ```   
 
 ![alt text][2]
 
 The left chart displays statistics about average temperature of cities far from see while the right displays statistics about cities by the sea.   
 As you can see, there is a big temperature difference between those cities, their averages are 0 and 11 accordingly.
 
 3)	Temperature difference between north & south cities (the  separating latitude is 38):   
 ```{r}
 with(cities, plot(longitude,Average_Temperature,col=North))
 ```
 
 ![alt text][3]
 
 This scatter plot shows the cities according to longitudes.
 The difference is really clear - the north cities (blue bullets) are much colder than the south (red bullets). 
 
 4)	The next map shows temperature scale of all measured cities:   
 ```{r}
 map <- get_map(location = c(lon = mean(cities$longitude), lat = mean(cities$latitude)), zoom = 4, maptype = "satellite", scale = 2)
ggmap(map)+geom_point(data=cities,aes(x=longitude, y=latitude, colour = Average_Temperature), size = 2) + scale_color_gradient(high ="red",low="blue")
```

 
 ![alt text][4]
 
##Summary, Conclusions and Recommendations
We proved the differences between temperatures in north vs south USA, and cities far and near the sea during January 2016.
The plots above showed exactly the differences for each tested parameter.
The map makes it very easy to emphasize the differences between the temperatures.

Next, other weather parameters should be tested such that humidity, cloud cover, etc.
With other parameters and more statistics from previous months, we can try to predict the whether for each city for the next time January comes.

[1]:https://github.com/tomerse/Ass2---Weather/blob/master/Images/avg_temp.png
[2]:https://github.com/tomerse/Ass2---Weather/blob/master/Images/by_the_sea.png
[3]:https://github.com/tomerse/Ass2---Weather/blob/master/Images/North-South.png
[4]:https://github.com/tomerse/Ass2---Weather/blob/master/Images/map.png
  
