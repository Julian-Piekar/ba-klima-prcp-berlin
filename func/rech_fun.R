# Funktion um statistische Kenngrößen zu ermitteln

require(Metrics)
require(verification)

rech_fun <- function(filename){
  
df <- read.csv(filename)
attach(df)
count <- ifelse(cer.PRCP > 0 &  dwd.R1 > 0, 'hit', 
         ifelse(cer.PRCP > 0 &  dwd.R1 == 0, 'fal',
         ifelse(cer.PRCP == 0 & dwd.R1 > 0, 'mis', 'cor' )))

count <- data.frame(count)
dfcount <- data.frame(df, count)

hit <- sum(count == "hit") #A
fal <- sum(count == "fal") #B
mis <- sum(count == "mis") #C
cor <- sum(count == "cor") #D

# contigency table, use func multi.cont (lib:verification) = bias, far, hss, pc = % correct
cont <- matrix(c(hit, mis, fal, cor), ncol = 2)
rownames(cont) <- c("YES", "NO") 
colnames(cont) <- c("YES", "NO") 
cont <- multi.cont(cont)
hss <- cont$hss

bias <- (hit+fal) / (hit+mis)
far <- fal / (hit+fal)
pofd <- fal / (fal+cor)
pod <- hit / (hit+mis)

mae <- mae(dwd.R1, cer.PRCP)
rmse <- rmse(dwd.R1, cer.PRCP)

statlist <- list(bias, far, pofd,  pod, hss, mae, rmse)
statlist <- data.frame(statlist)
colnames(statlist) <- c("bias", "far", "pofd", "pod", "hss","mae", "rmse")
detach(df)
return(statlist)
}
