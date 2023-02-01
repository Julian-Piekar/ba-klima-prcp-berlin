# Untersuchung von Starkregenereignissen im Raum Berlin mithilfe der CER Daten. 
# Ziel: Genauigkeit CER mithilfe von Observierung überprüfen
# - Welche Abweichungen sind zwischen Niederschlagshöhen der CER und Observierung zu ermitteln?
# - Inwieweit stimmt räum- zeitliche  Verteilung und Intensität von Starkniederschlägen CER - Observierung überein?
# 2017 Starkregenereignis untersuchen?
# 10km Auflösung mit 2km vergleichen um Unterschiede zu untersuchen

# 1.  Tage nach Starkregen suchen  25 mm / Tag
# 1.1 Stündlich nach Starkregen suchen 17mm / Std

# 2.  Wetterstationen 
# 2.1 Koordinaten Wetterstationen

# Stations_id von_datum bis_datum Stationshoehe geoBreite geoLaenge  Stationsname             Bundesland
# 00399       20150701  20220207             37  52.5198   13.4057   Berlin-Alexanderplatz    Berlin
#00400 20040601 20230130             60     52.6310   13.5021 Berlin-Buch                              Berlin                                                                                            
#00403 20020128 20230130             51     52.4537   13.3017 Berlin-Dahlem (FU)                       Berlin                                                                                            
#00410 20040501 20200616             33     52.4040   13.7309 Berlin-Kaniswall                         Berlin                                                                                            
#00420 20070801 20230130             61     52.5447   13.5598 Berlin-Marzahn                           Berlin                                                                                            
#00427 19950901 20230130             46     52.3807   13.5306 Berlin Brandenburg                       Brandenburg                                                                                       
#00430 19950901 20210505             36     52.5644   13.3088 Berlin-Tegel                             Berlin                                                                                            
#00433 19950901 20230130             48     52.4675   13.4021 Berlin-Tempelhof                         Berlin

# 3.  Wetterstationen mit CER abgleichen (Niederschlagsmenge)

setwd("C:/UNI/BA/Themen Klima/R Studio")

##################################################################################
# Script read CER-Data (needs packages terra RColorBrewer and 
#        user defined functions in CER_function.R)
# Example data set is in 2d "t2" see example path in fpath1  


# load libraries
library(terra) # newer than raster
library(RColorBrewer) # map colour ramp
#-Modify!!!
source('C:/UNI/BA/BA Klima/R Studio/CER_functions.R')

# prcp hourly
#input paths -Modify!!!
fpath1 <-  "C:/UNI/BA/BA Klima/R Studio/cer-daten/CER_d02km_h_2d_prcp_2001.nc"
ncdir <-  "C:/UNI/BA/BA Klima/R Studio/cer-daten/" 

# output directory - Modify!!!
out_dir <- "C:/UNI/BA/BA Klima/R Studio/neu-daten"

# get admin boundaries of Berlin- MODIFY!!! if not in current working directory
fpath_berlin <- "C:/UNI/BA/BA Klima/R Studio/pj_adapt_or_suffer_wise2122-main/data/gadm36_DEU_1.shp" # administrative boundaries

berlin <- vect(fpath_berlin)# convert to terra-vector object

# read CER-data
berlin_prcp_2001nc  <- read_CER(fpath1, aggr = list(TRUE,"mean"))
berlin_prcp_2001plt <- proj_CER(berlin_prcp_2001nc, ncdir)

# plot the data
plot(berlin_prcp_2001plt, col=rev(brewer.pal(10,"RdBu")))
# plot Berlin admin border on top
lines(berlin, lwd=1)

# t2 month
#input paths -Modify!!!
fpath1 <-  "C:/UNI/BA/BA Klima/R Studio/CER_d02km_m_2d_t2_2003.nc"
ncdir <-  "C:/UNI/BA/BA Klima/R Studio/cer-daten/" 

# output directory - Modify!!!
out_dir <- "C:/UNI/BA/BA Klima/R Studio/neu-daten"

# get admin boundaries of Berlin- MODIFY!!! if not in current working directory
fpath_berlin <- "C:/UNI/BA/BA Klima/R Studio/pj_adapt_or_suffer_wise2122-main/data/gadm36_DEU_1.shp" # administrative boundaries

berlin <- vect(fpath_berlin)# convert to terra-vector object

# read CER-data
berlin_t2_2003nc  <- read_CER(fpath1, aggr = list(TRUE,"mean"))
berlin_t2_2003plt <- proj_CER(berlin_t2_2003nc, ncdir)

