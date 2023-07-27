############################################
# SETTING UP FOR DIFFERENCE-IN-DIFFERENCES #
############################################

fworkers_12 <- dn12 %>% 
  select(tinh, huyen, xa, madn, ma_thue, fworkers) %>% 
  rename(fworkers_12 = fworkers)

for(i in dn0818){
  
  if(i %in% c("dn13", "dn14", "dn15")){
    
    assign(i, left_join(get(i), fworkers_12, by = c("tinh", "huyen", "xa", "madn", "ma_thue")))
    
  }
  
  if(i %in% c("dn16", "dn17", "dn18")){
    
    assign(i, left_join(get(i), fworkers_12, by = c("tinh", "huyen", "xa", "ma_thue")))
    
  }  
  
}

dn1315 <- bind_rows(dn13, dn14, dn15, dn16, dn17, dn18) %>% 
  group_by(tinh, huyen, xa, ma_thue) %>% 
  mutate(id = cur_group_id()) %>% 
  mutate(post = ifelse(year > 2013, 1, 0),
         did = post*fworkers_12)

duplicates <- dn1315 %>% dplyr::group_by(tinh, huyen, xa, madn, ma_thue, id, fworkers_12, year) %>%
  dplyr::summarise(n = dplyr::n(), .groups = "drop") %>%
  dplyr::filter(n > 1L) %>% 
  select(tinh, huyen, xa, madn, ma_thue, id)
  

dn1315 <- anti_join(dn1315, duplicates, by = c("tinh", "huyen", "xa", "madn", "ma_thue", "id"))

save(dn1315, file = "dn1315.rda")

##############################
# SETTING UP FOR EVENT STUDY #
##############################

for(i in dn0818){
  
  if(i %in% c("dn08", "dn09", "dn10", "dn11")){
    
    assign(i, left_join(get(i), fworkers_12, by = c("tinh", "huyen", "xa", "madn", "ma_thue")))
    
  }
  
}

dn12 <- dn12 %>% mutate(fworkers_12 = fworkers)

dn0815 <- bind_rows(dn08, dn09, dn10, dn11, dn12, dn13, dn14, dn15, dn16, dn17, dn18) %>% 
  group_by(tinh, huyen, xa, ma_thue) %>% 
  mutate(id = cur_group_id())

duplicates <- dn0815 %>% dplyr::group_by(tinh, huyen, xa, madn, ma_thue, id, fworkers_12, year) %>%
  dplyr::summarise(n = dplyr::n(), .groups = "drop") %>%
  dplyr::filter(n > 1L) %>% 
  select(tinh, huyen, xa, madn, ma_thue, id)

dn0815 <- anti_join(dn0815, duplicates, by = c("tinh", "huyen", "xa", "madn", "ma_thue", "id"))

save(dn0815, file = "dn0815.rda")

########
# TWFE #
########

dict = c("fworkers_12" = "Share of female workers in 2012")

setFixest_coefplot(dict = dict, grid = F, zero.par = list(type="dotted", col = "darkblue", lty = 2), main = "")

etable(list(
  feols(fworkers_eoy ~ fworkers_12 + post + did | id,
        dn1315),
  feols(finformal ~ fworkers_12 + post + did | id,
        subset(dn1315, year < 2016)),
  feols(f_ss ~ fworkers_12 + post + did | id,
        subset(dn1315, year < 2016)),
  feols(pretax_profit ~ fworkers_12 + post + did | id,
        dn1315)  
), tex = T)

###############
# EVENT STUDY #
###############

png("es_nworkers.png")
iplot(feols(log(n_workers) ~ i(year, fworkers_12, 2012) | id + year,
            dn0815,
            vcov = ~id), xlab = "Year")
dev.off()

png("es_n_informal.png")
iplot(feols(log(n_informal) ~ i(year, fworkers_12, 2012) | id + year,
            dn0815,
            vcov = ~id), xlab = "Year")
dev.off()

png("es_fworkers_eoy.png")
iplot(feols(fworkers_eoy ~ i(year, fworkers_12, 2012) | id + year,
            dn0815,
            vcov = ~id),  xlab = "Year")
dev.off()

png("es_finformal.png")
iplot(feols(finformal ~ i(year, fworkers_12, 2012) | id + year,
            subset(dn0815, year < 2016),
            vcov = ~id), xlab = "Year")
dev.off()

png("es_f_ss.png")
iplot(feols(f_ss ~ i(year, fworkers_12, 2012) | id + year,
            subset(dn0815, year < 2016),
            vcov = ~id), xlab = "Year")
dev.off()

png("es_pretax_profit.png")
iplot(feols(log(pretax_profit) ~ i(year, fworkers_12, 2012) | id + year,
            dn0815), xlab = "Year")
dev.off()

png("es_wage.png")
iplot(feols(log(wage) ~ i(year, fworkers_12, 2012) | id + year,
            dn0815), xlab = "Year")
dev.off()