# Concentración de alcohol en la sangre
# El límite legal es 0.08
rm(list=ls())
library(tidyverse)
library(ggplot2)

sigma <- 0.01
Y <- 0.082 # Nivel de alcohol, más alto que el permitido
n <- length(Y) # Tamaño de la muestra
m <- 0.25 # Fuerza
theta <- 0.05 # Prior
var_prior <- (sigma*sigma)/m
w <- n/(n+m)
mu_posterior <- w*mean(Y) + (1-w)*theta
var_posterior <- (sigma*sigma)/(n+m)

# Verosimilitud Y ~ N(mu, 0.01)

# Yo me eché dos tragos y creo que esta es la distribución de la media de alguien que se echa dos chelas es.
# Prior mu ~ N(0.05, 0.02^2) 

# Probabilidad priori de que el alcohol exceda 0.05.
round(1 - pnorm(0.08, theta, sqrt(var_prior), lower.tail = TRUE),4)

# Gráficamos la prior y la posterior
datos <- tibble(prior = rnorm(10000,theta, sqrt(var_prior)),
                posterior = rnorm(10000,mu_posterior, sqrt(var_posterior)))

ggplot(datos, aes(x=prior)) + 
  geom_density(aes(x=prior), color ='blue') +
  geom_density(aes(x=posterior), color ='firebrick') + 
  scale_x_continuous(limits = c(0, 0.1))
  
# Probabilidad posterior de que el alcohol exceda 0.05.
round(1 - pnorm(0.08, mu_posterior, sqrt(var_posterior), lower.tail = TRUE),4)
