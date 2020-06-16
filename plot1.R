# Open packages
library(dplyr)
library(lubridate)

# Unzip data and read table
unzip("./exdata_data_household_power_consumption.zip")
table<-read.table("./household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

# Merge Date and Time variables to form a new column called DateTime.
# Lubridate package converts Datetime strings into dates 
table$DateTime <- paste(table$Date,table$Time)
table$DateTime <- dmy_hms(table$DateTime)

# Make a new table df1 with only the selected dates
table$Date <- dmy(table$Date)
df1<-filter(table,Date=="2007-02-01"|Date=="2007-02-02")

# Plotted the required histogram and coped into a png file.
hist(df1$Global_active_power,col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")
dev.copy(png,file="plot1.png",width=480,height=480,units="px")
dev.off()

