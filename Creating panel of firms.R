#############################
# CREATING A PANEL OF FIRMS #
#############################

for(i in dn0818){
  
  if(i %in% c("dn08", "dn09", "dn10", "dn12")){
    
    assign(i, get(i) %>% 
             group_by(tinh, madn, ma_thue, namsxkd) %>% 
             mutate(id1 = cur_group_id()) %>% 
             group_by(tinh, madn, ma_thue) %>%
             mutate(id2 = cur_group_id()) %>% 
             group_by(tinh, ma_thue) %>% 
             mutate(id3 = cur_group_id()) %>% 
             group_by(tinh, ma_thue, namsxkd) %>% 
             mutate(id4 = cur_group_id())
           )
  }
  
  if(i %in% c("dn11", "dn13", "dn14", "dn15")){
    
    assign(i, get(i) %>% 
             group_by(tinh, madn, ma_thue) %>% 
             mutate(id2 = cur_group_id()) %>% 
             group_by(tinh, ma_thue) %>% 
             mutate(id3 = cur_group_id()))
  }  
  
  if(i %in% c("dn16")){
    
    assign(i, get(i) %>% 
             group_by(tinh, ma_thue) %>% 
             mutate(id3 = cur_group_id()))
  }  
  
  if(i %in% c("dn17", "dn18")){
    
    assign(i, get(i) %>% 
             group_by(tinh, ma_thue, namsxkd) %>% 
             mutate(id4 = cur_group_id()) %>% 
             group_by(tinh, ma_thue) %>% 
             mutate(id3 = cur_group_id()))
  }
}

id08 <- dn08
id09 <- dn09
id10 <- dn10
id11 <- dn11
id12 <- dn12
id13 <- dn13
id14 <- dn14
id15 <- dn15
id16 <- dn16
id17 <- dn17
id18 <- dn18

id <- c("id08", "id09", "id10", "id11", "id12", "id13", "id14", "id15", "id16", "id17", "id18")

for(i in id){
  
  if(i %in% c("id08", "id09", "id10", "id12")){
    
    assign(i, get(i) %>% 
             select(tinh, huyen, xa, madn, ma_thue, namsxkd, id1, id2, id3, id4))
    
  }
  
  if(i %in% c("id11","id13", "id14", "id15")){
    
    assign(i, get(i) %>% 
             select(tinh, huyen, xa, madn, ma_thue, id2, id3))
    
  }    
  
  if(i %in% c("id17", "id18")){
    
    assign(i, get(i) %>% 
             select(tinh, huyen, xa, ma_thue, namsxkd, id4, id3))
    
  }  
  
  if(i %in% c("id16")){
    
    assign(i, get(i) %>% 
             select(tinh, huyen, xa, ma_thue, id3))
    
  }   
}

# getting namsxkd for 2011 dataset using 2012 dataset 

