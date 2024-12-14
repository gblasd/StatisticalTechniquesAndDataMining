# Agglometarive Clustering

# Load the data
data("USArrests")

# Standardize the data
df <- scale(USArrests)

# Show the fisrt 6 rows
head(df, nrow = 6)

# Compute the dissimilirity matrix
# df = the standardized data
res.dist <- dist(df, method = "euclidean")
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
grp <- cutree(res.hc, k = 4)
head(grp, n = 4)

# Number of members in each cluster
table(grp)

# Get the names for the members of cluster 1
rownames(df)[grp == 1]

# Cut in 4 groups and color by groups
fviz_dend(res.hc, k = 4, # Cut in four groups
          cex = 0.5, # label size
          k_colors = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"),
          color_labels_by_k = TRUE, # color labels by groups
          rect = TRUE # Add rectangle around groups
)


# Cluster plot
fviz_cluster(list(data = df, cluster = grp),
             palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"),
             ellipse.type = "convex", # Concentration ellipse
             repel = TRUE, # Avoid label overplotting (slow)
             show.clust.cent = FALSE, ggtheme = theme_minimal())