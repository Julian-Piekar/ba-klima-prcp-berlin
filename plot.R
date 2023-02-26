library(ggplot2)
library(lubridate)
require(plyr)
library(tidyr)
library(scales)

#Stundenwerte
df7_2006 = df7 %>%
  mutate(year = year(dwd.MESS_DATUM),
         month = month(dwd.MESS_DATUM),
         day = day(dwd.MESS_DATUM),
         hour = hour(dwd.MESS_DATUM))%>%
  filter(year == 2006)%>%
  mutate(cer_prcp = cumsum(cer.PRCP),
         dwd_prcp = cumsum(dwd.R1))


ggplot(df7_2006, aes(x=month, y = cer_prcp))+
  geom_line(df7_2006, mapping=aes(x= month, y = cer_prcp, color = "green"))+
  geom_line(df7_2006, mapping=aes(x= month, y = dwd_prcp, color = "red"))

#Tageswerte
d7_2006 = d7 %>%
  drop_na(dwd.R1)%>%
  mutate(year = year(MESS_DATUM),
         month = month(MESS_DATUM),
         day = day(MESS_DATUM))%>%
  filter(year == 2006)%>%
  mutate(cer_prcp = cumsum(cer.PRCP),
         dwd_prcp = cumsum(dwd.R1))

ggplot() +
  geom_line(d7_2006, mapping=aes(x= month, y = cer_prcp, color = "green"))+
  geom_line(d7_2006, mapping=aes(x= month, y = dwd_prcp, color = "red"))
