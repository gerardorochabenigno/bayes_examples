# Ejemplo de contusiones en la NFL
rm(list=ls())
library(tidyverse)
library(ggplot2)
Y1 <- 171
Y2 <- 152
Y3 <- 123
Y4 <- 199

a <- 0.1
b <- 0.1
n <- 256

datos <- tibble(c2012 = rgamma(10000,Y1+a,n+b),
                c2013 = rgamma(10000,Y2+a,n+b),
                c2014 = rgamma(10000,Y3+a,n+b),
                c2015 = rgamma(10000,Y4+a,n+b)) 

ggplot(datos, aes(x=c2012)) +
  geom_density(colour='grey') +
  geom_density(aes(x=c2013),colour='blue') +
  geom_density(aes(x=c2014),colour='red') +
  geom_density(aes(x=c2015),colour='brown')

  