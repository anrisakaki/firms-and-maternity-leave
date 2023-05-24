############################################
# SETTING UP FOR DIFFERENCE-IN-DIFFERENCES #
############################################

fworkers_12 <- dn12 %>% 
  select(tinh, huyen, xa, madn, ma_thue, fworkers) %>% 
  rename(fworkers_12 = fworkers)

for(i in dn0818){
  
  if(i %in% c("dn13", "dn14", "dn15")){
    
    assign(i, left_join(get(i), fworkers_12, by = c("tinh", "huyen", "xa", "madn", "ma_thue"), multiple = "all"))
    
  }
  
  if(i %in% c("dn16", "dn17", "dn18")){
    
    assign(i, left_join(get(i), fworkers_12, by = c("tinh", "huyen", "xa", "ma_thue"), multiple = "all"))
    
  }  
  
}

dn1315 <- bind_rows(dn13, dn14, dn15, dn16, dn17, dn18) %>% 
  group_by(tinh, huyen, xa, ma_thue) %>% 
  mutate(id = cur_group_id()) %>% 
  mutate(post = ifelse(year > 2013, 1, 0),
         did = post*fworkers_12)

duplicates <- dn1315 %>% dplyr::group_by(tinh, huyen, xa, madn, ma_thue, id, fworkers_12, year) %>%
  dplyr::summarise(n = dplyr::n(), .groups = "drop") %>%
  dplyr::filter(n > 1L) 

########################
# DESCRIPTIVE EVIDENCE #
########################

dn1315_fintensity <- dn1315 %>% 
  distinct() %>% 
  select(id, year, fworkers, fworkers_12) %>% 
  pivot_wider(names_from = year, values_from = fworkers, values_fn = mean) %>% 
  rename(y2013 = 8,
         y2014 = 9,
         y2015 = 10) %>% 
  filter(!is.na(fworkers_12))