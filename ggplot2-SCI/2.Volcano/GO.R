# 火山图绘图后续的GO富集分析
# 参考文档：https://www.jianshu.com/p/69aa1c9cf4d1
# clusterProfiler包，YU叔的包，可以用来做ID的转换，GO，KEGG富集分析，DO富集分析等
# 配置路径

setwd("C:\\Users\\Administrator\\Documents\\R-study\\ggplot2-SCI\\2.Volcano")

library(ggplot2)
library(openxlsx)
data <- read.xlsx("ExprGene_data.xlsx",sheet=1,colNames = T)
#加载包
library(clusterProfiler)
library(org.Hs.eg.db)
library(topGO)
library(enrichplot)
library(stringr)#字符串处理的包
genelist <- data$GeneSB
head(genelist)
#GO富集分析，OrgDb为注释库，ont参数可以选择ALL，CC，MF，B
go <- enrichGO(gene = genelist2$ENTREZID,OrgDb = org.Hs.eg.db,ont = "ALL",pAdjustMethod = 'BH',pvalueCutoff = 0.05, qvalueCutoff = 0.2,keyType = 'ENTREZID')
head(go)
dim(go)
barplot(go,showCategory=20,drop=T)
dotplot(go,showCategory=50)

write.csv(go,"GO Analysis of data.csv")

#KEGG富集分析
genelist1 <- toupper(x = genelist)#ID的所有字母转化为大写
head(genelist1)
#转化geneID
genelist2 <- bitr(geneID = genelist1,fromType = "SYMBOL",toType = 
                    "ENTREZID",OrgDb="org.Hs.eg.db")#ID转换，kegg要用ENTREZID
#富集分析
kegg <- enrichKEGG(gene= genelist2$ENTREZID,organism  = 'hsa',pvalueCutoff = 0.05)
dim(kegg)
head(kegg)
#简单可视化
dotplot(kegg, showCategory=30)
barplot(kegg,showCategory = 30,title = str_to_title("barplot for kegg"))#str_to_title()函数转换成首字母大写


