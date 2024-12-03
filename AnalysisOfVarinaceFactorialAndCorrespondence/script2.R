data <- read.table("riesgo.csv",header=TRUE,sep = ',')
data$calif <- NULL

sapply(data, function(x) sum(is.na(x)))

data[is.na(data$atnprenat), "atnprenat"] <- as.integer(mean(data$atnprenat, na.rm = TRUE))
data[is.na(data$partoasit), "partoasit"] <- as.integer(mean(data$partoasit, na.rm = TRUE))

library(fastDummies)

data_pre = dummy_cols(data,  select_columns = c("abort", "vihsida"))
data_pre$abort <- NULL
data_pre$vihsida <- NULL

#graficas
library(ggplot2)

# Convertir a formato largo para ggplot
library(reshape2) # Para reorganizar datos en formato largo
data_long <- melt(data_pre)

# Crear boxplots para todas las columnas numéricas
ggplot(data_long, aes(x = variable, y = value)) +
  geom_boxplot(outlier.color = "red", outlier.size = 2) +
  theme_minimal() +
  labs(title = "Boxplots con escalas independientes", x = "Variable", y = "Valor") +
  facet_wrap(~variable, scales = "free_y") + # Escalas independientes en el eje Y
  theme(axis.text.x = element_blank(), # Ocultar etiquetas en el eje X
        axis.ticks.x = element_blank(),
        strip.text = element_text(size = 10)) # Ajustar tamaño del texto en los paneles

## gráficos de dispersión para revisar que estén correlacionados los datos y distinguir cada especie
pairs(data_pre[,2:9]) 


## Matriz varianzas y covarianzas
var(data_pre[,2:9])
var(data_pre[,2:17])


## Matriz Correlacion
cor(data_pre[,2:9])

## PCA
#princomp(data_pre[,2:17])

#Standard deviations
pca <- princomp(data_pre[,2:17],cor=T) 

# sd, proportion of variance, cumulative proportion
summary(pca)

#Coeficientes (pesos)
pca$loadings

# Grafica de proporcion de varianza por componente
screeplot(pca)

# Transformacion
pca$scores

# Deteccion de outliers
plot(pca$scores[,7:8])

###################################################
cal <- read.table("riesgo.csv",header=TRUE,sep = ',')
cal <- cal$calif

#scores: primer componente
pca$scores[,1]

cal_comp <- cbind(cal, pca$scores[,1])

cor(cal_comp)

plot(cal_comp)
