# Open packages
library(tidyr)
library(dplyr)
library(lubridate)

# This code chunk is the same as plot1.R. Copied here because it defines df1.
table<-read.table("./household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
table$DateTime <- paste(table$Date,table$Time)
table$DateTime <- dmy_hms(table$DateTime)
table1<-table
table1$Date <- dmy(table1$Date)
df1<-filter(table1,Date=="2007-02-01"|Date=="2007-02-02")

# Start of the new codes. Sets up the layout of the graphs.
par(mfrow=c(2,2),mar=c(3,3,2,1),mgp=c(1.5,0.5,0),tcl=-0.2, cex =0.6)

# Topleft graph (same code as plot2)
df1$Wday<-wday(df1$DateTime,label = TRUE)
df2 <- subset(df1,Wday==c("Thu","Fri","Sat"))
with(df2,plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power"))

# Topright graph
with(df2,plot(DateTime,Voltage,type="l",xlab = "datetime",ylab="Voltage"))

## Bottomleft graph (same as plot3)
df3 <- df2 %>% gather('Sub_metering_1','Sub_metering_2','Sub_metering_3',key="Energy sub metering",value="Reading")

m1<- subset(df3,df3$`Energy sub metering`== "Sub_metering_1")
m2<- subset(df3,df3$`Energy sub metering`== "Sub_metering_2")
m3<- subset(df3,df3$`Energy sub metering` == "Sub_metering_3")

plot(df3$DateTime,df3$Reading,type="n",xlab="",ylab="Energy sub metering")
lines(m1$DateTime,m1$Reading,col="black")
lines(m2$DateTime,m2$Reading,col="red")
lines(m3$DateTime,m3$Reading,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),cex=0.5,bty="n")

# Bottomright graph
plot(df2$DateTime,df2$Global_reactive_power, type="l",xlab="datetime",ylab="Global_reactive_power")

# Save as png
dev.copy(png,file="plot4.png",width=480,height=480,units="px")
dev.off()