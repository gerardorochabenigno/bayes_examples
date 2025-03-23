# Ejemplo de regresión líneal con prior normal para la media
# con datos simulados
rm(list=ls())
library(R2jags)

set.seed(42)

# Número de observaciones
n <- 1000

# Covariables
X1 <- rnorm(n, mean = 10, sd = 5)
X2 <- rnorm(n, mean = 20, sd = 10)
X3 <- rnorm(n, mean = 30, sd = 15)
X <- matrix(data =c(X1,X2,X3), nrow=n, ncol=3)

# Generar la variable dependiente con ruido
epsilon <- rnorm(n, mean = 0, sd = 3)  # Ruido
# Coeficientes de la regresión
beta_0 <- 5  # Intercepto
beta_1 <- 2.5
beta_2 <- -1.2
beta_3 <- 0.8
Y <- beta_0 + beta_1 * X1 + beta_2 * X2 + beta_3 * X3 + epsilon

# Crear un data frame
df <- data.frame(X1, X2, X3, Y)

# datos
data <- list("n" = n, "X"=X, "Y"=Y, "p"=3)

# Valores iniciales
inits <- function(){
  list("beta"=rep(0.1,3), 
       "taue"=0.01,
       "taub"=0.01)
}

# Parametros a monitorear
params <- c("beta", "taue", "taub")

# Corremos el modelo
modelo <- jags(data = data, inits = inits, model.file = "./jags/4-1.txt",
               n.iter = 10000, n.chain=2, n.burnin = 1000, n.thin=1, 
               parameters.to.save = params)
