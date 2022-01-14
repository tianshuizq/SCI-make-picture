#配置路径
setwd("C:\\Users\\Administrator\\Documents\\R-study\\ggplot2-SCI\\5.heamap_barplot")
test <- matrix(rnorm(200),20,10)
test[1:10, seq(1, 10, 2)] = test[1:10, seq(1, 10, 2)] + 3
test[11:20, seq(2, 10, 2)] = test[11:20, seq(2, 10, 2)] + 2
test[15:20, seq(2, 10, 2)] = test[15:20, seq(2, 10, 2)] + 4
colnames(test) <- paste("Test",1:10,sep = "")
rownames(test) <- paste("Gene",1:20,sep = "")
dim(test)
data=as.data.frame(test)


#pheatmap绘制heatmap
library(pheatmap)
library(stringr)
library(gplots)
library(reshape2)
data <- mtcars[,1:7]
data <- data[,-2]
test <- as.matrix(as.numeric(test))
colnames(data) <- str_to_upper(colnames(data))
heatmap(test)
heatmap.2(data)

#pheatmap包函数绘制
pheatmap(test)
pheatmap(test,scale = "row",color = colorRampPalette(c("navy", "white", "firebrick3"))(50),
         border_color = "white",main = "Heatmap of DEGS",angle_col = 45,display_numbers = T,#display_number是否展示数字
         number_format = "%.2f", number_color = "grey30")#number_format数字的格式


#heatmap绘制热图
heatmap(test, scale = "row",main = "Heatmap of DEGS by heatmap()")


#heatmap.2绘制热图
heatmap.2(test,scale = "row",col = redgreen(20),trace = "none",key.title = "",keysize = 1.2)

#ggplot2绘制热图
library(ggplot2)

hc<-hclust(dist(test),method = "average") #对行进行聚类
rowInd<-hc$order #将聚类后行的顺序存为rowInd
hc<-hclust(dist(t(test)),method = "average")  #对矩阵进行转置，对原本的列进行聚类
colInd<-hc$order  #将聚类后列的顺序存为colInd
test<-test[rowInd,colInd] #将数据按照聚类结果重排行和列  
data <- melt(test,varnames=c("Gene","Test"))#使用melt对数据进行变换，ggplot2只能用长数据绘图，data类型是matrix
data$value<-round(data$value,2)

ggplot(data,aes(x=Test,y=Gene))+
  geom_tile(aes(fill=value))+
  scale_fill_distiller(palette = "RdYlBu")+#连续值用distiller
  geom_text(aes(label=value),size=3)+
  theme(panel.background = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        axis.text.x = element_text(angle = 45,hjust = 1)) 
