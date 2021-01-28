
#import data
power <- data.table::fread("household_power_consumption.txt")

# filter, convert, and only look at specified dates
feb07power <- power %>%
        #select(Global_active_power , Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3) %>%
        mutate( DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"),
                Global_active_power = as.numeric(power$Global_active_power),
                Sub_metering_1 = as.numeric(Sub_metering_1),
                Sub_metering_2 = as.numeric(Sub_metering_2),
                Sub_metering_3 = as.numeric(Sub_metering_3),
                Voltage = as.numeric(Voltage),
                Global_reactive_power = as.numeric(Global_reactive_power)
        )

febpower <- feb07power[(DateTime>="2007-02-01") & (DateTime<="2007-02-03")]

#set png
png("plot4.png", width = 480, height = 480)

#set par
par(mfrow=c(2,2))

#plots

#1
plot(febpower[,DateTime], febpower[, Global_active_power], type = "l", xlab = "", ylab = "Global Active Power")

#2
plot(febpower[,DateTime], febpower[, Voltage], type="l", xlab="datetime", ylab="Voltage")

#3
plot(febpower[, DateTime], febpower[, Sub_metering_1], type = "l", xlab = "", ylab = "Energy sub metering")
lines(febpower[,DateTime], febpower[, Sub_metering_2], col="red")
lines(febpower[,DateTime], febpower[, Sub_metering_3], col="blue")
legend("topright"
       , col = c("black", "red", "blue")
       , c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       ,lty = c(1,1)
       ,bty = 'n'
       , cex = .5)
#4
plot(febpower[,DateTime], febpower[, Global_reactive_power], type = "l", xlab = "datetime", ylab = "Global_reactive_power")


dev.off()
