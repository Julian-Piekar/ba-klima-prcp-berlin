################################################################################
# This script reads and subset CER v1 Data at a specific point
# along third dimension (e.g. to compare values in CER with station values)
# Task:
# I have station data that I want to compare with CER v1 data
# Therefore, I need to extract CER-data that is closest to my station

require(ncdf4)
require(dplyr)

fpath <- "./cer-daten/CER_d02km_h_2d_prcp_2004.nc"
ncin  <-  nc_open(filename = fpath)

#coor Buch
station_lat <- 52.3807
station_lon <- 13.5306

# Extract year as character string
year <- substr(ncin$dim$time$units, 13, 16)

# get variable prcp as it says in print-output
CER_prcp  <-  ncvar_get(ncin, "prcp")

# Now, we have the whole data-set as a "large array"

CER_lon <- ncvar_get(ncin,"lon")[,1] # as in x = lon direction because is stored in 2D
CER_lat <- ncvar_get(ncin,"lat")[1,] # as in y = lat direction because is stored in 2D

# Task: Get the closest latitude and longitude value from CER compared to station
# latitude and longitude value
# get the index (something between 1 and 140) where the difference between 
# lat/lon dwd and lat/lon CER is minimal

# for longitude
CER_lon_index <- which(abs(CER_lon - station_lon) == min(abs(CER_lon - station_lon)))
# check
CER_lon_index
CER_lon[CER_lon_index][1] # take first, just in case there are two or more values equally close

# for latitude
CER_lat_index <- which(abs(CER_lat - station_lat) == min(abs(CER_lat - station_lat)))
#check
CER_lat_index
CER_lat[CER_lat_index][1] # take first, just in case there are two or more values equally close

# time dimension has to be derived from ncdf attributes "time" and "units" (print(ncin))
# get time from attribute
CER_time_start <- unlist(strsplit(ncatt_get(ncin, "time", "units")$value, "since "))[2]

# compute sequence of hourly times stamps
CER_time <- seq(from = as.POSIXct(CER_time_start), length.out = dim(CER_prcp)[3], by = "hours")

# now we get z (values of prcp along third dimension) 
plot(CER_time,CER_prcp[CER_lon_index,CER_lat_index,], main="Hourly prcp (CER 2 km domain)",
                          xlab="Hours BER 2004", ylab="Prcp mm h-1")

# create matrix  of lon, lat, time 
lonlattime <- as.matrix(expand.grid(CER_lon_index,CER_lat_index,CER_time))

prcp_slice <- CER_prcp[84,68,]

# create data frame 
prcp_dat <- data.frame(cbind(lonlattime, prcp_slice))

# give right column names
colnames(prcp_dat) <- c("Lon","Lat","Date","PRCP")
head(prcp_dat)

# column PRCP in num to round 
prcp_dat$PRCP <- as.numeric(as.character(prcp_dat$PRCP))
prcp_dat <- prcp_dat %>% mutate_if(is.numeric, round, digits = 1) 

# always close the pointer to the open ncdf-file to avoid problems
nc_close(ncin)
