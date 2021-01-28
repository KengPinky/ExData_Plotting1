
#import data
power <- data.table::fread("household_power_consumption.txt")

# filter, convert, and only look at specified dates
feb07power <- power %>%
        select(Global_active_power, Date, Time) %>%
        mutate( DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"),
                Global_active_power = as.numeric(power$Global_active_power))

febpower <- feb07power[(DateTime>="2007-02-01") & (DateTime<="2007-02-03")]

#set png
png("plot2.png", width = 480, height = 480)

#plot 
plot(x = febpower[, DateTime]
     , y = febpower[, Global_active_power]
     , type = "l"
     , xlab = "" 
     , ylab = "Global Active Power (kilowatts)")

dev.off()
