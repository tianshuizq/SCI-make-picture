# 相关性分析的气泡图制作ggplot2中的geom_tile绘制相关性热图
# 学习文档：微信公众号《小明的数据分析笔记》https://mp.weixin.qq.com/s/wVZDfMlwYk1AiJpukJmlog
# 配置路径
setwd("C:\\Users\\Administrator\\Documents\\R-study\\ggplot2-SCI\\3.heatmap_corr")
# 加载包
library(ggplot2)
library(readr)
#读取数据
df1<-read_tsv("index.txt")
head(df1)
df2 <- read_tsv("meta.txt")
head(df2)
dim(df2)
# #相关性分析
# library(psych)
# cor.result <- corr.test(df1,df2,method = "pearson")
# head(cor.result)
# 
# #数据清洗
# library(tidyverse)
# cor.result$p %>% 
#   as.data.frame() -> new_df1
# head(new_df1)
# head(cor.result$p)

cor_re <- cor(df1,df2)

dim(cor_re)


plotdf<-reshape2::melt(cor_re)
plotdf
plotdf$value<-round(plotdf$value,2)
ggplot(plotdf,aes(x=Var1,y=Var2))+
  geom_tile(aes(fill=value))+
  scale_fill_gradient2(low = "green",mid="white",high = "red")+
  geom_text(aes(label=value),size=3)+
  theme(panel.background = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        axis.text.x = element_text(angle = 45,hjust = 1))

ggsave("heatmap_corr.png",width = 11,height = 10)

#气泡图
ggplot(plotdf,aes(x=Var1,y=Var2))+
  geom_point(aes(fill=abs(value),size=abs(value)),color ="#999999",shape=21)+
  scale_fill_gradient(low = "#ffbc15",high = "#ef1828")+
  theme_bw()+
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        axis.text.x = element_text(angle = 30,hjust = 1),
        plot.title = element_text(hjust = 0.5))+##title居中处理
  labs(title="Correlation of gene expression",x="",y="")
  


ggsave("pbubbleplot_corr.png",width = 11,height = 10)            
