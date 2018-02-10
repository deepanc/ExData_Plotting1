
required_rows <- read.table("household_power_consumption.txt",na.strings = "?",sep=";",skip = grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"))-1,nrow = grep("3/2/2007",readLines("household_power_consumption.txt"))[1] - grep("1/2/2007",readLines("household_power_consumption.txt"))[1] )
colNames <- names(read.table("household_power_consumption.txt", nrow=1, header=TRUE, sep=";"))
names(required_rows) <- colNames

library(lubridate)
required_rows$Date <- dmy(required_rows$Date)

par(mfrow = c(1,1))

with(required_rows,hist(Global_active_power,main="Global Active Power",xlab="Global Active Power(kilowatts)",col="red"))

dev.copy(png,file="plot1.png")
dev.off()