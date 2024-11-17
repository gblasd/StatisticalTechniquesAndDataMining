# package for creation and managment of data in R
#install.packages("corrr")
library("corrr")

# Visualization of correlation matrix
#install.packages("ggcorrplot")
library(ggcorrplot)
library(ggplot2)

# Acces to module PCA
#install.packages("FactoMineR")
library("FactoMineR")
library("factoextra")


data <- read.csv("riesgo.csv")
head(data)

# NULL values
sapply(data, function(x) sum(is.na(x)))

data[is.na(data$atnprenat), "atnprenat"] <- as.integer(mean(data$atnprenat, na.rm = TRUE))
data[is.na(data$partoasit), "partoasit"] <- as.integer(mean(data$partoasit, na.rm = TRUE))

# NULL values
sapply(data, function(x) sum(is.na(x)))
str(data)

# Extract numerical data and normalization
numerical_data <- data
numerical_data$Country <- NULL
numerical_data$abort <- NULL
numerical_data$vihsida <- NULL
head(numerical_data)

data_normalized <- scale(numerical_data)
head(data_normalized)

# Compute the correlation matrix
corr_matrix <- cor(data_normalized)
ggcorrplot(corr_matrix)

# PCA application
data.pca <- princomp(corr_matrix)
summary(data.pca)

# loading matrix of PCA1 and PCA2
data.pca$loadings[, 1:2]

fviz_eig(data.pca, addlabels = TRUE)
fviz_pca_var(data.pca, col.var = "black")
fviz_cos2(data.pca, choice = "var", axes = 1:2)
fviz_pca_var(data.pca, col.var = "cos2",
             gradient.cols = c("black", "orange", "green"),
             repel = TRUE)

################################################################################
# Add categorical variables
head(data)

library(fastDummies)
data_pre <- dummy_cols(data, select_columns = c("abort", "vihsida"))
head(data_pre) # This data contains columns 'abort' and 'vihsida'
# Drop columns
data_pre$Country <- NULL # char
data_pre$abort <- NULL   # categorical
data_pre$vihsida <- NULL # categorical
data_pre$calif <- NULL   # no use this colums
head(data_pre)
numerical_data <- data_pre
head(numerical_data)

# NULL values
sapply(numerical_data, function(x) sum(is.na(x)))
numerical_data[is.na(numerical_data$atnprenat), "atnprenat"] <- as.integer(mean(numerical_data$atnprenat, na.rm = TRUE))
numerical_data[is.na(numerical_data$partoasit), "partoasit"] <- as.integer(mean(numerical_data$partoasit, na.rm = TRUE))

# summary data
#summary(data_pre)
#pairs(data_pre[,2:9]) # pairplot
#var(data_pre[,2:9]) # Matriz varianzas y covarianzas
#cor(data_pre[,2:9]) # Matriz Correlacion

# Data normalization ########### USE THIS DATA
data_normalized <- scale(numerical_data)
data_normalized <- numerical_data ##############################################
head(data_normalized)
summary(data_normalized)
pairs(data_normalized[, 1:8]) # pairplot

var_matrix <- var(data_normalized[,1:8]) # Matriz varianzas y covarianzas
ggcorrplot(var_matrix, 
           show.legend = TRUE, 
           digits = 3, 
           lab = TRUE,
           ggtheme = ggplot2::theme_gray,
           colors = c("#6D9EC1", "white", "#E46726"),
           title = "Matriz de covarianza")

corr_matrix <- cor(data_normalized[,1:8]) # Matriz Correlacion
ggcorrplot(corr_matrix, 
           show.legend = TRUE, 
           digits = 3, 
           lab = TRUE,
           ggtheme = ggplot2::theme_gray,
           colors = c("#6D9EC1", "white", "#E46726"),
           title = "Matriz de correlación")


# PCA application
res.pca <- princomp(data_normalized[,1:16],cor=T)
print(res.pca)

# loading matrix of PCA1 and PCA2
res.pca$loadings[, 1:2]

# Data visualization
library(factoextra)
library(ggplot2)
fviz_eig(res.pca, addlabels = TRUE)
fviz_pca_var(res.pca, col.var = "cos2",
             gradient.cols = c("black", "orange", "green"),
             repel = TRUE)




#Coeficientes (pesos)
res.pca$loadings
# Grafica de proporcion de varianza por componente
# screeplot(res.pca)
# Transformacion
res.pca$scores
# Deteccion de outliers
plot(res.pca$scores[,1:2])
###################################################
#cal <- read.table("riesgo.csv",header=TRUE,sep = ',')
cal <- data$calif
#scores: primer componente
res.pca$scores[,1]
cal_comp <- cbind(cal, res.pca$scores[,1])
cor(cal_comp)
plot(cal_comp)
