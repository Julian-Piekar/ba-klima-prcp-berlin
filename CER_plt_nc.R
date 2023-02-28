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
berlin_prcp_2018nc  <- read_CER(fpath1, sub= c(4816,4868), aggr = list(TRUE,"sum"))
berlin_prcp_2018plt <- proj_CER(berlin_prcp_2018nc, ncdir)

# plot the data
plot(berlin_prcp_2018plt, main =" Sum 2017 ", col=rev(brewer.pal(11,"RdYlBu")))
# plot Berlin admin border on top
lines(berlin, lwd=1)

# write geotiff to disk - uncomment and modify if needed
# writeRaster(ber2018apl2oct, paste0(out_dir,"berlin_2018apl2oct.tif"), overwrite=TRUE)
# writeRaster(ber2002apl2oct, paste0(out_dir,"berlin_2002apl2oct.tif"), overwrite=TRUE)
##############################################################################################
