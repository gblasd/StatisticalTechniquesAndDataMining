# Leer los datos
datos <- read.csv("datos discriminante.csv")

# Normalizar las columnas (excepto el nombre de los estados, si es cualitativa)
datos_normalizados <- scale(datos[,-1])

library(factoextra)
fviz_nbclust(datos_normalizados, kmeans, method = "wss")  # Visualiza el "codo"

# Ejecutar K-means con el número óptimo de clusters (ej. k = 3)
set.seed(123)
kmeans_result <- kmeans(datos_normalizados, centers = 2)

# Agregar el cluster como columna en los datos originales
datos$cluster <- kmeans_result$cluster

# Cargar la librería para LDA
library(MASS)

dim(datos) # Dimension de los datos
df = data.frame(datos[,2:7],clase=as.vector(datos[,8]))

datos
df

# Realizar LDA
modelo.lda = lda(clase~.,data = df)

# Resumen del modelo
summary(modelo.lda)

attributes(modelo.lda)   # cosas que devuelve la función

modelo.lda$prior  # Asi podemos ver,por ejemplo,las probabilidades a priori

predict(modelo.lda, df[,1:6])$class   # predecimos con el AD los primeros 4 iris de la base original 
# Para ver cómo fueron de correctas las predicciones, podemos hacer una tabla cruzando las verdaderas clases con las predicciones:
table(df[,7],predict(modelo.lda, df[,1:6])$class)

#Otra manera alternativa de proporcionar el conjunto de datos a la función lda podría ser
estados = df[,7]
lda(df[,1:6], estados)
lda(iris[,1:4],especies)

# Para dibujar la proyección del conjunto de datos (que es de dimensión 4) sobre los dos primeros ejes discriminantes:
df.proy = predict
df.proy = predict(modelo.lda, df[,1:6])$x
plot(df.proy)
#  Veamos como los reasigno
plot(df.proy,type="n")
text(df.proy ,labels=as.numeric(df$cluster),col=as.numeric(predict(modelo.lda,df[,1:6])$class))
