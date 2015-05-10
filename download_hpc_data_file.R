# File:   download_data_file.R
# Date:   2015-05-10
# Author: Rick Wargo
#
# Description
#   Download the Household Power Consumption dataset and store in the data directory, if the file does not exist
#
#   Household Power Consumption dataset (20MB) available from the following URL:
#   https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# Modification History
# RCW  2015-05-10  New today

# Standard dataset naming
file.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
dest.file.zip <- 'household_power_consumption.zip'
data.dir <- 'data'
hpc.data.file <- paste(data.dir, 'household_power_consumption.txt', sep='/')

# Create data directory if it does not already exist
if (!file.exists(data.dir)) {
  dir.create(data.dir)
}

# Download and extract the data file in the data directory if it does not already exist
if (!file.exists(hpc.data.file)) {
  setwd(data.dir)
  
  tryCatch(
    {
      download.file(file.url, dest.file.zip, method='curl', quiet=TRUE)
      unzip(dest.file.zip)
      unlink(dest.file.zip)
      cat('|', format(Sys.time(), '%x %X'), '|', hpc.data.file, '|\n', file="download_log.md",append=TRUE)
    },
    error=function(e) {
      print("error occurred downloading data file")
      stop(e)
    },
    finally= {
      setwd('..')
    }
  )
}