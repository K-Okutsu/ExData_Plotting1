## Plot3 ##
# How to execute.
#  - Save plot3.R & household_power_consumption.txt in working directory
#  - source("plot3.R")  execution @ R  

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

## make three data subset & combine
sm1 <- as.numeric(febpowerc$Sub_metering_1)
sm2 <- as.numeric(febpowerc$Sub_metering_2)
sm3 <- as.numeric(febpowerc$Sub_metering_3)
sm1mx <- cbind(t,sm1,rep("sm1",length=tlength))
sm2mx <- cbind(t,sm2,rep("sm2",length=tlength))
sm3mx <- cbind(t,sm3,rep("sm3",length=tlength))
smamx <- rbind(sm1mx,sm2mx,sm3mx)
colnames(smamx) <- c("t","energy","smx")

## make Data Frame & data type conversion 
DF3 <- data.frame(smamx)
DF3$t <- as.numeric(as.character(DF3$t))
DF3$energy <- as.numeric(as.character(DF3$energy))
DF3$smx <- as.character(DF3$smx)

## plot
with(DF3, plot(t, energy,  type = "n", xlab = " ",ylab = "Energy sub metering", xaxt="n"))
with(subset(DF3,smx == "sm1"),points(t, energy,type = "l"))
with(subset(DF3,smx == "sm2"),points(t, energy,type = "l", col = "red"))
with(subset(DF3,smx == "sm3"),points(t, energy,type = "l", col = "blue"))
legend("topright", lty= 1, col = c("black","blue", "red")
    ,legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

## Make x axis and plot it 
xdate <- as.Date(c("1/2/2007","2/2/2007","3/2/2007"),"%d/%m/%Y")
xwkday <- format(xdate,"%a")
axis(side = 1, labels = xwkday, at = c(1, 1441, 2881), tick=TRUE)

## copy it to PNG file 
dev.copy(png, file = "plot3.png",width=480, height = 480, units = "px")
dev.off() ## Don't forget to close the PNG device!
