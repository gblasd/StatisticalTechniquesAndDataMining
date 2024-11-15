# Computing k-means clustering in R

# Data
library("cluster")
data <- read.table("/Users/gblasd/Documents/ST&DM/StatisticalTechniquesAndDataMining/AnalysisOfVarinaceFactorialAndCorrespondence/data.csv",header=TRUE,sep = ',')
data_r <- data
head(data)
head(data_r)

attach(data)
data <- as.matrix(cbind(x1, x2, x3, x4, x5))
head(data)
df <- scale(data)

# view the first 3 rows of the data
head(df, n = 3)

library("factoextra")
fviz_nbclust(df, kmeans, method = "wss") + 
  geom_vline(xintercept = 5, linetype = 2)

# Computhe k-means with k = 5
set.seed(123)
km.res <- kmeans(df, 5, nstart = 25)
print(km.res)

# It´s possible to compute the mean of each variables by clusters using the original data
aggregate(data, by=list(cluster=km.res$cluster), mean)
# Add the point classifications to the original data
dd <- cbind(data_r, cluster = km.res$cluster)
head(dd)

# Set column as index 
row.names(dd) <- dd$var
head(dd)
# drop column
dd$var <- NULL
head(dd)

# Cluster number for each of the observations 
km.res$cluster
head(km.res$cluster, 5)

# Cluster size
km.res$size

# Cluster means
km.res$centers


# Visualizing k-means clusters
# If we have a multi-dimensional data set, a solution is to perform Principal
# Component Analysis (PCA) and to plot data points according to the first two 
# principal components coordinates
fviz_cluster(km.res, 
             data = dd,
             palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07", "#004E02"),
             ellipse.type = "euclid", # Concentration ellipse
             star.plot = TRUE, # Add segments from centroids to items
             repel = TRUE, # Avoid label overplotting (slow)
             ggtheme = theme_minimal()
)

