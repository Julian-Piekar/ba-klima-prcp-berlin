alex<-read.csv("C:/UNI/BA/BA Klima/R Studio/dwd-daten/399_h_0301_0711.csv", header=TRUE, 
                 na.strings="NA", dec=".", stringsAsFactors = T, sep = ";")
alex$MESS_DATUM <- as.POSIXct(as.character(alex$MESS_DATUM),format = "%Y%m%d%H",tz="UTC")

pr.a1 <- vector() # empty vector for hourly prcp

for (i in 1:8760) pr.a1[i] <- max(alex[i,3], na.rm=FALSE)
options(max.print=8760)
print("")
print("Hourly")
print("---------------------------")
print(round(pr.a1, digits=1)) # output to console (digits = 1 bedeutet dass die Werte auf eine Stelle nach dem Komma gerundet werden)

plot(1:8760, pr.a1, main="Hourly pr (CER 2 km domain)",
     xlab=paste0("Hours "), ylab="PRCP mm h-1")


buch<-read.csv("C:/UNI/BA/BA Klima/R Studio/dwd-daten/400_h_0604_0519.csv", header=TRUE, 
                 na.strings="NA", dec=".", stringsAsFactors = T, sep = ";")
buch$MESS_DATUM <- as.POSIXct(as.character(buch$MESS_DATUM),format = "%Y%m%d%H",tz="UTC")

#buch$STATIONS_ID <- as.numeric(as.character(buch$STATIONS_ID))
#buch$RS_IND <- as.numeric(as.character(buch$RS_IND))

pr.b1 <- vector() # empty vector for hourly prcp

for (i in 1:154118) pr.b1[i] <- max(buch[i,3], na.rm=FALSE)
options(max.print=10000)
print("")
print("Hourly")
print("---------------------------")
print(round(pr.b1, digits=1)) # output to console (digits = 1 bedeutet dass die Werte auf eine Stelle nach dem Komma gerundet werden)

plot(1:154118, pr.b1, main="Hourly pr (CER 2 km domain)",
     xlab=paste0("Hours "), ylab="PRCP mm h-1")
