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

plot(dat$correct, dat$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")


