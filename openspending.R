
##  INIT  ##
library('stringr')

# data <- read.csv2("./data/raw/test.csv", header=FALSE, stringsAsFactors=FALSE, quote="",
#                   colClasses=c("character", "character", "character", "character", "integer", "integer", "character", "character", "integer", "integer", "integer", "integer", "integer", "integer", "integer", "integer", "integer", "integer"))


##  OPEN  ##
data <- read.csv2("./data/raw/RechnungsabschlussPP1.csv", header=FALSE, quote="\'", stringsAsFactors=FALSE)
names(data) <- c("Finanzposition", "Bezeichnung", "EinAus", "Teilabschnitt", "RQ", "FG", "SN", "AOB", "AnfZahlungsrueckstand", "LaufendesSoll", "GesamtSoll", "Ist", "SchliesslicheRueckstaende", "Voranschlag", "NachtragsVoranschlage", "GesamtVoranschlag", "UnterschiedLFDSollGesamtVAGuenstiger", "UnterschiedLFDSollGesamtVAUnguenstiger")

##  PREPARE DATA  ##
tmp <- gsub("\\.", "", data[, 1])       
tmp <- (sapply(tmp, str_split, ""))
for(i in seq_along(1:length(tmp))) {
  for (j in seq_along(1:12)) {
    test[i, j] <- tmp[[i]][1+j]
  }
}

test2 <- test
names(test2) <- c("zahl", "pol1", "pol2", "pol3", "pol4", "pol5", "eco1", "eco2", "eco3", "eco4", "eco5", "eco6")

for(i in seq_along(dim(test2)[1])) {
  polAgg3 <- paste0(test2[, 2], test2[, 3], test2[, 4])
  ecoAgg3 <- paste0(test2[, 7], test2[, 8], test2[, 9])
  polAgg5 <- paste0(test2[, 2], test2[, 3], test2[, 4], test2[, 5], test2[, 6])
  ecoAgg6 <- paste0(test2[, 7], test2[, 8], test2[, 9], test2[, 10], test2[, 11], test2[, 12])
}

serial <- 1:dim(data)[1]
year <- rep("2011", dim(data)[1])
data <- cbind(serial, data, test2, polAgg3, ecoAgg3, polAgg5, ecoAgg6, year)
names(data)[1] <- "serial"

write.csv2(data, file="./data/RechnungsabschlussPP2.csv")
save(list=ls(), file="./data/rstat/RechnungsabschlussPP2.rda")


