# 复杂提琴图，ggplot2中的geom_tile绘制相关性热图
# 学习文档：微信公众号《生信师兄》跟着sci学画图
# 配置路径
setwd("C:\\Users\\Administrator\\Documents\\R-study\\ggplot2-SCI\\4.violin_plot")
#载入包
library(ggplot2)
library(ggsignif)
library(ggpubr)

###模拟数据构建
WT <- rnorm(5346,9,1)
Gain <- rnorm(877,10,1)
LOH <- rnorm(2619,9,1)
HD <- rnorm(774,5,2)
##合并数据
data <- as.data.frame(cbind(rep(c("WT","Gain","LOH","HD"),c(5346,877,2619,774))),
                            c(WT,Gain,LOH,HD))
data$Values <- as.numeric(rownames(data))
colnames(data) <- c("Group","Values")
data$Group <- as.factor(data$Group)
rownames(data) <- NULL
data$Group=factor(data$Group, levels=c("WT","Gain","LOH","HD"))

ggplot(data)+
  geom_violin(aes(Group,Values,fill=Group,color=Group))+
  geom_boxplot(aes(Group,Values),fill="#a6a7ac",color="#a6a7ac",width=0.1,
               outlier.shape = NA)+
  scale_fill_manual(values = c("#d1d2d2","#fbd3b9","#a1c9e5","#417bb9"))+
  scale_color_manual(values = c("#d1d2d2","#fbd3b9","#a1c9e5","#417bb9"))+
  scale_y_continuous(breaks = seq(-2,14,2))+
  theme_bw()+
  theme(panel.grid = element_blank(),
        axis.text.x = element_text(angle = 45,hjust=1))+
  xlab("Status")+
  ylab("Gene expression")+
  annotate("text",x=3,y=14,label="bolditalic(MTAP)",parse=T,color="black",size=8)+
  annotate("text",x = 1.2,y=6,label="5346",color="#a6a7ac")+
  annotate("text",x = 2.2,y=7.8,label="877",color="#a6a7ac")+
  annotate("text",x = 3.3,y=7.2,label="2619",color="#a6a7ac")+
  annotate("text",x = 4.2,y=1.5,label="774",color="#a6a7ac")+
  #差异显著性线添加
  geom_signif(aes(Group,Values),
              comparisons = list(c("LOH","HD"), #那些组进行比较
                                 c("WT","HD")),
              map_signif_level = T,#T显示显著性，F显示p_value
              tip_length = c(0,0), #修改显著性线两端的长短
              y_position = c(0,-0.5),#设置显著性线的位置高度
              size = 0.5, #线的粗细
              textsize = 4,#修改显著性标记的大小
              extend_line=-0.1,#线的长短：默认为0
              color="#000000",#线的颜色
              test = "t.test")#检验的类型
