library(ggplot2)
library(sp)
library(sf)
library(rgdal)



Chloropleth_heat_map <- ggplot(population_data) + 
  geom_sf(aes(fill = pop_est)) +
  scale_fill_gradient(low = "#edf8e9", high = "#005a32")