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

########
# TWFE #
########

dict = c("fworkers_12" = "Share of female workers in 2012")

setFixest_coefplot(dict = dict, grid = F, zero.par = list(type="dotted", col = "darkblue", lty = 2), main = "")

etable(list(
  feols(fworkers ~ fworkers_12 + post + did | id,
        subset(dn1315, year < 2016)),
  feols(fworkers_eoy ~ fworkers_12 + post + did | id,
        subset(dn1315, year < 2016)),
  feols(finformal ~ fworkers_12 + post + did | id,
        subset(dn1315, year < 2016)),
  feols(pretax_profit ~ fworkers_12 + post + did | id,
        subset(dn1315, year < 2016))  
), tex = T)

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

dn0815 <- bind_rows(dn08, dn09, dn10, dn11, dn12, dn13, dn14, dn15, dn16, dn17, dn18) %>% 
  group_by(tinh, huyen, xa, ma_thue) %>% 
  mutate(id = cur_group_id())

##########################
# PLOTTING EVENT STUDIES #
##########################

png("es_nworkers.png")
iplot(feols(log(n_workers) ~ i(year, fworkers_12, 2012) | id + year,
            dn0815,
            vcov = ~id), xlab = "Year")
dev.off()

png("es_fworkers.png")
iplot(feols(fworkers ~ i(year, fworkers_12, 2012) | id + year,
            dn0815,
            vcov = ~id), ylim = c(-0.55, -0.3), xlab = "Year")
dev.off()

png("es_fworkers_eoy.png")
iplot(feols(fworkers_eoy ~ i(year, fworkers_12, 2012) | id + year,
            dn0815,
            vcov = ~id), ylim = c(-0.5, -0.2), xlab = "Year")
dev.off()

png("es_finformal.png")
iplot(feols(finformal ~ i(year, fworkers_12, 2012) | id + year,
            dn0815,
            vcov = ~id), ylim = c(-0.35, -0.05), xlab = "Year", xlim = c(2008, 2015))
dev.off()

png("es_pretax_profit.png")
iplot(feols(pretax_profit ~ i(year, fworkers_12, 2012) | id + year,
            dn0815,
            vcov = ~id), ylim = c(-10000, 10000), xlab = "Year", xlim = c(2008, 2017))
dev.off()