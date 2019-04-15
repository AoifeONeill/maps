library(ggplot2)
library(sf)
library(raster)
library(spData)
library(dplyr)
library(rgdal)

setwd("~/data/MSOA")

#Read in files
data_file <- read.csv("Outputed_data.csv")

count_data <- data_file %>%
  dplyr::count(msoa11cd)

count_data = count_data[-1,]


### Read in coordinate reference systems (CRS) to use
latlong = "+init=epsg:4326"
OSGB = "+init=epsg:27700"

#Read in Shape file. Taken from the geoportal. 
#The lowest breakdown available was larger then North Lincolnshire
shape_file <- readOGR(dsn = "~/data/MSOA/", layer = "Middle_Layer_Super_Output_Areas_December_2011_Full_Clipped_Boundaries_in_England_and_Wales")

#Transform the shape file to have CRS assigned above
MSOA.SP <- spTransform(shape_file,CRS(OSGB))

#Turn the Spatial file in to a simple feature so that we can filter it
MSOA.SP <- st_as_sf(MSOA.SP)


#Read in csv which contains the MSOA's in North Lincolnshire
north_lincs_msoa <- read.csv("lincolnshire_msoa.csv", header = TRUE)

#Filter the shape file to only include north_lincs msoa's
empty_map_north_lincs <- MSOA.SP %>%
 dplyr::filter(msoa11cd %in% north_lincs_msoa$msoa11cd)

#Bind the count data to the shape file so that we can create the heat map
count_data_bound <- bind_cols(empty_map_north_lincs, count_data, id = empty_map_north_lincs$msoa11cd)


#plot data
Chloropleth_heat_map <- ggplot(count_data_bound) + 
  geom_sf(aes(fill = n)) +
  scale_fill_gradient()+
  theme(panel.grid.major = element_line(colour = 'transparent'),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  axis.ticks = element_blank(),
  rect = element_blank())

Chloropleth_heat_map

setwd("~/")

ggsave("output/chloropleth_heat_map.PNG", plot = Chloropleth_heat_map)

write.csv(count_data_bound, "output/MSOA_Employees.csv")

Chloropleth_heat_map





