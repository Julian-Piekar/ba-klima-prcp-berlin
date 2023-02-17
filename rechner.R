# Erstellt Tabelle mit allen Kenngrößen für alle Stationen

source("rech_fun.R")
require(dplyr)

rechner1 <- rech_fun("./cer-daten/df1.csv")
rechner2 <- rech_fun("./cer-daten/df2.csv")
rechner3 <- rech_fun("./cer-daten/df3.csv")
rechner4 <- rech_fun("./cer-daten/df4.csv")
rechner5 <- rech_fun("./cer-daten/df5.csv")
rechner6 <- rech_fun("./cer-daten/df6.csv")
rechner7 <- rech_fun("./cer-daten/df7.csv")
rechner8 <- rech_fun("./cer-daten/df8.csv")

Tabelle = bind_rows(rechner1,rechner2,rechner3,rechner4,rechner5,rechner6,rechner7,rechner8)
row.names(Tabelle) = c("Alexanderplatz", "Buch", "Dahlem", "Kaniswall", "Marzahn", "BER", "Tegel", "Tempelhof")

write.csv(Tabelle, "Tabelle.csv", row.names = T, quote = F)

Tabelle = read.csv("Tabelle.csv")
