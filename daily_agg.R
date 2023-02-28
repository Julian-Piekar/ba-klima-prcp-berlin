source("daily_fun.R")
source("mean_fun.R")
library(data.table)

# neuer data.frame mit täglichen summen für analyse
dailyAL <- daily_fun("./cer-daten2km/df1.csv")

monthAL <- month_fun(dailyAL)

#mean
mdurch1 = mean_fun(monthTH)

row.names(mdurch1) = c("Jan", "Feb", "Mär", "Apr", "Mai", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dez")
colnames(Durchschnitt1) = c("Monat", "cer.PRCP", "dwd.R1")

# sum
yearAL <- year_fun(dailyAL)

# mean
mean1 = colMeans(yearAL[, c(2,3)], na.rm = T)



