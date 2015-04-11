## Plot1 ##
# How to execute.
#  - Save plot1.R & household_power_consumption.txt in working directory
#  - source("plot1.R")  execution @ R  

## Read all data 
powerc <- read.table("./household_power_consumption.txt", sep = ";"
                     ,header = TRUE, stringsAsFactors = FALSE)

## Make two day subset 
powerc$Date <- as.Date(powerc$Date,"%d/%m/%Y")            
chkdate <- as.Date(c("1/2/2007","2/2/2007"),"%d/%m/%Y")
febpowerc <- powerc[powerc$Date %in% chkdate,]  

## Prepare plot data 
febpowerc$Global_active_power <- as.numeric(febpowerc$Global_active_power)

## Draw plot1
hist(febpowerc$Global_active_power, col = "red"
     , main = "Global Active Power", xlab = "Global Active Power(kilowatts)")

## copy it to PNG file 
dev.copy(png, file = "plot1.png",width=480, height = 480, units = "px")
dev.off() ## Don't forget to close the PNG device!

