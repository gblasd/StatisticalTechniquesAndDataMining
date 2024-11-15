# Computing k-means clustering in R

# Data
library("cluster")
data("USArrests")
df <- scale(USArrests)

# view the first 3 rows of the data
head(df, n = 3)

library("factoextra")
fviz_nbclust(df, kmeans, method = "wss") + 
  geom_vline(xintercept = 4, linetype = 2)

# Computhe k-means with k = 4
set.seed(123)
km.res <- kmeans(df, 4, nstart = 25)
print(km.res)

# It´s possible to compute the mean of each variables by clusters using the original data
aggregate(USArrests, by=list(cluster=km.res$cluster), mean)
# Add the point classifications to the original data
dd <- cbind(USArrests, cluster = km.res$cluster)
head(dd)

# Cluster number for each of the observations 
km.res$cluster
head(km.res$cluster, 4)

# Cluster size
km.res$size

# Cluster means
km.res$centers


# Visualizing k-means clusters
# If we have a multi-dimensional data set, a solution is to perform Principal
# Component Analysis (PCA) and to plot data points according to the first two 
# principal components coordinates
fviz_cluster(km.res, data = df,
             palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"),
             ellipse.type = "euclid", # Concentration ellipse
             star.plot = TRUE, # Add segments from centroids to items
             repel = TRUE, # Avoid label overplotting (slow)
             ggtheme = theme_minimal()
)
