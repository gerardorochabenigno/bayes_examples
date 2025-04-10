# Numerical optimization and integration to summarize the posterior
library(cubature)

# data
Y <- c(2.68,1.18,-0.97,-1.03)

# Evaluate the density on the grid for plotting
m     <- 50
mu    <- seq(-4,6, ,length=m)
sigma <- seq(0,10, ,length=m)
theta <- as.matrix(expand.grid(mu,sigma)) # matriz de combinaciones de parámetros
D     <- dnorm(theta[,1], 0,100)*dunif(theta[,2],0,10) # prior (m*m valores). La 

for (i in 1:length(m)){
  D <- D*dnorm(Y[i], theta[,1], theta[,2])
}

W <- matrix(D/sum(D),m,m)

# MAP estimation
# Función a maximizar
neg_log_post <- function(theta, Y){
  log_like <- sum(dnorm(Y,theta[1],theta[2], log=TRUE))
  log_prior <- dnorm(theta[1], 0, 100, log = TRUE) + dunif(theta[2],0,10,log = TRUE)
  
  return (-log_like - log_prior)
}

# inits para usar en optim
inits <- c(mean(Y), sd(Y))

# Parametros de la optimización
MAP <- optim(inits, neg_log_post, Y=Y,
             method= "L-BFGS-B",
             lower = c(-Inf,0), upper = c(Inf,10))$par

# Compute the posterior mean (MAP computes the mode)
post <- function(theta, Y){
  like <- prod(dnorm(Y, theta[1], theta[2]))
  prior <- dnorm(theta[1], 0, 100) * dunif(theta[2],0,10)
  return(like*prior)
}

g0 <- function(theta, Y){post(theta,Y)}
g1 <- function(theta, Y){theta[1]*post(theta,Y)}
g2 <- function(theta, Y){theta[2]*post(theta,Y)}
m0 <- adaptIntegrate(g0,c(-5,0.01),c(5,5),Y=Y)$int
m1 <- adaptIntegrate(g1,c(-5,0.01),c(5,5),Y=Y)$int
m2 <- adaptIntegrate(g2,c(-5,0.01),c(5,5),Y=Y)$int
pm <- c(m1,m2)/m0

# Gráfica
image(mu,sigma,W,col=gray.colors(10,1,0),
       xlab=expression(mu),ylab=expression(sigma))
points(theta,cex=0.1,pch=19)
points(pm[1],pm[2],pch=19,cex=1.5)
points(MAP[1],MAP[2],col="white",cex=1.5,pch=19)
box()

