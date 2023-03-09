
# Installing packages
install.packages('raster')

library(raster)


mean_temp <- raster('data/wc2.1_5m_bio_1.tif')

mean_temp

plot(mean_temp)

climate <- stack(c('data/wc2.1_5m_bio_1.tif','data/wc2.1_5m_bio_12.tif'))
climate

plot(climate)
plot(climate[[1]])
plot(climate[[2]])

names(climate) <- c('temp','prec')
climate

climate_namer <- crop(climate,c(-141,-51,17,59))
plot(climate_namer[[1]])
climate_namer

climate_namer_lowres <- aggregate(climate_namer, fact = 2, fun = mean)
plot(climate_namer_lowres[[1]])
plot(climate_namer[[1]])

ncell(climate_namer)
ncell(climate_namer_lowres)

climate_values <- rasterToPoints(climate_namer_lowres)
head(climate_values)

library(ggplot2)
climate_values <- data.frame(climate_values)
ggplot(data = climate_values,aes(x = temp, y = prec))+geom_point(alpha = 0.2)

library(sf)
states <- read_sf('data/us_state_boundaries/ne_110m_admin_1_states_provinces.shp')

library(dplyr)
ny_state <- states %>% filter(name == 'New York')

plot(climate_namer_lowres[[1]])
plot(ny_state,add=T)

ny_climate <- mask(climate_namer_lowres,ny_state)
plot(ny_climate[[1]])

ny_climate_values <- rasterToPoints(ny_climate)
ny_climate_values <- data.frame(ny_climate_values)
ggplot(data = ny_climate_values,aes(x = temp, y = prec))+geom_point(alpha = 0.5)

ggplot()+
  geom_raster(climate_values, mapping=aes(x=x,y=y,fill=temp))+
  geom_sf(data = states, alpha = 0)+
  coord_sf(xlim = c(-141,-51), ylim = c(17,59))

library(viridis)
ggplot()+
  geom_raster(climate_values, mapping=aes(x=x,y=y,fill=temp))+
  geom_sf(data = states, alpha = 0, color = 'antiquewhite')+
  scale_fill_viridis()+
  coord_sf(xlim = c(-141,-51), ylim = c(17,59))
