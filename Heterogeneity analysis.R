########
# SIZE #
########

iplot(list(
  feols(log(n_workers) ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Microenterprise")),
  feols(log(n_workers) ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Small")),        
  feols(log(n_workers) ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Medium")),    
  feols(log(n_workers) ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Large"))))
legend(x = "bottomleft", col = 1:4, pch = 1, lwd = 2, cex = 1, bty = "n", 
       legend = c("Microenterprise", "Small", "Medium", "Large"))

iplot(list(
  feols(fworkers_eoy ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Microenterprise")),
  feols(fworkers_eoy ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Small")),        
  feols(fworkers_eoy ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Medium")),    
  feols(fworkers_eoy ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Large"))))
legend(x = "bottomleft", col = 1:4, pch = 1, lwd = 2, cex = 1, bty = "n", 
       legend = c("Microenterprise", "Small", "Medium", "Large"))

iplot(list(
  feols(log(n_informal) ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Microenterprise")),
  feols(log(n_informal) ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Small")),        
  feols(log(n_informal) ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Medium")),    
  feols(log(n_informal) ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Large"))))
legend(x = "bottomleft", col = 1:4, pch = 1, lwd = 2, cex = 1, bty = "n", 
       legend = c("Microenterprise", "Small", "Medium", "Large"))

iplot(list(
  feols(f_ss ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Microenterprise")),
  feols(f_ss ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Small")),        
  feols(f_ss ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Medium")),    
  feols(f_ss ~ fworkers_12 + post + i(as.factor(post), fworkers_12, 0) | id, 
        subset(dn1218, year < 2016 & size == "Large"))))
legend(x = "bottomleft", col = 1:4, pch = 1, lwd = 2, cex = 1, bty = "n", 
       legend = c("Microenterprise", "Small", "Medium", "Large"))
