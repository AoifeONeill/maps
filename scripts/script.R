library(ggplot2)
library(sp)
library(sf)
library(rgdal)
library(devtools)

shpfile <- "~/maps/data/MSOA/Middle_Layer_Super_Output_Areas_December_2011_Full_Clipped_Boundaries_In_England_and_Wales.shp"
emptymap <- st_read(dsn = shpfile) #read the shp format into R

#The sf package will use these coördinates in the shape file to plot the borders using plot ()
plot(emptymap$geometry)

View(neighborhoods)
Chloropleth_heat_map <- ggplot(population_data) + 
  geom_sf(aes(fill = pop_est)) +
  scale_fill_gradient(low = "#edf8e9", high = "#005a3