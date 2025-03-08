# Ejemplo beta-binomial
rm(list = ls())
library(ggplot2)
library(ggExtra)

# Generar datos
set.seed(123)
theta <- rbeta(2000, 8, 2)
y <- rbinom(2000, 20, theta)

# Crear un dataframe
df <- data.frame(theta = theta, y = y)

# Graficar con geom_bin2d para densidad de puntos
p <- ggplot(df, aes(x = theta, y = y)) +
  geom_point(color='white') +
  geom_bin2d(bins = 25) +
  scale_fill_gradient(low = "white", high = "black") +
  labs(x=expression(theta)) +
  theme_minimal()

# Agregar distribuciones marginales
p_marginal <- ggMarginal(p, type = "density", fill = "gray")

# Mostrar el gráfico
print(p_marginal)