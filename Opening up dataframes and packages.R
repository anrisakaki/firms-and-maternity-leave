setwd("C:/Users/Anri Sakakibara/OneDrive/PhD Political Economy/Maternity Leave")
library(tidyverse)
library(haven)
library(sf)
library(fixest)

rm(list=ls()) 

dn <- list.files(pattern = "dn(.*)dta$")
dn <- lapply(dn, read_dta)

dn01 <- dn[[1]]
dn02 <- dn[[2]]
dn03 <- dn[[3]]
dn04 <- dn[[4]]
dn05 <- dn[[5]]
dn06 <- dn[[6]]
dn07 <- dn[[7]]
dn08 <- dn[[8]]
dn09 <- dn[[9]]
dn10 <- dn[[10]]
dn11 <- dn[[11]]
dn12 <- dn[[12]]
dn13 <- dn[[13]]
dn14 <- dn[[14]]
dn15 <- dn[[15]]
dn16 <- dn[[16]]
dn17 <- dn[[17]]
dn18 <- dn[[18]]
