loadLingLocationData <- function(path = "data/") {
  read.delim("data/lingLocation.txt", sep = " ")
}

loadLingData <- function(path = "data/") {
  read.delim("data/lingData.txt", sep = " ")
}


loadRedwoodData <- function(path = "data/", source = c("all")) {
  # load in the csv file
  sonoma <- read.csv(paste0(path, "sonoma-data-", source, ".csv"))
  return(sonoma)
}


loadMoteLocationData <- function(path = "data/") {
  MoteLocation <- read.table(paste0(path, "mote-location-data.txt"), header = TRUE )
}



