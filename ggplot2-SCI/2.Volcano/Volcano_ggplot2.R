# 火山图绘图
# 配置路径
setwd("C:\\Users\\Administrator\\Documents\\R-study\\ggplot2-SCI\\2.Volcano")
# 加载包
library(ggplot2)
library(openxlsx)
library(stringr)#用来字符串处理
d1 <- read.xlsx("Expre_data.xlsx",sheet = 1,colNames = T)
d2 <- na.omit(d1)
d3 <- d2
#genesymbol中有很多///分割的id，利用stringr包中的str_split_fixed()函数可以分割字符串
d3$GeneSB=str_split_fixed(d3$GeneSB,"///",3)[,1] #d3$GeneSB是需要分割的数据，"///"为分隔符，3位分割为3部分，[]取有用的值
#重复去重
unique(d3$GeneSB)
which(duplicated(d3$GeneSB))
#取第一个重复的值
d3 <- d3[!duplicated(d3$GeneSB),]
nrow(d3)
#存储数据,利用write.xlsx函数
write.xlsx(d3,file = "ExprGene_data.xlsx",colnames= T)
head(d3)

data <- read.xlsx("ExprGene_data.xlsx",sheet=1,colNames = T)
row.names(data) <- data$GeneSB
data <- data[,-1]
data$label <- c(rownames(data)[1:10],rep(NA,(nrow(data)-10)))#添加label列，用来添加
head(data)

#绘图scale_color_gradient()函数参数调整
ggplot(data,aes(logFC,-log10(adj.P.Val)))+
  geom_point(aes(color=-log10(data$adj.P.Val),size=-log10(data$adj.P.Val)))+
  scale_color_gradient2(low = "#3e51a2",mid = "#faed33",high = "#b61f25",midpoint = 1)+
  theme_bw()+
  theme(panel.grid = element_blank())

#绘图，ggplot2有图层，所以底层的先画
ggplot(data,aes(logFC,-log10(adj.P.Val)))+  
  geom_hline(yintercept = -log10(0.05),linetype="dashed",color="#999999")+#添加水平辅助线
  geom_vline(xintercept = c(-1.2,1.2),linetype="dashed",color="#999999")+#添加垂直平辅助线
  geom_point(aes(color=-log10(data$adj.P.Val),size=-log10(data$adj.P.Val)))+
  scale_color_gradientn(values = seq(0,1,0.2),#绘图scale_color_gradientn()函数参数调整，value创建一个范围区间，color指定颜色
                        colours = c("#39489f","#41c4e5","#fceb30","#e82e6a","#b11f24"))+
  scale_size_continuous(range = c(1,3))+#设定点的大小，连续变化从1到3
  theme_bw()+
  theme(panel.grid = element_blank(),#主题设定，删除方格线
        legend.position = c(0.01,0.8),#legeng的位置设定
        legend.justification = c(0,1))+#未知相对于那个坐标，（0,1）是左上
  guides(col=guide_colorbar(title = "-log10_q_value"),size="none")+#设置legend的标题，size的图例删除
  geom_text(label=data$label,aes(color=-log10(data$adj.P.Val)),size=3,vjust=1.5,hjust=1)+#添加label文字，设置大小
  xlab("LogFC")+
  ylab(("-log10(FDR q-value)"))

ggsave("Vocanol_plot_DEGS.pdf",height = 10,width = 10)
