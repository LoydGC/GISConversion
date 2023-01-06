# Geocoding a csv column of "addresses" in R

#load ggmap
library(ggmap)
library(tidyverse)
library(stringr)
library(rio)


#API

#register_google("XXXXXX", write = TRUE)

# Read in the CSV data and store it in a variable 
origAddress <- read.csv("XXXX Locations - Sheet1.csv")

#Split address so ZIP and rest of address are separate variablesa
origAddress <- tidyr::extract(origAddress, Address, c("Address", "Zip"), 
               regex = "(.+) (\\w+)")

# Initialize the data frame
geocoded <- data.frame(origAddress)

# Remove origAddress


# Loop through the addresses to get the latitude and longitude of each address and add it to the
# origAddress data frame in new columns lat and lon
for(i in 1:nrow(origAddress))
{
  # Print("Working...")
  result <- geocode(origAddress$Address[i], output = "latlona", source = "google")
  origAddress$lon[i] <- as.numeric(result[1])
  origAddress$lat[i] <- as.numeric(result[2])
  origAddress$geoAddress[i] <- as.character(result[3])
}
# Write a CSV file containing origAddress to the working directory
write.csv(origAddress, "geocoded.csv", row.names=FALSE)

export(origAddress, "XXXX_Locations.xlsx")
summary(origAddress)
