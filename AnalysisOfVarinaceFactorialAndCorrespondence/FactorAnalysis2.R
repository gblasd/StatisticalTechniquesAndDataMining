install.packages("readxl")
library(readxl)
calificaciones <- read_xlsx(path = "calif.xlsx")

# install.packages("corrplot")
library(corrplot)
corrplot.mixed(cor(calificaciones),
               lower = "number", 
               upper = "circle",
               tl.col = "black",
               tl.pos = 'n')


corrplot(cor(calificaciones, use="complete.obs"), order = 'original' , tl.col='black', tl.cex=.75) 

library(psych)
install.packages("psych")
factores <- fa(calificaciones, nfactors = 5,fm = "pa", rotate = 'promax')
factores$STATISTIC
