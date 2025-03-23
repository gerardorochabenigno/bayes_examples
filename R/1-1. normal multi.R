rm(list=ls())
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggExtra)

# Datos observados
Y <- c(2.68, 1.18, -0.97, -0.98, -1.03)
n <- length(Y)

# Rango de valores para mu y sigma
mu <- seq(-10,10,0.1)
sigma <- seq(0.1,10,0.1)


datos <- tibble(expand.grid(mu,sigma)) |>
  rename(mu=Var1, sigma=Var2) |>
  rowwise() |>
  mutate(num=prod(dnorm(Y,mu, sigma))*dnorm(mu, 0,100)*dunif(sigma,0.1,10)
         ) |>
  ungroup()

dem <- sum(datos$num)
datos <- datos |> 
  mutate(posterior = num/dem)

datos$posterior <- as.numeric(datos$posterior)

ggplot(datos, aes(x = mu, y = sigma, z = posterior)) +
  geom_contour_filled() +
  theme_minimal() +
  labs(x = expression(mu), y = expression(sigma))

