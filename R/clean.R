# Sorry about the inconvinience of downloading packages to run the file
library(tidyverse)
library(forcats)
library(lubridate)
library(stringr)
library(zoo)
library(chron)




# Function to clean ling_data
cleanLingData <- function(ling_data){
  ling_data <- na.omit(ling_data)
  
  #Changing data types to the desired datatypes
  for (i in c(5 : ncol(ling_data)-2)) {
    ling_data[ , i] <- as.factor(ling_data[ , i])
  }
  
  ling_data$ID <- as.integer(ling_data$ID)
  ling_data$ZIP <- as.integer(ling_data$ZIP)
  ling_data$CITY <- as.character(ling_data$CITY)
  ling_data$STATE <- as.character(ling_data$STATE)
  
  #Removing the values outside the US
  ling_data <- ling_data %>% filter(long > -125)
  
  return(ling_data)
}





# Function to clean ling_location data
cleanLingLocationData <- function(ling_location){
  ling_location <- na.omit(ling_location)
  
  #Removing the values outside the US
  ling_location <- ling_location %>% filter(Longitude > -125)
  
  #Fixing the data types
  ling_location$Latitude <- as.double(ling_location$Latitude)
  ling_location$Longitude <- as.double(ling_location$Longitude)
  
  return(ling_location)
}




# Cleaning the redwood data

# Function to get desired data type
cleanRedwoodDataType <- function(redwood_df) {
  
  redwood_df[[3]] <- as.factor(redwood_df[[3]])
  for(i in c(2, 4, 6)) {redwood_df[[i]] <- as.integer(redwood_df[[i]])}
  for(i in c(5, 7:11)) {redwood_df[[i]] <- as.numeric(redwood_df[[i]])}
  
  return(redwood_df)
}


#Function to get the values that make sense
cleanRedwoodData <- function(redwood_df) {
  
  #Removing rows outside the range of humidity
  redwood_df <- redwood_df %>% filter(humidity >= 16.4 & humidity <= 102)
  
  
  # Removing the Incident and Reflected PAR outside the range of Incident PAR and Reflected PAR
  redwood_df <- redwood_df %>% filter(hamatop <= 2154 & hamabot <= 180 & hamabot >= 0 & hamatop >= 0 )
  
  # Removing the Temperature readings outside the sensor range
  redwood_df <- redwood_df %>% filter(humid_temp >= 6.6 & humid_temp <= 32.6)
  
  # Removing the sensor with low voltage
  redwood_df <- subset(redwood_df, voltage >= 2.4)
  
  
  #Replacing NA with the mean of the column
  redwood_df <- redwood_df %>% drop_na()
  }
  
  
