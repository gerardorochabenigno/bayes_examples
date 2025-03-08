# Resumen de una posterior univariada

# Cargamos los datos
rm(list=ls())
library(ggplot2)
library(tidyverse)
n <- 100
Y <- 40
a <- 1
b <- 1
A <- Y + a
B <- n- Y + b

# Creamos un grid de puntos para gráficar
theta <- seq(0,1,.001)

# Evalua la densidad en estos puntos
pdf <- tibble(theta = theta,
              densidad=dbeta(theta, A, B))

# Gráficamos la posterior
ggplot(pdf, aes(x=theta, y = densidad)) + 
  geom_line() + 
  theme_minimal() + 
  labs(x=expression(theta))

# Media posterior
print(A/(A+B))

# Mediana posterior
print(qbeta(0.5,A,B))

# Probabilidad posterior P(theta < 0.45 | Y)
pbeta(0.45, A, B)

# Intervalos de credibilidad del 95%
qbeta(c(0.025,0.975),A,B)

# Aproximación de Monte Carlo
S <- 100000
samples <- rbeta(S,A,B)
mean(samples)
median(samples)
quantile(samples, c(0.025,0.975))