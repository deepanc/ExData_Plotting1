# Assumes that the file is downloaded and available in the current working directory

library(lubridate)

required_rows <- read.table("household_power_consumption.txt",na.strings = "?",sep=";",skip = grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"))-1,nrow = grep("3/2/2007",readLines("household_power_consumption.txt"))[1] - grep("1/2/2007",readLines("household_power_consumption.txt"))[1] )
colNames <- names(read.table("household_power_consumption.txt", nrow=1, header=TRUE, sep=";"))
names(required_rows) <- colNames

dates <- as.character(required_rows$Date)
times <- as.character(required_rows$Time)
combined_datetime <- paste(dates,times)
required_rows <- required_rows %>% mutate(datetime = combined_datetime)
required_rows$datetime <- dmy_hms(required_rows$datetime)

par(mfrow=c(2,2))

with(required_rows,plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power"))

with(required_rows,plot(datetime,Voltage,type="l",ylab="Voltage"))

with(required_rows,plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",ylim = c(0, max(Sub_metering_1, Sub_metering_2, Sub_metering_3))))
with(required_rows,lines(datetime,Sub_metering_2,type="l",col="red"))
with(required_rows,lines(datetime,Sub_metering_3,type="l",col="blue"))
legend("topright",cex=0.5, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=1, col=c("black", "red", "blue"))

with(required_rows,plot(datetime,Global_reactive_power,type="l"))

dev.copy(png,file="plot4.png")
dev.off()
