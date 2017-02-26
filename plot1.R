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
# plot1 #
#########

names(el)
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(el$Global_active_power,xlab="Global Active Power (kilowatts)", ylab="Frequency", 
     col="red", main="Global Active Power (freq)")
dev.off()
