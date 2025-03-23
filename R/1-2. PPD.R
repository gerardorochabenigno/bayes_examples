# Resumen de una predictiva posterior
rm(list=ls())
n <- 5
Y <- 1
a <- 1
b <- 1
A <- Y+a
B <- n-Y+b


# Estimador plug-in
theta_hat <- A/(A+B)
y <- 0:5
PPD <- dbinom(y,n,theta_hat)
names(PPD) <- y
round(PPD,2)

# Drwas de la PPD
S <- 100000
theta_star <- rbeta(S,A,B)
Y_star <- rbinom(S,n,theta_star)
PPD <- table(Y_star)/S
round(PPD,2)