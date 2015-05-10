# File:   plot1.R
# Date:   2015-05-10
# Author: Rick Wargo
#
# Description
#   Generate a series for four plots in specified formats displaying household power consumption
#   for 2007-Feb-01 & 02.
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

# Convert and combine date and time columns from factors to actual data type
hpc.feb07 = transform(hpc.feb07, Date = strptime(paste(Date, Time), '%d/%m/%Y %H:%M:%S'))

# Remove Time column now that it is rolled into date column
hpc.feb07$Time <- NULL

# Redirect plot to 480x480 PNG file with transparent background
png(file='plot4.png', bg='transparent', width=480, height=480)

# 4 plots arranged in 2 rows by 2 columns
par(mfrow=c(2, 2))

# Plot #1: Minute-by-minute Global Active Power
plot(hpc.feb07$Date, hpc.feb07$Global_active_power, type = 'n', xlab='', ylab='Global Active Power')
lines(hpc.feb07$Date, hpc.feb07$Global_active_power)

# Plot #2 Minute-by-minute Voltage
plot(hpc.feb07$Date, hpc.feb07$Voltage, type = 'n', xlab='datetime', ylab='Voltage')
lines(hpc.feb07$Date, hpc.feb07$Voltage)

# Plot #3 Minute-by-minute Energy sub metering
plot(hpc.feb07$Date, hpc.feb07$Sub_metering_1, ylim=range(c(hpc.feb07$Sub_metering_1, hpc.feb07$Sub_metering_2, hpc.feb07$Sub_metering_3)), type = 'n', xlab='', ylab='Energy sub metering')

# and plot the data as lines()
lines(hpc.feb07$Date, hpc.feb07$Sub_metering_1, ylim=range(c(hpc.feb07$Sub_metering_1, hpc.feb07$Sub_metering_2, hpc.feb07$Sub_metering_3)), col='black')
lines(hpc.feb07$Date, hpc.feb07$Sub_metering_2, ylim=range(c(hpc.feb07$Sub_metering_1, hpc.feb07$Sub_metering_2, hpc.feb07$Sub_metering_3)), col='red')
lines(hpc.feb07$Date, hpc.feb07$Sub_metering_3, ylim=range(c(hpc.feb07$Sub_metering_1, hpc.feb07$Sub_metering_2, hpc.feb07$Sub_metering_3)), col='blue')

# Generate the legend in the top/right corner
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty=1, box.lwd=0, col = c('black', 'red', 'blue'))

# Plot #4 Minute-by-minute Global Reactive Power
plot(hpc.feb07$Date, hpc.feb07$Global_reactive_power, type = 'n', xlab='datetime', ylab='Global_reactive_power')
lines(hpc.feb07$Date, hpc.feb07$Global_reactive_power)

# Close&save the PNG file
dev.off()