
#import data
power <- data.table::fread("household_power_consumption.txt")

# filter, convert, and only look at specified dates
feb07power <- power %>%
        select(Global_active_power, Date) %>%
        mutate( Date = as.Date(power$Date, "%d/%m/%Y"),
                Global_active_power = as.numeric(power$Global_active_power))

febpower <- feb07power[(Date>="2007-02-01") & (Date<="2007-02-02")]

#set png
png("plot1.png", width = 480, height = 480)

#plot hist
hist(febpower[, Global_active_power], main = "Global Active Power", 
     ylab="Frequency", xlab = "Global Active Power (kilowatts)", col = "Red")

dev.off()
