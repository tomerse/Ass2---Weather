
library(httr)
library(Rforecastio)
packageVersion("Rforecastio")



calcMonthAvg <- function(longitude, latitude, days)
{
  print(latitude)
  print(longitude)
 
  date1 <- "2016-01-01T12:00:00-0400"
  date2 <- "2016-01-02T12:00:00-0400"
  date3 <- "2016-01-03T12:00:00-0400"
  date4 <- "2016-01-04T12:00:00-0400"
  date5 <- "2016-01-05T12:00:00-0400"
  date6 <- "2016-01-06T12:00:00-0400"
  date7 <- "2016-01-07T12:00:00-0400"
  date8 <- "2016-01-08T12:00:00-0400"
  date9 <- "2016-01-09T12:00:00-0400"
  date10 <- "2016-01-10T12:00:00-0400"
  date11 <- "2016-01-11T12:00:00-0400"
  date12 <- "2016-01-12T12:00:00-0400"
  date13 <- "2016-01-13T12:00:00-0400"
  date14 <- "2016-01-14T12:00:00-0400"
  date15 <- "2016-01-15T12:00:00-0400"
  date16 <- "2016-01-16T12:00:00-0400"
  date17 <- "2016-01-17T12:00:00-0400"
  date18 <- "2016-01-18T12:00:00-0400"
  date19 <- "2016-01-19T12:00:00-0400"
  date20 <- "2016-01-20T12:00:00-0400"
  date21 <- "2016-01-21T12:00:00-0400"
  date22 <- "2016-01-22T12:00:00-0400"
  date23 <- "2016-01-23T12:00:00-0400"
  date24 <- "2016-01-24T12:00:00-0400"
  date25 <- "2016-01-25T12:00:00-0400"
  date26 <- "2016-01-26T12:00:00-0400"
  date27 <- "2016-01-27T12:00:00-0400"
  date28 <- "2016-01-28T12:00:00-0400"
  date29 <- "2016-01-29T12:00:00-0400"
  date30 <- "2016-01-30T12:00:00-0400"
  date31 <- "2016-01-31T12:00:00-0400"
  dates <- c(date1,date2,date3,date4,date5,date6,date7,date8,date9
             ,date10,date11,date12,date13,date14,date15,date16,date17,date18,date19
             ,date20,date21,date22,date23,date24,date25,date26,date27,date28,date29
             ,date30,date31)

  sum_temp <- 0.0
  sum_hum <- 0.0
  sum_cloudCover <- 0.0
  arr = array(0.0,days)
  
  for(i in 1:days)
  {
    day <- get_forecast_for(latitude,longitude, dates[i])
    dayTempAvg <- ((day$daily$temperatureMin+day$daily$temperatureMax)/2)
    arr[i] <- convertFarenheitToCelcius(dayTempAvg)
    sum_temp <- sum_temp+dayTempAvg
    sum_hum <- sum_hum+day$daily$humidity
    sum_cloudCover <- sum_cloudCover+day$daily$cloudCover
  }
  
  tempAvg <- sum_temp/days
  #convert temparature from Fahrenheit to Celcius
  tempAvg <- convertFarenheitToCelcius(tempAvg)
  humAvg <- sum_hum/days
  coverAvg <- sum_cloudCover/days
  ans <- c(tempAvg,humAvg,coverAvg,arr)
  return(ans)
}

convertFarenheitToCelcius <- function(farenheit)
{
  celcius <- (farenheit-32)/1.8
  return(celcius)
}








