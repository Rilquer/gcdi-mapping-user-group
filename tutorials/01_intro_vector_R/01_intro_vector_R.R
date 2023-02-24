
# Install packages
install.packages()
install.packages('tidyverse')
install.packages('sf')

library(tidyverse)
library(sf)

states <- read_sf('data/shapefiles/us_state_boundaries/ne_110m_admin_1_states_provinces.shp')

ggplot() + geom_sf(data = states)

ggplot() + geom_sf(data = states) + theme_minimal()

countries <- read_sf('data/shapefiles/world_countries/ne_110m_admin_0_countries.shp')

ggplot() + geom_sf(data = countries) + geom_sf(data = states) + theme_minimal()

ggplot() + geom_sf(data = countries) + theme_minimal()

ggplot() + geom_sf(data = states) + geom_sf(data = countries, alpha = 0) +
  theme_minimal()

ggplot() + geom_sf(data = countries) + geom_sf(data = states) +
  coord_sf(xlim = c(-130.327727,-50.774995), ylim = c(24.321161,52.537236))+
  theme_minimal()


library(tidyverse)
states_gdp <- read_csv('data/states_gdp.csv')
states_gdp

states <- states %>% left_join(states_gdp, by='name')

ggplot() + geom_sf(data = countries) +
  geom_sf(data = states, aes(fill = gdp)) +
  coord_sf(xlim = c(-130.327727,-50.774995), ylim = c(24.321161,52.537236)) +
  theme_minimal()

# Customizing background color
ggplot() + geom_sf(data = countries, fill = 'antiquewhite')+
  geom_sf(data = states,aes(fill = gdp))+
  coord_sf(xlim = c(-130.327727,-50.774995), ylim = c(24.321161,52.537236))+
  theme_bw()

ggplot()+geom_sf(data = countries, fill = 'antiquewhite')+
  geom_sf(data = states,aes(fill = gdp))+
  coord_sf(xlim = c(-130.327727,-50.774995), ylim = c(24.321161,52.537236))+
  theme_bw()+scale_fill_gradient2(low = '#f0f9e8',mid = '#7bccc4',high = '#0868ac')


ggplot()+geom_sf(data = countries, fill = 'antiquewhite')+
  geom_sf(data = states,aes(fill = gdp))+
  coord_sf(xlim = c(-130.327727,-50.774995), ylim = c(24.321161,52.537236))+
  theme_bw()+scale_fill_gradient2(low = '#f0f9e8',mid = '#7bccc4',high = '#0868ac')+
theme(legend.position = "none")

# Customizing axis labels and title
ggplot()+geom_sf(data = countries, fill = 'antiquewhite')+
  geom_sf(data = states,aes(fill = gdp))+
  coord_sf(xlim = c(-130.327727,-50.774995), ylim = c(24.321161,52.537236))+
  theme_bw()+scale_fill_gradient2(low = '#f0f9e8',mid = '#7bccc4',high = '#0868ac')+
theme(legend.position = "none")+
  labs(title = "GDP of the lower 48 states in the US",
       x = 'Longitude',
       y = 'Latitude')

library('ggspatial')

# Adding scale and north arrow
ggplot()+geom_sf(data = countries, fill = 'antiquewhite')+
  geom_sf(data = states,aes(fill = gdp))+
  coord_sf(xlim = c(-130.327727,-50.774995), ylim = c(24.321161,52.537236))+
  theme_bw()+scale_fill_gradient2(low = '#f0f9e8',mid = '#7bccc4',high = '#0868ac')+
theme(legend.position = "none")+
  labs(title = "GDP of the lower 48 states in the US",
       x = 'Longitude',
       y = 'Latitude')+
  annotation_scale(location = "br")+
  annotation_north_arrow(location = "br")

# Adjusting scale and north arrows
ggplot()+geom_sf(data = countries, fill = 'antiquewhite')+
  geom_sf(data = states,aes(fill = gdp))+
  coord_sf(xlim = c(-130.327727,-50.774995), ylim = c(24.321161,52.537236))+
  theme_bw()+scale_fill_gradient2(low = '#f0f9e8',mid = '#7bccc4',high = '#0868ac')+
  theme(legend.position = "none")+
  labs(title = "GDP of the lower 48 states in the US",
       x = 'Longitude',
       y = 'Latitude')+
  annotation_scale(location = "br", width_hint = 0.3)+
  annotation_north_arrow(location = "br",
                         pad_x = unit(0.3, "in"), pad_y = unit(0.5, "in"),
                         style = north_arrow_fancy_orienteering)

ggsave('saved_maps/us_states_gdp.tiff', width = 15, height = 10)
