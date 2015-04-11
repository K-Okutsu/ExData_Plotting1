## Plot4 ##
# How to execute.
#  - Save plot4.R & household_power_consumption.txt in working directory
#  - source("plot4.R")  execution @ R  

## Following is required for my Non English OS computer.
## If Datetime function seems strange at your computer, please comment out.
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

## make three data subset & combine
gap <- as.numeric(febpowerc$Global_active_power)
grp <- as.numeric(febpowerc$Global_reactive_power)
Voltage <- as.numeric(febpowerc$Voltage)
grpmx <- cbind(t,gap,grp,Voltage)
DF4 <- data.frame(grpmx)

## prepare Sub_metering Plot data 
sm1 <- as.numeric(febpowerc$Sub_metering_1)
sm2 <- as.numeric(febpowerc$Sub_metering_2)
sm3 <- as.numeric(febpowerc$Sub_metering_3)
sm1mx <- cbind(t,sm1,rep("sm1",length=tlength))
sm2mx <- cbind(t,sm2,rep("sm2",length=tlength))
sm3mx <- cbind(t,sm3,rep("sm3",length=tlength))
smamx <- rbind(sm1mx,sm2mx,sm3mx)
colnames(smamx) <- c("t","energy","smx")

DF3 <- data.frame(smamx)
DF3$t <- as.numeric(as.character(DF3$t))
DF3$energy <- as.numeric(as.character(DF3$energy))
DF3$smx <- as.character(DF3$smx)

## Make x axis with Week Day 
xdate <- as.Date(c("1/2/2007","2/2/2007","3/2/2007"),"%d/%m/%Y")
xwkday <- format(xdate,"%a")

## Multiple Scatterplots
par(mfcol = c(2,2))

## plot  Global_active_power
with(DF4, plot(t, gap,  type = "l", xlab = " "
               ,ylab = "Global Active Power", xaxt="n"))
axis(side = 1, labels = xwkday, at = c(1, 1441, 2881), tick=TRUE)

## Sub_metering Plot
with(DF3, plot(t, energy,  type = "n", xlab = " ",ylab = "Energy sub metering", xaxt="n"))
with(subset(DF3,smx == "sm1"),points(t, energy,type = "l"))
with(subset(DF3,smx == "sm2"),points(t, energy,type = "l", col = "red"))
with(subset(DF3,smx == "sm3"),points(t, energy,type = "l", col = "blue"))
legend(list(x=800,y=40), lty= 1, col = c("black","blue", "red")
       ,legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")
       ,bty="n",cex=0.7)
axis(side = 1, labels = xwkday, at = c(1, 1441, 2881), tick=TRUE)

## plot  Voltage
with(DF4, plot(t, Voltage,  type = "l", xlab = "datetime", xaxt="n"))
axis(side = 1, labels = xwkday, at = c(1, 1441, 2881), tick=TRUE)


## plot  Global_reactive_power
with(DF4, plot(t, grp,  type = "l", xlab = "datetime"
               ,ylab = "Global_reactive_power", xaxt="n", yaxt="n"))
axis(side = 1, labels = xwkday, at = c(1, 1441, 2881), tick=TRUE)
axis(side = 2, labels = c("0.0","0.1","0.2","0.3","0.4","0.5")
     ,at = c(0,0.1, 0.2, 0.3, 0.4, 0.5), cex.axis = 0.8, tick=TRUE)

## copy it to PNG file 
dev.copy(png, file = "plot4.png",width=480, height = 480, units = "px")
dev.off() ## Don't forget to close the PNG device!
