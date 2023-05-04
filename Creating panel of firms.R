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

id1112_madn <- left_join(id12, id11, by = "madn", multiple = "all") %>% 
  mutate(correct_tinh = ifelse(tinh.x == tinh.y, 1, 0),
         correct_huyen = ifelse(huyen.x == huyen.y, 1, 0),
         correct_xa = ifelse(xa.x == xa.y, 1, 0),
         correct_ma_thue = ifelse(ma_thue.x == ma_thue.y, 1, 0),
         correct_thx = ifelse((correct_tinh + correct_huyen + correct_xa) == 3, 1, 0)) %>% 
  filter(namsxkd != "NA")

namsxkd_11 <- id1112_madn %>% select(tinh.x, huyen.x, xa.x, madn, namsxkd) %>% 
  rename(tinh = tinh.x,
         huyen = huyen.x,
         xa = xa.x)

dn11 <- left_join(dn11, namsxkd_11, by = c("tinh", "huyen", "xa", "madn"), multiple = "all")

# Only retaining observations kept between 2008 and 2018 

panel15 <- dn15 %>% select(tinh, huyen, xa, lhdn, ma_thue, ma_thue1, ma_thue2, madn)
panel08 <- dn08 %>% select(tinh, huyen, xa, lhdn, namsxkd, ma_thue, madn)

panel0815 <- merge(panel15, panel08, by = "madn") %>% 
  mutate(correct_tinh = ifelse(tinh.x == tinh.y, 1, 0),
         correct_huyen = ifelse(huyen.x == huyen.y, 1, 0),
         correct_xa = ifelse(xa.x == xa.y, 1, 0),
         correct_ma_thue = ifelse(ma_thue.x == ma_thue.y, 1, 0),
         correct_thx = ifelse((correct_tinh + correct_huyen + correct_xa + correct_ma_thue) == 4, 1, 0))  

panel0815_correct <- panel0815 %>% filter(correct_thx == 1)
panel0815_incorrect <- panel0815 %>% filter(correct_thx == 0)
