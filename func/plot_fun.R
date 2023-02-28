require(ggplot2)
require(lubridate)
require(scales)

plot_fun <- function(filename, ort, jahr){
  
  #df = read.csv(filename) # csv & dwd.MESS_DATUM
  df = data.frame(filename)
  
  #df$dwd.MESS_DATUM = as.POSIXct(df$dwd.MESS_DATUM, format = "%Y-%m-%d%H",tz="UTC")
  df$MESS_DATUM = as.POSIXct(df$MESS_DATUM, format = "%Y-%m-%d%H",tz="UTC")
  
  dfx = df %>%
    drop_na(dwd.R1)%>% # ohne NA
    #mutate(year = year(dwd.MESS_DATUM))%>%
    mutate(year = year(MESS_DATUM))%>%
    filter(year == jahr)%>%
    mutate(cer_prcp = cumsum(cer.PRCP),
           dwd_prcp = cumsum(dwd.R1))
  
  p= print(ggplot()+
        #geom_line(dfx, mapping=aes(x= dwd.MESS_DATUM, y = cer_prcp, color = "green"))+
        #geom_line(dfx, mapping=aes(x= dwd.MESS_DATUM, y = dwd_prcp, color = "red"))+
          geom_line(dfx, mapping=aes(x= MESS_DATUM, y = cer_prcp, color = "green"))+
          geom_line(dfx, mapping=aes(x= MESS_DATUM, y = dwd_prcp, color = "red"))+
        scale_x_datetime(date_breaks="1 year", labels= label_date(format="%Y"))+
          ggtitle(paste0("", ort, jahr))+
          xlab("Zeitraum") + ylab("Niederschlag (mm)")+
          scale_color_manual(labels = c("CER v1", "DWD"), values = c("green", "red"))+
          theme(legend.title = element_blank()))
  
        ggsave(file=paste0("Plot",ort,jahr,".png"), path =  "./results2/", width = 20, height = 20, units = "cm", p)
  
  return(dfx)
