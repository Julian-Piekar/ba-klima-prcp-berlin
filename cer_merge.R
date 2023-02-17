# Skript um mittels Funktion CER-Daten zu kombinieren, muss für jede Station angepasst werden

# 2.  Wetterstationen 
# 2.1 Koordinaten Wetterstationen
# Stations_id von_datum bis_datum Stationshoehe geoBreite geoLaenge  Stationsname             Bundesland
# 10399       19950901 20220207             37     52.5198   13.4057 Berlin-Alexanderplatz    Berlin
# 20400       20040601 20230130             60     52.6310   13.5021 Berlin-Buch              Berlin                                                                                            
# 30403       20020128 20230130             51     52.4537   13.3017 Berlin-Dahlem (FU)       Berlin                                                                                            
# 40410       20040501 20200616             33     52.4040   13.7309 Berlin-Kaniswall         Berlin                                                                                            
# 50420       20070801 20230130             61     52.5447   13.5598 Berlin-Marzahn           Berlin                                                                                            
# 60427       19950901 20230130             46     52.3807   13.5306 Berlin Brandenburg       Brandenburg                                                                                       
# 70430       19950901 20210505             36     52.5644   13.3088 Berlin-Tegel             Berlin                                                                                            
# 80433       19950901 20230130             48     52.4675   13.4021 Berlin-Tempelhof         Berlin

# load libraries
require(ncdf4)
require(dplyr)
library(pryr)
source("cer_fun.R")

# func liesst in Jahr.nc prcp an lon/lat aus und erstellt data.frame, lon/lat anpassen 
cer_1_1 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2001.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_2 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2002.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_3 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2003.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_4 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2004.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_5 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2005.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_6 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2006.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_7 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2007.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_8 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2008.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_9 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2009.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_10 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2010.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_11 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2011.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_12 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2012.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_13 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2013.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_14 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2014.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_15 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2015.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_16 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2016.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_17 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2017.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_18 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2018.nc", "prcp", 13.4057, 52.5198)
mem_used()
cer_1_19 <- cer_fun("./cer-daten/CER_d02km_h_2d_prcp_2019.nc", "prcp", 13.4057, 52.5198)
mem_used()

# erstellt liste mit allen data.frames
list1 <- list(cer_1_1,cer_1_2,cer_1_3,cer_1_4,cer_1_5,cer_1_6,cer_1_7,cer_1_8,cer_1_9,cer_1_10,
              cer_1_11,cer_1_12,cer_1_13,cer_1_14,cer_1_15,cer_1_16,cer_1_17,cer_1_18,cer_1_19)

# merge func, schneidet zeilen in denen cer nicht lief aus, lässt index bei 1 anfangen, schneidet column 1/2; lon/lat aus
list1 <- Reduce(function(x,y) merge(x,y, all=T), list1) 
list1 <- list1[1417:92735,]
rownames(list1) <- NULL

# "listx.csv" ändern damit neue liste erstellt wird 
write.csv(list1, "./cer-daten/cer_1_full.csv", row.names = F, quote = F)
