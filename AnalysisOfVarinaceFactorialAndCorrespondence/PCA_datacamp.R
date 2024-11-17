
# package for creation and managment of data in R
install.packages("corrr")
library("corrr")

# Visualization of correlation matrix
install.packages("ggcorrplot")
library(ggcorrplot)
library(ggplot2)

# Acces to module PCA
install.packages("FactoMineR")
library("FactoMineR")

protein_data <- read.csv("protein.csv")
str(protein_data) # All columns are num except colum country

# NULL values
colSums(is.na(protein_data))

# Data normalization
# PCA only works with numeric values
# Drop column 'Country'
numerical_data <- protein_data[,2:10]
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

# Data visualization
library(factoextra)
library(ggplot2)
# this plot show the values in descending curve
# from highest to lowest
fviz_eig(data.pca, addlabels = TRUE)
# With the biplot, it is possible to visualize the 
# similarities and dissimilarities of the samples, 
# and also shows the impact of each attribute on each 
# of the main components.

# Graph of the variables
fviz_pca_var(data.pca, col.var = "black")

# Contribution of each variable
# The value low mean that the variable is not perfectly represents by that component.
# Tha value high mean a good represetntation by the variable in this component.
fviz_cos2(data.pca, choice = "var", axes = 1:2)


# biplot combined with cos2
fviz_pca_var(data.pca, col.var = "cos2",
             gradient.cols = c("black", "orange", "green"),
             repel = TRUE)



# https://www.datacamp.com/es/tutorial/pca-analysis-r