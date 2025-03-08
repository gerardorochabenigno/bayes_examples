# Muestreador de Gibbs para un modelo Gaussiano con media y varianza desconocida

# Cargamos los datos
Y = c(2.68, 1.18, -0.97, 90.98, -1.03)
n <- length(Y)

# Creamos una matriz vacía para las muestras MCMC
S <- 25000
samples <- matrix(NA, S,2) # 25k filas, 2 columnas
colnames(samples) <- c("mu", "sigma")

# Valores iniciales
mu <- mean(Y)
sig2 <- var(Y)

# Priors: mu ~ N(gamma, tau), sig2 ~InvGamma(a,b)
gamma <- 0 # Media cero
tau <- 100^2 # Varianza alta
a <- 0.1
b <- 0.1

# Muestreador de Gibbs
for(s in 1:S){
  
  P <- n/sig2 + 1/tau # Precisión
  M <- sum(Y)/sig2 + gamma/tau # Media
  mu <- rnorm(1,M/P,1/sqrt(P))
  
  A <- n/2 + a
  B <- sum((Y-mu)^2)/2 + b
  sig2 <- 1/rgamma(1, A, B)
  
  samples[s,] <- c(mu, sqrt(sig2))
}

# Gráficamos la conjunta y marginal de mu
plot(samples, xlab=expression(mu), ylab=expression(sigma))

# Media posterior
apply(samples,2,mean)

# Mediana e intervalos creíbles
apply(samples,2,quantile,c(0.025,0.500,0.975))

