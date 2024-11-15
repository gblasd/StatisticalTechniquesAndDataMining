# CLUSTER ANALYSIS

install.packages("cluster")

library("cluster")

data("USArrests") # Load the data set
head(USArrests, 3) # Print the first 3 rows

# Access the data in 'Murder' column
# dollar sign is used
head(USArrests$Murder)

### Data Preparation
df <- USArrests # Use df as shorter name

# Remove any missing value that migth be present in the data
df <- na.omit(df)

# We don´t want the clustering algorithm to depend to an arbitrary variable unit,
# we start by scaling/standardizing the data 
df <- scale(df)
head(df, n = 3)

# install two packages
install.packages(c("cluster", "factoextra"))

# Subset of the data
set.seed(123)
ss <- sample(1:50, 15) # Take 15 random rows
df <- USArrests[ss, ]  # Subset the 15 rows
df.scaled <- scale(df) # Standardize the variables

### Compute euclidean distance
dist.eucl <- dist(df.scaled, method = "euclidean")

# Reformat as a matrix
# Subset the fisrt 3 columns and rows and Round the values
round(as.matrix(dist.eucl)[1:3, 1:3], 1) 
# In this matrix, the value represent the distance between objects. The values 
# on the diagonal of the matrix represent the distance between objects and
# themselves (wich are zero).

### Computing correlation based distances
# Compute 
library("factoextra")
dist.cor <- get_dist(df.scaled, method = "pearson")
# Display the subset
round(as.matrix(dist.cor)[1:3, 1:3], 1)





