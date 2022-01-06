#生信师兄作图学习
#哔哩哔哩：https://www.bilibili.com/video/BV1b3411t735?spm_id_from=333.999.0.0
#日期：2022年1月6日，赵强zero

#读取数据
library(openxlsx)
data <- read.xlsx("C:/Users/Administrator/Desktop/BMI.xlsx",
                  sheet=1,colNames = T,rowNames = F)


#散点图ggplot2
library(ggplot2)
point <- ggplot(data,aes(Becteroides.thetaiotaomicron,BMI))+
            geom_point(aes(col=group))+
            scale_color_manual(values = c("group_3M"="#8ac53e","group_0M"="#ff00ff"))+ #分组的颜色设定
            theme_classic()+
            theme(legend.position = "none")+
            xlab("Becteroides thetaiotaomicron(11021)")+
            ylab("BMI(lg)")+
            scale_x_continuous(breaks = seq(-20,-10,2))+ #连续型坐标轴，seq()函数创建向量
            scale_y_continuous(breaks = seq(3,4,0.2))

#箱线图1
boxplot1 <-ggplot(data,aes(group,BMI))+
              stat_boxplot(geom = "errorbar",aes(color=group),width=0.2)+
              geom_boxplot(aes(col=group))+
              geom_jitter(aes(color=group),width = 0.1)+  #jitter抖动图，width设置抖动的宽度，color和fill参数的不同
              geom_line(aes(group=group2),linetype="dashed",alpha=0.8,size=0.2)+
              scale_color_manual(values = c("group_3M"="#8ac53e","group_0M"="#ff00ff"))+
              theme_classic()+
              theme(legend.position = "none")+
              xlab("")+
              ylab("")+
              scale_x_discrete(labels=c("0M","3M"))+  #离散的坐标轴，c创建向量
              scale_y_continuous(breaks = seq(3,4,0.2))
print(boxplot1)

#箱线图2
boxplot2  <- ggplot(data,aes(group,Becteroides.thetaiotaomicron))+
                stat_boxplot(geom = "errorbar",aes(color=group),width=0.2)+
                geom_boxplot(aes(col=group))+
                geom_jitter(aes(color=group),width = 0.1)+  #jitter抖动图，width设置抖动的宽度，color和fill参数的不同
                geom_line(aes(group=group2),linetype="dashed",alpha=0.8,size=0.2)+
                scale_color_manual(values = c("group_3M"="#8ac53e","group_0M"="#ff00ff"))+
                theme_classic()+
                theme(legend.position = "none")+
                xlab("")+
                ylab("")+
                scale_x_discrete(labels=c("0M","3M"))+  #离散的坐标轴，c创建向量
                scale_y_continuous(breaks = seq(-20,-10,2))+
                coord_flip()
print(boxplot2)

##图形合并
##http://sthda.com/english/articles/24-ggpubr-publication-ready-plots/81-ggplot2-easy-way-to-mix-multiple-graphs-on-the-same-page
library(ggpubr)
##ggarrange函数用来组合图片，可以用NULL占位为空图片
ggarrange(boxplot1,point,NULL,boxplot2,
          ncol=2,nrow = 2,align = "hv",
          widths = c(0.8, 2), heights = c(2, 0.8),
          common.legend = TRUE,legend = "none")


