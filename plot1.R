dat <- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE)

dat_start <- min(which(dat[,1] == "1/2/2007"))
dat_end <- max(which(dat[,1] == "2/2/2007"))

dat_sub <- dat[dat_start:dat_end,]

date <- dmy(dat_sub[,1])
dat_sub[,1] <- date

rm(dat)

dat <- dat_sub


#turning column into numeric
dat[,3] <- sapply(dat$Global_active_power, as.numeric)
hist(dat$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

