# Daily
daily_fun <- function(filename) {
dfile <- read.csv(filename)  

Date.time.POSIX = strptime(dfile$dwd.MESS_DATUM, format = "%Y-%m-%d%H", tz="UTC")

#plot(Date.time.POSIX, df1$dwd.R1, type = "l")
#plot(Date.time.POSIX, df1$cer.PRCP, type = "l")

dates = format(Date.time.POSIX, "%Y-%m-%d", tz="UTC")

dwd_prcp = aggregate(dfile$dwd.R1, by=list(dates), FUN=sum, na.rm=TRUE, na.action=NULL)
cer_prcp = aggregate(dfile$cer.PRCP, by=list(dates), FUN=sum)

dfile_daily = data.frame(cer_prcp, dwd_prcp)
dfile_daily = dfile_daily[, -3]
colnames(dfile_daily) = c("MESS_DATUM", "cer.PRCP", "dwd.R1")

return(dfile_daily)
}

# Monthly
month_fun <- function(filename) {
  dfile <- data.frame(filename)  
  
  Date.time.POSIX = strptime(dfile$MESS_DATUM, format = "%Y-%m-%d", tz="UTC")
  
  dates = format(Date.time.POSIX, "%Y-%m", tz="UTC")
  
  dwd_prcp = aggregate(dfile$dwd.R1, by=list(dates), FUN=sum, na.rm=TRUE, na.action=NULL)
  cer_prcp = aggregate(dfile$cer.PRCP, by=list(dates), FUN=sum)
  
  dfile_daily = data.frame(cer_prcp, dwd_prcp)
  dfile_daily = dfile_daily[, -3]
  colnames(dfile_daily) = c("MESS_DATUM", "cer.PRCP", "dwd.R1")
  
  return(dfile_daily)
}

# Yearly
year_fun <- function(filename) {
  dfile <- data.frame(filename)  
  
  Date.time.POSIX = strptime(dfile$MESS_DATUM, format = "%Y-%m-%d", tz="UTC")
  
  dates = format(Date.time.POSIX, "%Y", tz="UTC")
  
  dwd_prcp = aggregate(dfile$dwd.R1, by=list(dates), FUN=sum, na.rm=TRUE, na.action=NULL) 
  cer_prcp = aggregate(dfile$cer.PRCP, by=list(dates), FUN=sum)
  
  dfile_year = data.frame(cer_prcp, dwd_prcp)
  dfile_year = dfile_year[, -3]
  colnames(dfile_year) = c("MESS_DATUM", "cer.PRCP", "dwd.R1")
  
  return(dfile_year)
}
