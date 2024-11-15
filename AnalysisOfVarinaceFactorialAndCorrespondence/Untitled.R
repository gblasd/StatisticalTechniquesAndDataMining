## Para pasar datos de forma directa de Excel sólo copiando se puede utilizar la siguiente función
# Los pasos a seguir son:
# 1 Seleccionar en el Excel la base de datos que nos interesa y seleccionar copiar (Ctrl + c) 
#2 En R escribir  “   nombredelabase<-read.delim("clipboard")  ” y dar enter

razas<-read.delim("clipboard")

## desde un archivo 

razas<-read.table("ejemplorazas.csv",header=TRUE,sep = ',')

##Hacemos de una tabla a una matriz de datos
attach(razas)
perrosmat<-as.matrix(cbind(x1, x2, x3, x4, x5, x6))

## gráfica de estrellas. Tomamos los datos respetando el encabezado

stars(perrosmat,labels= c("Thai","Dorado","Lobo Chino","Lobo Indio","Cuon","Dingo","Prehistorioco"))

### Para la cara de Chernoff necesitamos la librería aplpack 

install.packages('aplpack')
library(aplpack)
faces(perrosmat,labels=c("Thai","Dorado","Lobo Chino","Lobo Indio","Cuon","Dingo","Prehistorioco"))

## aplicación del método jerárquico con liga promedio "ave" por default lo hará con liga completa, usa distancia euclidiana

## dist es la función que calcula la distancia, por default usa la euclidiana. 
# dist(nombredelabase,method="manhattan") . En  method se puede usar euclidean , máximum, canberra


hc <- hclust(dist(perrosmat), "ave")

## grafica del dendograma 

plot(hc)


## esta función les ayudará a ver que grupos se armaron (haciendo doble clic con el botón en la gráfica les mostrará más de dos grupos)
## en nuestro ejemplo no lo podremos utilizar ya que son pocos datos
.
x <- identify(hc)


## ahora lo haremos por medio del método de k-means sólo tomaremos 3 grupos

clusterraza<-kmeans(perrosmat,3)

clusterraza

## ahora utilizaremos la función daisy() esta les ayuda a calcular la disimilaridad para cualquier tipo de dato

##  para algunas funciones requiere la librería “cluster” 

library(cluster)

hc <- hclust(daisy(perrosmat), "ave")

plot(hc)
