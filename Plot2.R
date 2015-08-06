require(dplyr)
#Read File
epc_orig<-read.table(file="../data/household_power_consumption.txt",
                     sep=";",
                     header=TRUE,
                     na.strings="?",
                     colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

#concatenate date and time fields
epc_orig<-mutate(epc_orig,datetime= paste(Date,Time,sep=" "))

#create a datetime field as Posixlt
epc_orig<-transform(epc_orig, 
                    datetime=as.POSIXct(strptime(datetime,format="%d/%m/%Y %H:%M:%S")),
                    Date=as.Date(Date,"%d/%m/%Y") )
#tbl_df(epc_orig)
#View(epc_orig)
epc<-select(epc_orig,-(Time))

#filter data
epc<-filter(epc,Date >= as.Date("2007-02-01","%Y-%m-%d") & Date <= as.Date("2007-02-02","%Y-%m-%d"))

#open graphics device of type png
png(file="Plot2.png",width = 480, height = 480, units = "px")

with(epc,plot(datetime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))

dev.off()