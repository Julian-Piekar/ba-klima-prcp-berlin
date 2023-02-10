alex<-read.table("C:/UNI/BA/BA Klima/R Studio/dwd-daten/399_h_0301_0711.csv", header=TRUE, 
                 na.strings="NA", dec=".", stringsAsFactors = T, sep = ";")

alex$MESS_DATUM <- as.POSIXct(as.character(alex$MESS_DATUM),format = "%Y%m%d%H",tz="UTC")

buch<-read.table("C:/UNI/BA/BA Klima/R Studio/dwd-daten/400_h_0604_0519.csv", header=TRUE, 
                 na.strings="NA", dec=".", stringsAsFactors = T, sep = ";")

buch$MESS_DATUM <- as.POSIXct(as.character(buch$MESS_DATUM),format = "%Y%m%d%H",tz="UTC")


pr.a1 <- vector() # empty vector for hourly prcp

for (i in 1:8760) pr.a1[i] <- max(alex[i], na.rm=TRUE) #Error in FUN(X[[i]], ...) : only defined on a data frame with all numeric-alike variables
options(max.print=8760)
print("")
print("Hourly")
print("---------------------------")
print(round(pr.a1, digits=1)) # output to console (digits = 1 bedeutet dass die Werte auf eine Stelle nach dem Komma gerundet werden)

plot(1:8760, pr.a1, main="Hourly pr (DWD Alex)",
     xlab=paste0("Hours ", year), ylab="PRCP mm h-1")
