# datos
data <- read.csv("train.csv")
str(data)

unique(data$Inflight.wifi.service)

df <- data
df$X <- NULL
df$id <- NULL

# solo columnas con valores ordinales
df <- df[,7:20]
# valores null en cada columna
colSums(is.na(df))

head(df)
summary(df)

library(corrplot)
corrplot(cor(df), method = "color", type = "upper", tl.cex = 0.8, 
         order = "hclust", diag = FALSE, addCoef.col = "black", 
         col = colorRampPalette(c("blue", "white", "red"))(200))

# aplicacion de PCA
data.pca <- princomp(df, cor=T)

summary(data.pca)
eigenvalue <- data.pca$sdev^2
eigenvalue

library(ggplot2)# Simular eigenvalues para el ejemplo
eigenvalues <- c(3.8, 2.3, 1.5, 1.2, 0.8, 0.7, 0.5, 0.4, 0.3, 0.2, 0.2, 0.1, 0.1, 0.1)# Crear un data frame para ggplot
df <- data.frame(  Component = 1:length(eigenvalues),  Eigenvalue = eigenvalues)# Número de factores (eigenvalue >= 1)
n_factors <- sum(eigenvalues >= 1)# Crear el gráfico ###################### regla de Kaiser

ggplot(df, aes(x = Component, y = Eigenvalue), ) +  
  geom_bar(stat = "identity", fill = "skyblue", alpha = 0.6, show.legend = TRUE) + # Barras  
  geom_line(color = "blue", size = 1.2, aes(group = 1)) + # Línea  
  geom_point(color = "orange", size = 3) + # Puntos en la línea  
  geom_hline(yintercept = 1, color = "red", linetype = "dashed", size = 0.8) + # Línea de corte en y = 1  
  annotate("text", x = 4.5, y = max(eigenvalues), label = paste("Number of Factors =", n_factors),           
           color = "red", size = 5, hjust = 0) + # Etiqueta del número de factores  
  labs(    title = "Scree Plot with Bar and Line Graph",    x = "Principal Component",    y = "Eigenvalue", ) +  
  theme_minimal(base_size = 14) +  
  theme(    plot.title = element_text(size = 16, face = "bold", hjust = 0.5), panel.grid.minor = element_blank())


# Analisis de factores
cor(df)

# install.packages("corrplot")
library(corrplot)
corrplot.mixed(cor(df),
               lower = "number", 
               upper = "circle",
               tl.col = "black")


# Requerimos la librería psych
# la rotacion puede ser "none", "varimax", "quatimax", "promax", "oblimin", "simplimax", or "cluster"
library(psych)
df_2 <- df

df_2$Checkin.service <- NULL
df_2$Leg.room.service <- NULL
df_2$Departure.Arrival.time.convenient <- NULL
df_2$Gate.location <- NULL
df_2$On.board.service <- NULL ## **** modelo

library(corrplot)
corrplot(cor(df_2), method = "color", type = "upper", tl.cex = 0.8, 
         order = "hclust", diag = FALSE, addCoef.col = "black", 
         col = colorRampPalette(c("blue", "white", "red"))(200))


x<-fa(df_2,nfactors=4,fm="pa",rotate="promax") # **modelo
x
plot(x$load[,1:2], col="white")
text(x$load[,1:2], labels = row.names(x$loadings[,1:2]))


x$scores

dataset <- x$scores
dataset

#x <- fa(df_2, nfactors = 4, fm = "pa", rotate = "promax", scores = "tenBerge")
#scores_tenberge <- x$scores

# Computing k-means clustering in R

# Data
library("cluster")
library("factoextra")
library(ggplot2)

#df <- scale(dataset)
dataset <- dataset[100:5,]

# view the first 3 rows of the data
head(dataset, n = 3)

# Computhe k-means with k = 4
set.seed(123)
km.res <- kmeans(dataset, 3, nstart = 25)
print(km.res)

# It´s possible to compute the mean of each variables by clusters using the original data
aggregate(dataset, by=list(cluster=km.res$cluster), mean)
# Add the point classifications to the original data
dd <- cbind(dataset, cluster = km.res$cluster)
head(dd)

# Cluster number for each of the observations 
km.res$cluster
head(km.res$cluster, 4)

# Cluster size
km.res$size

# Cluster means
km.res$centers

km.res

# Visualizing k-means clusters
# If we have a multi-dimensional data set, a solution is to perform Principal
# Component Analysis (PCA) and to plot data points according to the first two 
# principal components coordinates
fviz_cluster(km.res, data = dd,
             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
             ellipse.type = "euclid", # Concentration ellipse
             star.plot = TRUE, # Add segments from centroids to items
             repel = TRUE, # Avoid label overplotting (slow)
             ggtheme = theme_minimal()
)




# Agglometarive Clustering


# Compute the dissimilirity matrix
# df = the standardized data
res.dist <- dist(dataset, method = "euclidean")
print(res.dist)

# In the next matrix, value in the cell formed by the row i, the column j, 
# represents the distance between object i and object j in the original dataset
as.matrix(res.dist)[1:6, 1:6]

res.hc <- hclust(d = res.dist, method = "ward.D2")
print(res.hc)

# Dendogram
# cex: label size
library("factoextra")
fviz_dend(res.hc, cex = 0.5)


# Compute cophentic distance
res.coph <- cophenetic(res.hc)

# Correlation between cophentic distance and the original distance
cor(res.dist, res.coph)

res.hc2 <- hclust(res.dist, method = "average")
cor(res.dist, cophenetic(res.hc2))

# Cut the dendogram into different groups
# Cut tree into 4 groups
grp <- cutree(res.hc, k = 3)
head(grp, n = 3)

# Number of members in each cluster
table(grp)

# Get the names for the members of cluster 1
rownames(df)[grp == 1]

# Cut in 4 groups and color by groups
fviz_dend(res.hc, k = 3, # Cut in four groups
          cex = 0.5, # label size
          k_colors = c("#2E9FDF", "#E7B800", "#FC4E07"),
          color_labels_by_k = TRUE, # color labels by groups
          rect = TRUE # Add rectangle around groups
)


# Cluster plot
fviz_cluster(list(data = df[100:5,], cluster = grp),
             palette = c("#2E9FDF", "#E7B800", "#FC4E07"),
             ellipse.type = "convex", # Concentration ellipse
             repel = TRUE, # Avoid label overplotting (slow)
             show.clust.cent = FALSE, ggtheme = theme_minimal())



# Cargar la librería para LDA
library(MASS)

dim(dd) # Dimension de los datos
df = data.frame(dd[,1:4],clase=as.vector(dd[,5]))# **modelo
df = data.frame(dd[,1:5],clase=as.vector(dd[,6]))

# Realizar LDA
modelo.lda = lda(clase~.,data = df)

# Resumen del modelo
summary(modelo.lda)

attributes(modelo.lda)   # cosas que devuelve la función

modelo.lda$prior  # Asi podemos ver,por ejemplo,las probabilidades a priori

predict(modelo.lda, df[,1:5])$class   # predecimos con el AD los primeros 4 iris de la base original 
predict(modelo.lda, df[,1:6])$class   # predecimos con el AD los primeros 4 iris de la base original 

# Para ver cómo fueron de correctas las predicciones, podemos hacer una tabla cruzando las verdaderas clases con las predicciones:
table(df[,5],predict(modelo.lda, df[,1:5])$class)#**modelo
table(df[,6],predict(modelo.lda, df[,1:6])$class)


