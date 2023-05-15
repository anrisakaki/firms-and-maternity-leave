#############################
# DIFFERENCE-IN-DIFFERENCES #
#############################

fworkers_12 <- dn12 %>% 
  select(tinh, huyen, xa, madn, ma_thue, fworkers) %>% 
  rename(fworkers_12 = fworkers)

for(i in dn0818){
  
  if(i %in% c("dn13", "dn14", "dn15")){
    
    assign(i, left_join(get(i), fworkers_12, by = c("tinh", "huyen", "xa", "madn", "ma_thue"), multiple = "all"))
    
  }
  
}

dn1315 <- bind_rows(dn13, dn14, dn15) %>% 
  group_by(tinh, huyen, xa, madn, ma_thue) %>% 
  mutate(id = cur_group_id()) %>% 
  mutate(post = ifelse(year > 2013, 1, 0),
         did = post*fworkers_12)

etable(list(
  feols(fworkers ~ fworkers_12 + post + did | id,
        dn1315),
  feols(fworkers_eoy ~ fworkers_12 + post + did | id,
        dn1315),
  feols(finformal ~ fworkers_12 + post + did | id,
        dn1315),
  feols(pretax_profit ~ fworkers_12 + post + did | id,
        dn1315)  
), tex = T)

###############
# EVENT STUDY #
###############

for(i in dn0818){
  
  if(i %in% c("dn08", "dn09", "dn10", "dn11")){
    
    assign(i, left_join(get(i), fworkers_12, by = c("tinh", "huyen", "xa", "madn", "ma_thue"), multiple = "all"))
    
  }
  
}

dn12 <- dn12 %>% mutate(fworkers_12 = fworkers)

dn0815 <- bind_rows(dn08, dn09, dn10, dn11, dn12, dn13, dn14, dn15) %>% 
  group_by(tinh, huyen, xa, madn, ma_thue) %>% 
  mutate(id = cur_group_id())

iplot(feols(fworkers ~ i(year, fworkers_12, 2012) | id + year,
            dn0815,
            vcov = ~id), main = "")

iplot(feols(fworkers_eoy ~ i(year, fworkers_12, 2012) | id + year,
            dn0815,
            vcov = ~id), main = "")

iplot(feols(finformal ~ i(year, fworkers_12, 2012) | id + year,
            dn0815,
            vcov = ~id), main = "")

iplot(feols(pretax_profit ~ i(year, fworkers_12, 2012) | id + year,
            dn0815,
            vcov = ~id), main = "")
