# load libraries
library(terra) # newer than raster
library(RColorBrewer) # map colour ramp
require(ncdf4)

#source('C:/UNI/BA/BA Klima/R Studio/CER_functions.R')


# Open NetCDF file and print summary
nc1 <- nc_open("./cer-daten/c400_04o.nc")

print(nc1)

# Extract year as character string
year <- substr(nc1$dim$time$units, 13, 16)

# Read longitude/latitude of grid points
lon <- ncvar_get(nc1, varid="lon")
lat <- ncvar_get(nc1, varid="lat")

# Read data
pr1 <- ncvar_get(nc1, varid="prcp")

# Close CER file
nc_close(nc1)

pr.m1 <- vector() # empty vector for hourly prcp

for (i in 1:8760) pr.m1[i] <- max(pr1[i], na.rm=TRUE)
options(max.print=8760)
print("")
print("Hourly")
print("---------------------------")
print(round(pr.m1, digits=1)) # output to console (digits = 1 bedeutet dass die Werte auf eine Stelle nach dem Komma gerundet werden)

plot(1:8760, pr.m1, main="Hourly pr (CER 2 km domain)",
     xlab=paste0("Hours ", year), ylab="PRCP mm h-1")
