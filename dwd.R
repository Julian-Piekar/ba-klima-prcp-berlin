alex<-read.table("C:/UNI/BA/BA Klima/R Studio/dwd-daten/399_h_0301_0711.csv", header=TRUE, 
                 na.strings="NA", dec=".", stringsAsFactors = T, sep = ";")

alex$MESS_DATUM <- as.POSIXct(as.character(alex$MESS_DATUM),format = "%Y%m%d%H",tz="UTC")

buch<-read.table("C:/UNI/BA/BA Klima/R Studio/dwd-daten/400_h_0604_0519.csv", header=TRUE, 
                 na.strings="NA", dec=".", stringsAsFactors = T, sep = ";")

buch$MESS_DATUM <- as.POSIXct(as.character(buch$MESS_DATUM),format = "%Y%m%d%H",tz="UTC")


