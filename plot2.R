## Plot2 ##
# How to execute.
#  - Save plot2.R & household_power_consumption.txt in working directory
#  - source("plot2.R")  execution @ R  

## Following is required for my Non English OS computer.
Sys.setlocale("LC_TIME","C")

## Read all data 
powerc <- read.table("./household_power_consumption.txt", sep = ";"
                     ,header = TRUE, stringsAsFactors = FALSE)

## Make two day subset 
powerc$Date <- as.Date(powerc$Date,"%d/%m/%Y")            
chkdate <- as.Date(c("1/2/2007","2/2/2007"),"%d/%m/%Y")
febpowerc <- powerc[powerc$Date %in% chkdate,]             

## Prepare plot data 
tlength <- nrow(febpowerc)
t <- 1:tlength

gap <- as.numeric(febpowerc$Global_active_power)
gapmx <- cbind(t,gap)
DF2 <- data.frame(gapmx)

## Make x axis with Week Day 
xdate <- as.Date(c("1/2/2007","2/2/2007","3/2/2007"),"%d/%m/%Y")
xwkday <- format(xdate,"%a")

## plot  Global_active_power
with(DF2, plot(t, gap,  type = "l", xlab = " "
               ,ylab = "Global Active Power", xaxt="n"))
axis(side = 1, labels = xwkday, at = c(1, 1441, 2881), tick=TRUE)

## copy it to PNG file 
dev.copy(png, file = "plot2.png",width=480, height = 480, units = "px")
dev.off() ## Don't forget to close the PNG device!
