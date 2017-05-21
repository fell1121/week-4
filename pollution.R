# week-4
https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
## 1
library(ggplot2)
NEI <- readRDS(choose.files())
bc <- aggregate(Emissions~ year, NEI, sum)
plot(bc$year,bc$Emissions,type="l",col="red",lwd=3,xlab="year",ylab="Emissions",main="Emission per year")

dev.copy(png,file="emission.png",width=480,height=480,units="px")
dev.off

## 2
NEI <- readRDS(choose.files())
b<-subset(NEI,fips =="24510")
bc <- aggregate(Emissions~ year, b, sum)
plot(bc$year,bc$Emissions,type="l",col="yellow",lwd=3,xlab="year",ylab="Emissions",main="Emission per year")

dev.copy(png,file="city.png",width=480,height=480,units="px")
dev.off

## 3
library(ggplot2)
NEI <- readRDS(choose.files())
b<-subset(NEI,fips =="24510")
bc <- aggregate(Emissions~ year+type, b, sum)

g<-ggplot(bc,aes(year,Emissions,col=type))
g+geom_line()+ggtitle("Emissions by type in BC")

dev.copy(png,file="ggcity.png",width=480,height=480,units="px")
dev.off


## 4
library(ggplot2)
NEI <- readRDS(choose.files())
SCC<- readRDS(choose.files())
head(scc)
names(scc)
NEI_SCC <- merge(NEI, SCC, by="SCC")

NEI_SCC <- merge(NEI, SCC, by="SCC")

head(NEI)
head(SCC)
bc <-NEI[NEI$fips=="24510",]

NEI_SCC <- merge(NEI, SCC, by="SCC")
coal <-grepl("coal",NEI_SCC$Short.Name,ignore.case=T)
caolx <- NEI_SCC[coal,]
bc <- aggregate(Emissions~ year, caolx, sum)

g <- ggplot(bc,aes(year,Emissions))
g + geom_bar(stat="identity", colour="red", fill='#56B4E9')+ggtitle("Total Emissions from coal sources from 1999 to 2008")

dev.copy(png,file="city3",width=480,height=480,units="px")
dev.off


## 5
library(ggplot2)
NEI <- readRDS(choose.files())
table(NEI$type)
b<-subset(NEI,fips =="24510"&type =="ON-ROAD")
head(b)
bc <- aggregate(Emissions~ year, b, sum)

g <- ggplot(bc, aes(year, Emissions))
g + geom_bar(stat="identity", colour="red", fill='#56B4E9')+ggtitle("Emissions by vehicle in BC")

dev.copy(png,file="ggcityvehi.png",width=480,height=480,units="px")
dev.off

## 6
NEI <- readRDS(choose.files())
table(NEI$type)
b<- NEI[(NEI$fips == "24510"|NEI$fips=="06037")&NEI$type=="ON-ROAD",]
table(b$fips)



bc <- aggregate(Emissions~ year+fips, b, sum)

g <- ggplot(bc, aes(year, Emissions))
g + geom_bar(stat="identity", colour="red", fill='#56B4E9')+ggtitle("Emissions by vehicle in two cities")+facet_grid(.~fips)

dev.copy(png,file="final.png",width=480,height=480,units="px")
dev.off
