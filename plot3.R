# Open package tidyr
library(tidyr)
library(dplyr)
library(lubridate)

## From plot1+2 that defines df1 and df2
table<-read.table("./household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
table$DateTime <- paste(table$Date,table$Time)
table$DateTime <- dmy_hms(table$DateTime)
table$Date <- dmy(table$Date)
df1<-filter(table,Date=="2007-02-01"|Date=="2007-02-02")
df1$Wday<-wday(df1$DateTime,label = TRUE)
df2 <- subset(df1,Wday==c("Thu","Fri","Sat"))

# Make a new table that turns Sub_metering_n into values under the variable name 'Energy sub metering'.
df3 <- df2 %>% gather('Sub_metering_1','Sub_metering_2','Sub_metering_3',key="Energy sub metering",value="Reading")

#Define 3 groups
m1<- subset(df3,df3$`Energy sub metering`== "Sub_metering_1")
m2<- subset(df3,df3$`Energy sub metering`== "Sub_metering_2")
m3<- subset(df3,df3$`Energy sub metering` == "Sub_metering_3")

plot(df3$DateTime,df3$Reading,type="n",xlab="",ylab="Energy sub metering",cex.lab=0.7,cex.axis=0.7)
lines(m1$DateTime,m1$Reading,col="black")
lines(m2$DateTime,m2$Reading,col="red")
lines(m3$DateTime,m3$Reading,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),cex=0.7)

#Save plot
dev.copy(png,file="plot3.png",width=480,height=480,units="px")
dev.off()