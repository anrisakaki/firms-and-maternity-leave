########################
# DESCRIPTIVE EVIDENCE #
########################

# Distribution of female intensiveness of firms 

ggplot(fworkers_12, aes(fworkers_12)) + geom_density()

quantile(fworkers_12$fworkers_12, probs = c(0.25, 0.5, 0.75), na.rm = T)
 

# Q1 = 0.2452830
# Q2 = 0.3333333
# Q3 = 0.4761905

dn1315 <- dn1315 %>% 
  mutate(q1 = ifelse(fworkers_12 <= 0.2452830, 1, 0),
         q2 = ifelse(fworkers_12 >= 0.3333333 & fworkers_12 <0.4761905, 1, 0),
         q2 = ifelse(fworkers_12 >= 0.3333333 & fworkers_12 <0.4761905, 1, 0))

dn1315_fintensity <- dn1315 %>% 
  distinct() %>% 
  select(id, year, fworkers, fworkers_12) %>% 
  pivot_wider(names_from = year, values_from = fworkers, values_fn = mean) %>% 
  rename(y2013 = 8,
         y2014 = 9,
         y2015 = 10) %>% 
  filter(!is.na(fworkers_12))

