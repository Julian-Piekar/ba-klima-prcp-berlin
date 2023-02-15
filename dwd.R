# BER = 427

ber <- read.csv("C:/UNI/BA/BA Klima/R Studio/dwd-daten/427_h_0104_1219.csv", header=TRUE, 
               na.strings="NA", dec=".", stringsAsFactors = T, sep = ";")
ber$MESS_DATUM <- as.POSIXct(as.character(ber$MESS_DATUM),format = "%Y%m%d%H",tz="UTC")

minhour <- seq(as.POSIXct("2004-01-01 00:00:00"), as.POSIXct("2004-12-31 23:00:00"), by="hour")
minhour <- data.frame( MESS_DATUM = minhour)


ber <- merge(minhour, ber, by ="MESS_DATUM", all.x = T)
ber[is.na(ber)] <- 0
ber[ber == -999] <- 0
