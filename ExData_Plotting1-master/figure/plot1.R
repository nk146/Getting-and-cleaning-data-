require(data.table)
getwd()
setwd("C:/Users/nkamal2/Downloads/DS_training/exploratory_data_analysis_course/ExData_Plotting1-master/figure")

#loading the data
data <-read.table("household_power_consumption.txt",sep=';',header = TRUE,na.strings = '?')
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#subsetting dataframe for the dates 2007-02-01 and 2007-02-02
data <- subset(data,subset = (Date>="2007-02-01" & Date<="2007-02-02"))
data$datetime <- strptime(paste(data$Date,data$Time),"%Y-%m-%d %H:%M:%S")

##plotting 
hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",ylab="Frequency", col = "Red")

#saving plot
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
