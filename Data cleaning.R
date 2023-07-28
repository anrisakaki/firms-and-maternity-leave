dn08 <- dn08 %>% 
  rename(vsic = nganh_kd,
         n_workers = ld11,
         n_fworkers = ld12,
         n_workers_eoy = ld13,
         n_fworkers_eoy = ld14,
         n_workers_ss = ld23,
         n_fworkers_ss = ld24,
         n_informal = ld33,
         n_finformal = ld34,         
         wage = tn1,
         ss_comp = tn3,
         ss_cont = tn5,
         pretax_profit = kqkd9)

dn09 <- dn09 %>% 
  rename(vsic = nganh_kd,
         n_workers = ld11,
         n_fworkers = ld12,
         n_workers_eoy = ld13,
         n_fworkers_eoy = ld14,
         n_workers_ss = ld23,
         n_fworkers_ss = ld24,
         n_informal = ld33,
         n_finformal = ld34,         
         wage = tn11,
         ss_comp = tn31,
         ss_cont = tn91,
         pretax_profit = kqkd17)

dn10 <- dn10 %>% 
  rename(vsic = nganh_kd,
         n_workers = ld11,
         n_fworkers = ld12,
         n_workers_eoy = ld13,
         n_fworkers_eoy = ld14,
         n_workers_ss = ld23,
         n_fworkers_ss = ld24,
         n_informal = ld33,
         n_finformal = ld34,         
         wage = tn1,
         ss_comp = tn3,
         ss_cont = tn5,
         pretax_profit = kqkd17)

dn11 <- dn11 %>% 
  rename(vsic = nganh_kd,
         n_workers = tsld,
         n_fworkers = tsldnu,
         n_workers_eoy = ld11,
         n_fworkers_eoy = ld12,
         n_workers_ss = ld21,
         n_fworkers_ss = ld22,
         n_informal = ld31,
         n_finformal = ld32,
         wage = tn1,
         ss_comp = tn4,
         ss_cont = tn5,
         pretax_profit = kqkd20)

dn12 <- dn12 %>% 
  rename(vsic = nganh_kd,
         n_workers = tsld,
         n_fworkers = tsldnu,
         n_workers_eoy = ld11,
         n_fworkers_eoy = ld12,
         n_workers_ss = ld21,
         n_fworkers_ss = ld22,
         n_informal = ld31,
         n_finformal = ld32,
         wage = tn1,
         ss_comp = tn4,
         ss_cont = tn5,
         pretax_profit = kqkd22)  

dn13 <- dn13 %>% 
  rename(vsic = nganh_kd,
         n_workers = tsld,
         n_fworkers = tsldnu,
         n_workers_eoy = ld11,
         n_fworkers_eoy = ld12,
         n_workers_ss = ld21,
         n_fworkers_ss = ld22,
         n_informal = ld31,
         n_finformal = ld32,
         wage = tn1,
         ss_comp = tn4,
         ss_cont = tn5,
         pretax_profit = kqkd22)  

dn14 <- dn14 %>% 
  rename(vsic = nganh_kd,
         n_workers = tsld,
         n_fworkers = tsldnu,
         n_workers_eoy = ld11,
         n_fworkers_eoy = ld12,
         n_workers_ss = ld21,
         n_fworkers_ss = ld22,
         n_informal = ld31,
         n_finformal = ld32,
         wage = tn1,
         ss_comp = tn2,
         ss_cont = tn3,
         pretax_profit = kqkd22) 

dn15 <- dn15 %>% 
  rename(vsic = nganh_kd,
         n_workers = tsld,
         n_fworkers = tsldnu,
         n_workers_eoy = ld11,
         n_fworkers_eoy = ld12,
         n_workers_ss = ld21,
         n_fworkers_ss = ld22,
         n_informal = ld31,
         n_finformal = ld32,
         wage = tn1,
         ss_comp = tn2,
         ss_cont = tn3,         
         pretax_profit = kqkd20)   

dn16 <- dn16 %>% 
  rename(vsic = nganh_kd,
         n_workers = tsld,
         n_fworkers = tsldnu,
         n_workers_eoy = ld11,
         n_fworkers_eoy = ld21,
         n_workers_ss = ld31,
         n_informal = ld41,
         wage = tn1,
         ss_comp = tn2,
         ss_cont = tn3,         
         pretax_profit = kqkd20)   

dn17 <- dn17 %>% 
  rename(vsic = nganh_kd,
         n_workers = tsld,
         n_fworkers = tsldnu,
         n_workers_eoy = ld11,
         n_fworkers_eoy = ld21,
         n_workers_ss = ld31,
         n_informal = ld41,
         wage = tn1,
         ss_comp = tn2,
         ss_cont = tn3,         
         pretax_profit = kqkd7)   

dn18 <- dn18 %>% 
  rename(vsic = nganh_kd,
         n_workers = tsld,
         n_fworkers = tsldnu,
         n_workers_eoy = ld11,
         n_fworkers_eoy = ld21,
         n_workers_ss = ld31,
         n_informal = ld41,
         wage = tn1,
         ss_comp = tn2,
         ss_cont = tn3,         
         pretax_profit = kqkd7)

dn0818 <- c("dn08", "dn09", "dn10", "dn11", "dn12", "dn13", "dn14", "dn15", "dn16", "dn17", "dn18")

