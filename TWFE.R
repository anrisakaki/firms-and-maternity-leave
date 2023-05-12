#############################
# DIFFERENCE-IN-DIFFERENCES #
#############################

dn12 <- dn12 %>% 
  rename(ma_thue1 = ma_thue) %>% 
  mutate(ma_thue2 = substr(ma_thue1, 10, 10),
         ma_thue = substr(ma_thue1, 1, 9))

fworkers_12 <- dn12 %>% 
  select(tinh, huyen, xa, madn, ma_thue1, fworkers) %>% 
  rename(fworkers_12 = fworkers)

for(i in dn0818){
  
  if(i %in% c("dn13", "dn14", "dn15")){
    
    assign(i, left_join(get(i), fworkers_12, by = c("tinh", "huyen", "xa", "madn", "ma_thue1"), multiple = "all"))
    
  }
  
}

dn1315 <- bind_rows(dn13, dn14, dn15) %>% 
  group_by(tinh, huyen, xa, madn, ma_thue1) %>% 
  mutate(id = cur_group_id()) %>% 
  mutate(post = ifelse(year > 2013, 1, 0),
         did = post*fworkers_12)

etable(list(
  feols(fworkers ~ fworkers_12 + post + did | id,
        dn1315),
  feols(fworkers_eoy ~ fworkers_12 + post + did | id,
        dn1215),
  feols(finformal ~ fworkers_12 + post + did | id,
        dn1315),
  feols(pretax_profit ~ fworkers_12 + post + did | id,
        dn1315)  
), tex = T)

