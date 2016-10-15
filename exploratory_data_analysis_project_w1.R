library(dplyr)


# Import rows that contain the desired dates 02/02/2007 - 01/02/2007
path <- "/home/rogelio/Desktop/datasciencecoursera/exploratory_data_analysis_project_w1/household_power_consumption.txt"
A <- read.csv(path, nrows = 14400, skip = 57600, sep = ";")


# set column names that were lost while skipping rows
nam <- read.csv(path, nrows = 1, sep = ";")
names(A) <- names(nam)


# Subset A to get the exact desired dates
A <- subset(A, A$Date == "1/2/2007" | A$Date == "2/2/2007")


# plots 2-4 require a time variable that spans the two days
# here I create it (full_time)
full_time <- strptime(paste(A$Date, A$Time), "%e/%m/%Y %H:%M:%S")

# since variables like Global_active_power are factors we need
# to transform them into numeric
A <- mutate(A, Global_active_power = as.numeric(as.character(Global_active_power)))
A <- mutate(A, Sub_metering_1 = as.numeric(as.character(Sub_metering_1)))
A <- mutate(A, Sub_metering_2 = as.numeric(as.character(Sub_metering_2)))
A <- mutate(A, Sub_metering_3 = as.numeric(as.character(Sub_metering_3)))
A <- mutate(A, Voltage = as.numeric(as.character(Voltage)))
A <- mutate(A, Global_reactive_power = as.numeric(as.character(Global_reactive_power)))


########################## PLOTS ##########################

png(file = "/home/rogelio/Desktop/datasciencecoursera/exploratory_data_analysis_project_w1/code/plot1.png")
hist(A$Global_active_power, breaks = 11, col = "red",
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()


png(file = "/home/rogelio/Desktop/datasciencecoursera/exploratory_data_analysis_project_w1/code/plot2.png")
with(A, plot(full_time, Global_active_power, type = "l",
             ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()


png(file = "/home/rogelio/Desktop/datasciencecoursera/exploratory_data_analysis_project_w1/code/plot3.png")
with(A, plot(full_time, Sub_metering_1, type = "l", col = "black",
             ylab = "Energy sub metering", xlab = ""))
with(A, lines(full_time, Sub_metering_2, col = "red"))
with(A, lines(full_time, Sub_metering_3, col = "blue"))
legend("topright", lty = c(1,1,1), col = c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

png(file = "/home/rogelio/Desktop/datasciencecoursera/exploratory_data_analysis_project_w1/code/plot4.png")
par(mfrow = c(2,2))

with(A, plot(full_time, Global_active_power, type = "l",
             ylab = "Global Active Power (kilowatts)", xlab = ""))

with(A, plot(full_time, Voltage, type = "l",
             ylab = "Voltage", xlab = "datetime"))

with(A, plot(full_time, Sub_metering_1, type = "l", col = "black",
             ylab = "Energy sub metering", xlab = ""))
with(A, lines(full_time, Sub_metering_2, col = "red"))
with(A, lines(full_time, Sub_metering_3, col = "blue"))
legend("topright", lty = c(1,1,1), col = c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(A, plot(full_time, Global_reactive_power, type = "l", xlab = "datetime"))
dev.off()