for(i in dn0818){

  assign(i, get(i) %>%
           mutate(
                  n_fworkers = ifelse(is.na(n_fworkers), 0 , n_fworkers),
                  n_fworkers_eoy = ifelse(is.na(n_fworkers_eoy), 0 , n_fworkers_eoy),
                  n_workers = ifelse(is.na(n_workers), 0 , n_workers),
                  n_workers_eoy = ifelse(is.na(n_workers_eoy), 0 , n_workers_eoy),
                  n_informal = ifelse(is.na(n_informal), 0, n_informal),
                  n_workers_ss = ifelse(is.na(n_workers_ss), 0, n_workers_ss),
                  fworkers = n_fworkers/ n_workers,
                  fworkers_eoy = n_fworkers_eoy/n_workers_eoy,
                  fworkers = ifelse(n_workers == 0, NA, fworkers),
                  fworkers = ifelse(n_workers > 0 & n_fworkers == 0, 0, fworkers),
                  fworkers_eoy = ifelse(n_workers_eoy == 0, NA, fworkers_eoy),
                  fworkers_eoy = ifelse(n_workers_eoy > 0 & n_fworkers_eoy == 0, 0, fworkers_eoy),
                  across(vsic, as.numeric),
                  fworkers = ifelse(fworkers > 1 | fworkers < 0, NA, fworkers),
                  fworkers_eoy = ifelse(fworkers_eoy > 1 | fworkers_eoy < 0, NA, fworkers_eoy)) %>% 
           mutate(type = case_when(
             lhdn < 5 ~ "soe",
             lhdn == 11  ~ "foe",
             lhdn == 6 | lhdn == 9  ~ "priv",
             TRUE ~ NA  
           ))
         
         )

  if(i %in% c("dn08", "dn09", "dn10", "dn11", "dn12", "dn13", "dn14", "dn15")){
    assign(i, get(i) %>%
             mutate(n_finformal = ifelse(is.na(n_finformal), 0, n_finformal),
                    n_fworkers_ss = ifelse(is.na(n_fworkers_ss), 0, n_fworkers_ss),
                    finformal = n_finformal/n_informal,
                    f_ss = n_fworkers_ss/n_workers_ss,
                    finformal = ifelse(n_workers == 0, NA, finformal),
                    finformal = ifelse(n_informal > 0 & n_finformal == 0, 0, finformal),
                    f_ss = ifelse(n_workers == 0, NA, f_ss),
                    f_ss = ifelse(n_workers_ss > 0 & n_fworkers_ss == 0, 0, f_ss),
                    finformal = ifelse(finformal > 1 | finformal < 0, NA, finformal),
                    f_ss = ifelse(f_ss > 1 | f_ss < 0, NA, f_ss))
           )
  }

  if(i %in% c("dn08", "dn09", "dn10", "dn11")){
    assign(i, get(i) %>%
             mutate(ma_thue = paste0(ma_thue, ma_thue2, sep = "")))
  }


  if(i %in% c("dn08", "dn09", "dn10", "dn12")){

    assign(i, get(i) %>%
             select(tinh, huyen, xa, madn, macs, ma_thue, lhdn, namsxkd, vsic, n_workers, n_fworkers, n_fworkers_eoy, n_informal, n_finformal, n_workers_ss, n_fworkers_ss, wage, ss_comp, ss_cont, pretax_profit, fworkers, fworkers_eoy, f_ss, finformal, type))
  }

  if(i %in% c("dn11", "dn13", "dn14", "dn15")){

    assign(i, get(i) %>%
             select(tinh, huyen, xa, madn, macs, ma_thue, lhdn, vsic, n_workers, n_fworkers, n_fworkers_eoy, n_informal, n_finformal, n_workers_ss, n_fworkers_ss, wage, ss_comp, ss_cont, pretax_profit, fworkers, fworkers_eoy, f_ss, finformal, type))
  }

  if(i %in% c("dn16")){

    assign(i, get(i) %>%
             select(tinh, huyen, xa, ma_thue, lhdn, vsic, n_workers, n_fworkers, n_fworkers_eoy, n_informal, n_workers_ss, wage, ss_comp, ss_cont, pretax_profit, fworkers, fworkers_eoy, type))

  }

  if(i %in% c("dn17", "dn18")){

    assign(i, get(i) %>%
             select(tinh, huyen, xa, ma_thue, namsxkd, lhdn, vsic, n_workers, n_fworkers, n_fworkers_eoy, n_informal, n_workers_ss, wage, ss_comp, ss_cont, pretax_profit, fworkers, fworkers_eoy, type))

  }


}

dn08 <- dn08 %>% mutate(year = 2008)
dn09 <- dn09 %>% mutate(year = 2009)
dn10 <- dn10 %>% mutate(year = 2010)
dn11 <- dn11 %>% mutate(year = 2011)
dn12 <- dn12 %>% mutate(year = 2012)
dn13 <- dn13 %>% mutate(year = 2013)
dn14 <- dn14 %>% mutate(year = 2014)
dn15 <- dn15 %>% mutate(year = 2015)
dn16 <- dn16 %>% mutate(year = 2016)
dn17 <- dn17 %>% mutate(year = 2017)
dn18 <- dn18 %>% mutate(year = 2018)

dn <- bind_rows(dn08, dn09, dn10, dn11, dn12, dn13, dn14, dn15, dn16, dn17, dn18) %>% 
  group_by(tinh, huyen, xa, ma_thue) %>% 
  mutate(id = cur_group_id())

save(dn, file = "dn.rda")
