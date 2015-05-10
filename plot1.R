# File:   plot1.R
# Date:   2015-05-10
# Author: Rick Wargo
#
# Description
#   Generate a histogram in a specified format displaying the Global Active Power for 2007-Feb-01 & 02.
#
# Modification History
# RCW  2015-05-10  New today


setwd('~/Coursera/Exploratory Data Analysis/ProgrammingAssignment1/ExData_Plotting1')

# Assume household_power_consumption.txt is available in the directory above the current working directory; semi-colon separated
hpc.feb07 <- read.table(pipe(description='egrep ^Date\\|^[12]\\/2\\/2007 ../household_power_consumption.txt', open="r"), header=T, sep=';')

# Convert date and time columns from factors to actual data types
#hpc.feb07 = transform(hpc.feb07, Date = as.Date(Date, '%m/%d/%Y'))
#hpc.feb07 = transform(hpc.feb07, Time = strptime(Time, '%H:%M:%S'))

# Reduce the font size 50% to match the image
old.par.settings <- par(cex=0.75)

hist(hpc.feb07$Global_active_power, main='Global Active Power', xlab='Global Active Power (kilowatts)', ylab='Frequency', col='red')

par(old.par.settings)

# Copy histogram to plot1.png in 480x480 PNG format
dev.copy(png, 'plot1.png', width=480, height=480)
dev.off()