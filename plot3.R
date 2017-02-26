# This script fulfills the requirements of peer-graded assignment for
# "Exploratory Data Analysis" course, Week 1


#########################
# set up of environment #
#########################
setwd("/Users/nikolaydobrinov/Documents/work/Courses/R/WorkDirectory/Course4_week1_coding_assignment")
library(dplyr)

###########################################
# load data, subset, format Date and Time #
###########################################

# Load and subset the data by Date="1/2/2007" | Date=="2/2/2007"
electric <- read.table("./Data/household_power_consumption.txt", header=TRUE, sep =";", na.strings = "?")
el <- filter(electric,Date=="1/2/2007" | Date=="2/2/2007")

# format date and time variables
el$DateTime <- paste(el$Date, el$Time) # creates a new column with Date and time as one variable
# to be used properly with the strptime() function

el$Date <- as.Date(el$Date, format="%d/%m/%Y") # formats the date
class(el$Date)
unique(el$Date)

el$DateTime <- strptime(el$DateTime, format="%d/%m/%Y %H:%M:%S") # formats the time
class(el$DateTime)

#########
# plot3 #
#########

png(filename = "plot3.png", width = 480, height = 480, units = "px")
# open an empty plot; set the limits for each axis, titles of axis, title of plot
# remove the axis lables for the x-axis as these are in POSIXct format (xaxt="n")
# Note that xlim will not accept data ranges for the x-axis unless we use as.POSIXct
plot(1, type = 'n', xlim = c(as.POSIXct(min(el$DateTime)), as.POSIXct(max(el$DateTime))), 
     ylim = c(0, max(c(max(el$Sub_metering_1),max(el$Sub_metering_2),max(el$Sub_metering_3)))), 
     main = "Energy sub metering", xlab="Time", ylab = "Energy sub metering",xaxt="n")

lines(el$DateTime,el$Sub_metering_1,col="black",type="l")
lines(el$DateTime,el$Sub_metering_2,col="red",type="l")
lines(el$DateTime,el$Sub_metering_3,col="blue",type="l")
legend("topright", lty=1, col=c("blacK","blue","red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
axis.POSIXct(1,el$DateTim) # this labels the axes correctly 

dev.off()

