####################################
# Creating a panel for 2012 - 2018 #
####################################

id12 <- dn12 %>% 
  select(tinh, huyen, xa, ma_thue, madn, namsxkd) %>% 
  rename(ma_thue1 = ma_thue)
id18 <- dn18 %>% 
  select(tinh, huyen, xa, ma_thue1, namsxkd)

id1218 <- merge(id12, id18, by = "ma_thue1") %>% 
  mutate(correct_tinh = ifelse(tinh.x == tinh.y, 1, 0),
         correct_huyen = ifelse(huyen.x == huyen.y, 1, 0),
         correct_xa = ifelse(xa.x == xa.y, 1, 0),
         correct_namsxkd = ifelse(namsxkd.x == namsxkd.y, 1, 0),
         correct_thx = ifelse((correct_tinh + correct_huyen + correct_xa + correct_namsxkd) == 4, 1, 0))

id1218_correct <- id1218 %>% filter(correct_thx == 1) %>% 
  distinct() %>% 
  select(tinh.x, huyen.x, xa.x, ma_thue1) %>% 
  rename(tinh = tinh.x,
         huyen = huyen.x,
         xa = xa.x) %>% 
  group_by(tinh, huyen, ma_thue1) %>% 
  mutate(id = cur_group_id()) 

# filtering based on observations with correct geographical indicators 
id1218_incorrect <- id1218 %>%
  filter(correct_thx == 0) %>% 
  mutate(correct_tinh = ifelse(tinh.x == tinh.y, 1, 0),
         correct_huyen = ifelse(huyen.x == huyen.y, 1, 0),
         correct_xa = ifelse(xa.x == xa.y, 1, 0),
         correct_namsxkd = ifelse(namsxkd.x == namsxkd.y, 1, 0),
         correct_thx = ifelse((correct_tinh + correct_huyen + correct_xa) == 3, 1, 0))  %>% 
  filter(correct_thx == 1) %>% 
  distinct()

# Conclude that individual panels should be made using 'tinh, huyen, xa, ma_thue' 

####################################
# Creating a panel for 2008 - 2018 #
####################################

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
panel0815_incorrect <- panel0815 %>% filter(correct_thx == 0) # most incorrect matches are at the huyen and xa level. 

# create unique id based on tinh, ma_thue, madn

panel0815_id <- panel0815 %>% 
  select(tinh.x, madn, ma_thue.x) %>% 
  rename(tinh = tinh.x,
         ma_thue = ma_thue.x) %>% 
  group_by(tinh, madn, ma_thue) %>% 
  mutate(id = cur_group_id()) %>% 
  distinct()

for(i in dn0818){
  
  if(i %in% c("dn08", "dn09", "dn10", "dn11", "dn12", "dn13", "dn14", "dn15"))
  
  assign(i, get(i) %>% 
           group_by(tinh, madn, ma_thue) %>% 
           mutate(id = cur_group_id()))
}
