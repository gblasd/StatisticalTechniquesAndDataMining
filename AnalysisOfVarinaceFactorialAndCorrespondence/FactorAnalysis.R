v1 <- c(1,1,1,1,1,1,1,1,1,1,3,3,3,3,3,4,5,6)
v2 <- c(1,2,1,1,1,1,2,1,2,1,3,4,3,3,3,4,6,5)
v3 <- c(3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,5,4,6)
v4 <- c(3,3,4,3,3,1,1,2,1,1,1,1,2,1,1,5,6,4)
v5 <- c(1,1,1,1,1,3,3,3,3,3,1,1,1,1,1,6,4,5)
v6 <- c(1,1,1,2,1,3,3,3,4,3,1,1,1,2,1,6,5,4)
m1 <- cbind(v1,v2,v3,v4,v5,v6)
#Así queda nuestra base
m1



par(mfrow=c(2,2))
matplot(m1[,1:2],col=c(1,1),type="b")
matplot(m1[,3:4],col=c(2,2),type="b")
matplot(m1[,5:6],col=c(3,3),type="b")
matplot(m1,type="b",col=c(1,1,2,2,3,3))
par(mfrow=c(1,1))

cor(m1)

# install.packages("corrplot")
library(corrplot)
corrplot.mixed(cor(m1),
               lower = "number", 
               upper = "circle",
               tl.col = "black")


# Requerimos la librería psych
# la rotacion puede ser "none", "varimax", "quatimax", "promax", "oblimin", "simplimax", or "cluster"
library(psych)
install.packages("psych")

fa(m1,nfactors=3,fm="pa",rotate="none",max.iter=100)

# Con Varimax
fa(m1,nfactors=3,fm="pa",rotate="varimax")

# con rotación Promax
fa(m1,nfactors=3,fm="pa",rotate="promax")

# Para ver solo las “cargas de cada factor
fa(m1,nfactors=3,fm="pa",rotate="promax")$load

# grafiquemos el peso de los dos primeros factores

x<-fa(m1,nfactors=3,fm="pa",rotate="promax")
x
plot(x$load[,1:2], col="white")
text(x$load[,1:2], labels = row.names(x$loadings[,1:2]))

# Utilizando máxima verosimilitud aún sabiendo el problema de normalidad y con rotación Promax
fa(m1,nfactors=3,fm="ml",rotate="promax")

# Scores utilizando regresión y con rotación Promax
fa(m1,nfactors=3,fm="pa",rotate="promax",scores="regression")$scores

# Scores utilizando Bartlett y con rotación Promax
fa(m1,nfactors=3,fm="pa",rotate="promax",scores="Bartlett")$scores
