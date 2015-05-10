# File:   plot1.R
# Date:   2015-05-10
# Author: Rick Wargo
#
# Description
#   Generate a histogram in a specified format displaying the Global Active Power for 2007-Feb-01 & 02.
#
#   Household Power Consumption dataset (20MB) available from the following URL:
#   https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# Modification History
# RCW  2015-05-10  New today

# Ensure the Household Power Consumption dataset is available in the data directory
source('download_hpc_data_file.R')

# Extract subset of data used for displaying the plot: Feb 1, 2007 - Feb 2, 2007
hpc_subset <- pipe(description=paste('egrep', '^Date\\|^[12]\\/2\\/2007', hpc.data.file), open="r")
hpc.feb07 <- read.table(hpc_subset, header=T, sep=';')
close(hpc_subset)

# Redirect plot to 480x480 PNG file with transparent background
png(file='plot1.png', bg='transparent', width=480, height=480)

# Create the historgram on the screen
hist(hpc.feb07$Global_active_power, main='Global Active Power', xlab='Global Active Power (kilowatts)', ylab='Frequency', col='red')

# Close&save the PNG file
dev.off()