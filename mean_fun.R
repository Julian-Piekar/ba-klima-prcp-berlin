require("stringr")

mean_fun <- function(filename){

dfile <- data.frame(filename)

dfile1 = dfile[str_detect(dfile$MESS_DATUM, "-01"), ]
dfile2 = dfile[str_detect(dfile$MESS_DATUM, "-02"), ]
dfile3 = dfile[str_detect(dfile$MESS_DATUM, "-03"), ]
dfile4 = dfile[str_detect(dfile$MESS_DATUM, "-04"), ]
dfile5 = dfile[str_detect(dfile$MESS_DATUM, "-05"), ]
dfile6 = dfile[str_detect(dfile$MESS_DATUM, "-06"), ]
dfile7 = dfile[str_detect(dfile$MESS_DATUM, "-07"), ]
dfile8 = dfile[str_detect(dfile$MESS_DATUM, "-08"), ]
dfile9 = dfile[str_detect(dfile$MESS_DATUM, "-09"), ]
dfile10 = dfile[str_detect(dfile$MESS_DATUM, "-10"), ]
dfile11 = dfile[str_detect(dfile$MESS_DATUM, "-11"), ]
dfile12 = dfile[str_detect(dfile$MESS_DATUM, "-12"), ]

mean1 = colMeans(dfile1[, c(2,3)], na.rm = T)
mean2 = colMeans(dfile2[, c(2,3)], na.rm = T)
mean3 = colMeans(dfile3[, c(2,3)], na.rm = T)
mean4 = colMeans(dfile4[, c(2,3)], na.rm = T)
mean5 = colMeans(dfile5[, c(2,3)], na.rm = T)
mean6 = colMeans(dfile6[, c(2,3)], na.rm = T)
mean7 = colMeans(dfile7[, c(2,3)], na.rm = T)
mean8 = colMeans(dfile8[, c(2,3)], na.rm = T)
mean9 = colMeans(dfile9[, c(2,3)], na.rm = T)
mean10 = colMeans(dfile10[, c(2,3)], na.rm = T)
mean11 = colMeans(dfile11[, c(2,3)], na.rm = T)
mean12 = colMeans(dfile12[, c(2,3)], na.rm = T)

meanlist=bind_rows(mean1,mean2,mean3,mean4,mean5,mean6,mean7,mean8,mean9,mean10,mean11,mean12)
meanlist <- meanlist %>% mutate_if(is.numeric, round, digits = 2)

return(meanlist)
