
data(iris)
head(iris)

## Base de datos la trae R, solo hay que “llamarla” son una muestra de 3 especies de iris y 4 variables 

## gráficos de dispersión para revisar que estén correlacionados los datos y distinguir cada especie
pairs(iris[,1:4],col=as.numeric(iris$Species) ) 
iris


###observar las varianzas  y las correlaciones más grandes
cor(iris[,1:4])
var( iris[,1:4])


## con esta instrucción generan los componentes, lo primero que muestra son los “lamdas”, los valores propios
princomp(iris[,1:4])


### princomp(iris[,1:4],cor=T) 
##  en caso de tener que usar la matriz de correlación. Se usa la matriz de correlación cuando las magnitudes de la variables son diferentes, por ejemplo una variable puede manejar por centajes y la otra puede ser el tamaño de población, lo pueden observer cuando tenemos valores de covarianza muy “grandes”
# tabla de análisis arrojado por R. Ahí viene la proporción de varianza explicada
summary(princomp(iris[,1:4]))


# la siguiente instrucción da el “peso” que tiene cada variable en cada componente 
prcomp(iris[,1:4])


# la siguiente instrucción es para ver gráficamente cada valor propio (revisen para que les sirve)
screeplot(princomp(iris[,1:4]))


# a continuación se muestra la transformación que se obtiene de los datos originales al aplicarlos en los componentes (nuevas variables) en este caso solo se muestra el componente uno y dos
princomp(iris[,1:4])$scores[,1:2]


#En la siguiente grafica lo que se está haciendo es graficar los valores anteriores. Los valores de 1,2 y 3, es la especie de iris correspondiente, esta grafica sirve para ver outlier, grupos y la relación con los componentes que tiene cada “individuo”
plot(princomp(iris[,1:4])$scores[,1:2],type="n")
text(princomp(iris[,1:4])$scores[,1:2],labels=as.numeric(iris$Species),col=as.numeric(iris$Species))
