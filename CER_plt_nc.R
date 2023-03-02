source('CER_functions.R')
require(terra)
require(RColorBrewer)

#input
fpath1 <-  "./cer-daten2km/CER_d02km_h_2d_prcp_2017.nc"
ncdir <-  "./cer-daten2km/"

# output
out_dir <- "./results2/"

# get admin boundaries of Berlin
fpath_berlin <- "./data/gadm36_DEU_1.shp" 

berlin <- vect(fpath_berlin)# convert to terra-vector object

# read CER-data
berlin_prcp_2017nc  <- read_CER(fpath1, sub= c(4860,4868), aggr = list(TRUE,"sum")) # sub = Zeitraum Tage (über Index) und bilde Summe
berlin_prcp_2017plt <- proj_CER(berlin_prcp_2017nc, ncdir)

# Stationen und summierter Niederschlag an den Stationen in dem Zeitraum
lon <- c(13.4057, 13.5021, 13.3017, 13.7309, 13.5598, 13.5306, 13.3088, 13.4021)
lat <- c(52.5198, 52.6310, 52.4537, 52.4040, 52.5447, 52.3807, 52.5644, 52.4675)
precip = c(0, 45.9, 46.4, 32.8, 52.2, 0, 0, 19.7)
sta <- cbind(lon, lat, precip)

sta = as.data.frame(sta)%>%
  mutate(precip_cati = cut(precip,
                  breaks = c(-Inf, 0, 20, 40, 50, Inf),
                  labels = c("Null",
                             "low",
                             "mid",
                             "high",
                             "very high")))

plot(berlin_prcp_2017plt, main =" Sum 2017 ", col=rev(brewer.pal(11,"RdYlBu"))) # der Plot zeigt den Niederschlag korrekt, 
lines(berlin, lwd =1)                                                            # aber die Stationen lassen nicht nicht nach Niederschlagmenge färben
points(sta, col= precip_cati, cex = 1 ,pch =19)

# Versuch 2: hier ändern die Stationen ihre Farbe entsprechend der Niederschlagsmenge, 
# aber hier wird ab spec_vector nicht mehr Brandenburg/Berlin angeziegt, sondern ganz Deutschland
ggplot()+
  geom_spatraster(data = berlin_prcp_2018plt)+
  geom_spatvector(data=berlin,
                  mapping =aes(),
                  colour = "grey10", fill = NA)+
  geom_point(data = sta,
             aes(x=lon, y=lat, col=precip_cati),
             alpha = .5,
             size = 1.5)


