##  INIT  ##


rm(list=ls())
library('stringr')


##  FUNCTIONS  ##


SplitNumber <- function(data, column, year) {
  data <- sapply(data, str_replace, " ", "")
  tmp <- gsub("\\.", "", data[, column])       
  tmp <- (sapply(tmp, str_split, ""))
  
  tmpDF <- data.frame(t(sapply(tmp,c)))
  tmpDF <- tmpDF[, 2:13]
  
  names(tmpDF) <- c("haushaltshinweis", "fun1", "fun2", "fun3", "fun4", "fun5", "eco1", "eco2", "eco3", "eco4", "eco5", "eco6")
  
  for(i in seq_along(dim(tmpDF)[1])) {
    funAgg3 <- paste0(tmpDF[, 2], tmpDF[, 3], tmpDF[, 4])
    ecoAgg3 <- paste0(tmpDF[, 7], tmpDF[, 8], tmpDF[, 9])
    funAgg5 <- paste0(tmpDF[, 2], tmpDF[, 3], tmpDF[, 4], tmpDF[, 5], tmpDF[, 6])
    ecoAgg6 <- paste0(tmpDF[, 7], tmpDF[, 8], tmpDF[, 9], tmpDF[, 10], tmpDF[, 11], tmpDF[, 12])
  }
  
  year <- as.numeric(rep(as.numeric(year), dim(data)[1]))
  serial <- 1:dim(data)[1]
  data <- cbind(serial, data, tmpDF, funAgg3, ecoAgg3, funAgg5, ecoAgg6, as.numeric(year))
  data
}


##  2011  ##


data2011 <- read.csv2("./data/raw/Rechnungsabschluss2011Clean.csv", header=FALSE, quote="\'", 
                      stringsAsFactors=FALSE, strip.white=TRUE, fileEncoding="iso-8859-1")
names(data2011) <- c("Finanzposition", "Bezeichnung", "EinAus", "Teilabschnitt", "RQ", "FG", "SN", 
                     "AOB", "AnfZahlungsrueckstand", "LaufendesSoll", "GesamtSoll", "Ist", "SchliesslicheRueckstaende", 
                     "Voranschlag", "NachtragsVoranschlage", "GesamtVoranschlag", "UnterschiedLFDSollGesamtVAGuenstiger", 
                     "UnterschiedLFDSollGesamtVAUnguenstiger")

test <- sapply(data2011$AnfZahlungsrueckstand, str_replace, "\ ", "")
tmp1 <- SplitNumber(data2011, "Finanzposition", 2011)


##  2010  ##


data2010 <- read.csv2("./data/raw/Rechnungsabschluss2010Clean.csv", header=FALSE, quote="\'", 
                      stringsAsFactors=FALSE, strip.white=TRUE, fileEncoding="iso-8859-1")
names(data2010) <- c("Finanzposition", "Bezeichnung", "EinAus", "Teilabschnitt", "RQ", "FG", "SN", 
                     "AOB", "AnfZahlungsrueckstand", "LaufendesSoll", "GesamtSoll", "Ist", "SchliesslicheRueckstaende", 
                     "Voranschlag", "NachtragsVoranschlage", "GesamtVoranschlag", "UnterschiedLFDSollGesamtVAGuenstiger", 
                     "UnterschiedLFDSollGesamtVAUnguenstiger")

tmp2 <- SplitNumber(data2010, "Finanzposition", 2010)


##  2009  ##


data2009 <- read.csv2("./data/raw/Rechnungsabschluss2009Clean.csv", header=FALSE, quote="\'", 
                      stringsAsFactors=FALSE, strip.white=TRUE, fileEncoding="iso-8859-1")
names(data2009) <- c("Finanzposition", "Bezeichnung", "EinAus", "Teilabschnitt", "RQ", "FG", "SN", "AOB", 
                     "AnfZahlungsrueckstand", "LaufendesSoll", "GesamtSoll", "Ist", "SchliesslicheRueckstaende", 
                     "Voranschlag", "NachtragsVoranschlage", "GesamtVoranschlag", "UnterschiedLFDSollGesamtVAGuenstiger", 
                     "UnterschiedLFDSollGesamtVAUnguenstiger")

tmp3 <- SplitNumber(data2009, "Finanzposition", 2009)

data <- as.data.frame(rbind(tmp1, tmp2, tmp3))

##  WRITE  ##


write.csv2(data, file="./data/csv/Rechnungsabschluss2009-2011PP2.csv", row.names=FALSE, fileEncoding="UTF-8")
save(list=ls(), file="./data/rstat/Rechnungsabschluss2009-2011PP2.rda")






