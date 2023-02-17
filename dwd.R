############################################################################################
# Buch 2 400
# Liesst DWD-Daten aus .csv aus, ergänzt fehlende Zeilen/Stunden mit 0, gibt neue vollständige .csv aus
# Muss für jede Station gemacht werden

buch <- read.csv("./dwd-daten/Archive/400_h.csv", header=TRUE, 
                 na.strings="NA", dec=".", stringsAsFactors = T, sep = ";")
buch$MESS_DATUM <- as.POSIXct(as.character(buch$MESS_DATUM),format = "%Y%m%d%H",tz="UTC")
buch <- buch[1:131439,]

minhour <- seq(as.POSIXct("2004-06-01 00:00:00"), as.POSIXct("2019-06-01 00:00:00"), by="hour")
minhour <- data.frame( MESS_DATUM = minhour)

buch <- merge(minhour, buch, by ="MESS_DATUM", all.x = T)
buch[is.na(buch)] <- 0
buch[buch == -999] <- 0

write.csv(buch, "./dwd-daten/buch_2_full.csv", row.names = F, quote = F)
