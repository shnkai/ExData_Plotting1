library(dplyr)
library(lubridate)
dat <- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE)

dat_start <- min(which(dat[,1] == "1/2/2007"))
dat_end <- max(which(dat[,1] == "2/2/2007"))

dat_sub <- dat[dat_start:dat_end,]

date <- dmy(dat_sub[,1])
dat_sub[,1] <- date

rm(dat)

dat <- dat_sub

dat <- mutate(dat, com = paste(dat$Date, dat$Time))

dat <- mutate(dat, correct = as.POSIXct(strptime(dat$com, format = "%Y-%m-%d %H:%M:%S")))

#turning column into numeric
dat[,3] <- sapply(dat$Global_active_power, as.numeric)

par(mfrow = c(2,2))
plot(dat$correct, dat$Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(dat$correct, dat$Voltage, type="l", xlab="datetime", ylab="Global Active Power")

plot(dat$correct, dat$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
points(dat$correct, dat$Sub_metering_1, type="l", col = "black")
points(dat$correct, dat$Sub_metering_2, type="l", col = "red")
points(dat$correct, dat$Sub_metering_3, type="l", col = "blue")

legend("topright", col = c("black", "red", "blue"), legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1)

plot(dat$correct, dat$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")