# plot the data
plot(berlin_t2_2003plt, col=rev(brewer.pal(10,"RdBu")))
# plot Berlin admin border on top
lines(berlin, lwd=1)
# write geotiff to disk - uncomment and modify if needed
# writeRaster(ber2018apl2oct, paste0(out_dir,"berlin_2018apl2oct.tif"), overwrite=TRUE)
# writeRaster(ber2002apl2oct, paste0(out_dir,"berlin_2002apl2oct.tif"), overwrite=TRUE)
##############################################################################################

#alex hour
# hier habe ich versucht die Niederschlagsdaten von der Station am Alex einzulesen
# und Mess Datum und Niederschlagshöhe zu Filtern um diese dann mit den CER Daten zu vergleichen

install.packages("hydroTSM")
require(ncdf4)
require(zoo)
require(hydroTSM)
require(dplyr)
#library(tidyverse)

alex<-read.table("produkt_precipitation_399_akt.txt", header=TRUE, 
                 na.strings="NA", dec=".", stringsAsFactors = T, sep = ";")
attach(alex)

alex_select <- select(alex, 2,5)
attach(alex_select)

alex_select1 <- as.numeric(as.character(alex_select$MESS_DATUM.NIEDERSCHLAGSHOEHE.eor))


#daily mean

#2001
nc.file <- "./cer-daten/CER_d02km_d_2d_prcp_2001.nc"

# Open NetCDF file and print summary

nc <- nc_open(nc.file)

print(nc)
summary(nc)
# Extract year as character string

year <- substr(nc$dim$time$units, 14, 17)

# Read longitude/latitude of grid points

lon <- ncvar_get(nc, varid="lon")
lat <- ncvar_get(nc, varid="lat")

# Read data

pr <- ncvar_get(nc, varid="prcp")
pr

# Close CER file

nc_close(nc)

pr.m <- vector() # empty vector for daily mean P for entire domain


for (i in 1:365) pr.m[i] <- max(pr[,,i], na.rm=TRUE) # spatial average for each day

print("")
print("Daily means")
print("---------------------------")
print(round(pr.m, digits=1)) # output to console (digits = 1 bedeutet dass die Werte auf eine Stelle nach dem Komma gerundet werden)

plot(1:365, pr.m, main="Mean daily pr (CER 2 km domain)",
     xlab=paste0("Days ", year), ylab="PRCP")

#2002 daily
nc.file2 <- "./cer-daten/CER_d02km_d_2d_prcp_2002.nc"

# Open NetCDF file and print summary

nc2 <- nc_open(nc.file2)

print(nc2)

# Extract year as character string

year <- substr(nc2$dim$time$units, 14, 17)

# Read longitude/latitude of grid points

lon <- ncvar_get(nc2, varid="lon")
lat <- ncvar_get(nc2, varid="lat")

# Read data

pr2 <- ncvar_get(nc2, varid="prcp")

# Close CER file

nc_close(nc2)

pr.m2 <- vector() # empty vector for daily mean P for entire domain


for (i in 1:365) pr.m2[i] <- max(pr2[,,i], na.rm=TRUE) # spatial average for each day

print("")
print("Daily means")
print("---------------------------")
print(round(pr.m2, digits=1)) # output to console (digits = 1 bedeutet dass die Werte auf eine Stelle nach dem Komma gerundet werden)

plot(1:365, pr.m2, main="Mean daily pr (CER 2 km domain)",
     xlab=paste0("Days ", year), ylab="PRCP")


#2001 hour
nc.file.h1 <- "CER_d02km_h_2d_prcp_2001.nc"

# Open NetCDF file and print summary

nc.h1 <- nc_open(nc.file.h1)

print(nc.h1)
summary(nc.h1)
# Extract year as character string

year <- substr(nc.h1$dim$time$units, 1, 16)

# Read longitude/latitude of grid points

lon <- ncvar_get(nc.h1, varid="lon")
lat <- ncvar_get(nc.h1, varid="lat")

# Read data

pr.h1 <- ncvar_get(nc.h1, varid="prcp")

# Close CER file

nc_close(nc.h1)

pr.m.h1 <- vector() # empty vector for daily mean P for entire domain

for (i in 1:8760) pr.m.h1[i] <- max(pr.h1[,,i], na.rm=TRUE) # spatial average for each day
options(max.print=9000)
print("")
print("Daily means")
print("---------------------------")
print(round(pr.m.h1, digits=1)) # output to console (digits = 1 bedeutet dass die Werte auf eine Stelle nach dem Komma gerundet werden)

plot(1:8760, pr.m.h1, main="Max daily prcp (CER 2 km domain)",
     xlab=paste0( year), ylab="PRCP mm/h")