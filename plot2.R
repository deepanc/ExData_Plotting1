
required_rows <- read.table("household_power_consumption.txt",na.strings = "?",sep=";",skip = grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"))-1,nrow = grep("3/2/2007",readLines("household_power_consumption.txt"))[1] - grep("1/2/2007",readLines("household_power_consumption.txt"))[1] )
colNames <- names(read.table("household_power_consumption.txt", nrow=1, header=TRUE, sep=";"))
names(required_rows) <- colNames

library(lubridate)
plot2_rows <- required_rows %>% select(Date,Time,Global_active_power)
plot2_rows <- plot2_rows %>% mutate(datetime = paste(Date,Time))
dates <- as.character(plot2_rows$Date)
times <- as.character(plot2_rows$Time)
combined_datetime <- paste(dates,times)
plot2_rows$datetime <- dmy_hms(combined_datetime)
with(plot2_rows,plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)"))

dev.copy(png,file="plot2.png")
dev.off()
