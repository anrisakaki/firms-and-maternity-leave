#############################
# CREATING A PANEL OF FIRMS #
#############################

for(i in dn0818){
  
  if(i %in% c("dn08", "dn09", "dn10", "dn12")){
    
    assign(i, get(i) %>% 
             group_by(madn, ma_thue, namsxkd, lhdn, tinh,  huyen, xa) %>% 
             distinct() # dropping non unique observations 
    )    
  }

  if(i %in% c("dn11", "dn13", "dn14", "dn15")){
    
    assign(i, get(i) %>% 
             group_by(madn, ma_thue, lhdn, tinh,  huyen, xa) %>% 
             distinct() # dropping non unique observations 
    )    
  }    
  
  if(i %in% c("dn16")){
    
    assign(i, get(i) %>% 
             group_by(ma_thue, lhdn, tinh,  huyen, xa) %>% 
             distinct() # dropping non unique observations 
    )    
  }
  
  if(i %in% c("dn17", "dn18")){
    
    assign(i, get(i) %>% 
             group_by(ma_thue, namsxkd, lhdn, tinh,  huyen, xa) %>% 
             distinct() # dropping non unique observations 
    )    
    
  }
  
}

dn <- dn %>% 
  group_by(tinh, huyen, xa, ma_thue, lhdn) %>%
  mutate(id = cur_group_id())

test <- dn %>% 
  filter(ma_thue == "0100101403")
