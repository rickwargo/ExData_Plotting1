# File:   plot1.R
# Date:   2015-05-10
# Author: Rick Wargo
#
# Description
#   Generate 3 overlaid lines plots in a specified format displaying minute-by-minute energy sub metering for 2007-Feb-01 & 02.
#
#   Household Power Consumption dataset (20MB) available from the following URL:
#   https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# Modification History
# RCW  2015-05-10  New today


setwd('~/Coursera/Exploratory Data Analysis/ProgrammingAssignment1/ExData_Plotting1')

# Assume household_power_consumption.txt is available in the current working directory; semi-colon separated
# Extract subset of data used for displaying the plot: Feb 1, 2007 - Feb 2, 2007
hpc.feb07 <- read.table(pipe(description='egrep ^Date\\|^[12]\\/2\\/2007 household_power_consumption.txt', open="r"), header=T, sep=';')

# Convert and combine date and time columns from factors to actual data type
hpc.feb07 = transform(hpc.feb07, Date = strptime(paste(Date, Time), '%d/%m/%Y %H:%M:%S'))

# Remove Time column now that it is rolled into date column
hpc.feb07$Time <- NULL

# Redirect plot to 480x480 PNG file with transparent background
png(file='plot3.png', bg='transparent', width=480, height=480)

# Create a formatted chart without data - ensure y limits are the same for all plots
plot(hpc.feb07$Date, hpc.feb07$Sub_metering_1, ylim=range(c(hpc.feb07$Sub_metering_1, hpc.feb07$Sub_metering_2, hpc.feb07$Sub_metering_3)), type = 'n', xlab='', ylab='Energy sub metering')

# And plot the data as lines()
lines(hpc.feb07$Date, hpc.feb07$Sub_metering_1, ylim=range(c(hpc.feb07$Sub_metering_1, hpc.feb07$Sub_metering_2, hpc.feb07$Sub_metering_3)), col='black')
lines(hpc.feb07$Date, hpc.feb07$Sub_metering_2, ylim=range(c(hpc.feb07$Sub_metering_1, hpc.feb07$Sub_metering_2, hpc.feb07$Sub_metering_3)), col='red')
lines(hpc.feb07$Date, hpc.feb07$Sub_metering_3, ylim=range(c(hpc.feb07$Sub_metering_1, hpc.feb07$Sub_metering_2, hpc.feb07$Sub_metering_3)), col='blue')

# Generate the legend in the top/right corner
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty=1, col = c('black', 'red', 'blue'))

# Close&save the PNG file
dev.off()