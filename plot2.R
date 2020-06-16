## The first chunk of code is the same as the beginning of plot1.R.
# Copied here because it defines df1 (table with selected dates)
library(dplyr)
library(lubridate)
table<-read.table("./household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
table$DateTime <- paste(table$Date,table$Time)
table$DateTime <- dmy_hms(table$DateTime)
table$Date <- dmy(table$Date)
df1<-filter(table,Date=="2007-02-01"|Date=="2007-02-02")

# Make a new column that shows the day of the week
df1$Wday<-wday(df1$DateTime,label = TRUE)

# Make a new table df2 that only contains Thu-Sat data
df2 <- subset(df1,Wday==c("Thu","Fri","Sat"))

# Make a plot and save as plot2
plot2<-with(df2,plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
dev.copy(png,file="plot2.png",width=480,height=480,units="px")
dev.off()