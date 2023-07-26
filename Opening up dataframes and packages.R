setwd("C:/Users/Anri Sakakibara/OneDrive/PhD Political Economy/Maternity Leave")
library(tidyverse)
library(haven)
library(sf)
library(fixest)

rm(list=ls()) 

dn <- list.files(pattern = "dn(.*)dta$")
dn <- lapply(dn, read_dta)

dn08 <- dn[[1]]
dn09 <- dn[[2]]
dn10 <- dn[[3]]
dn11 <- dn[[4]]
dn12 <- dn[[5]]
dn13 <- dn[[6]]
dn14 <- dn[[7]]
dn15 <- dn[[8]]
dn16 <- dn[[9]]
dn17 <- dn[[10]]
dn18 <- dn[[11]]
