# Summary of avg. share of female workers for each yer 

dn <- bind_rows(dn08, dn09, dn10, dn11, dn12, dn13, dn14, dn15, dn16, dn17, dn18) %>% 
  group_by(tinh, huyen, xa, ma_thue) %>% 
  mutate(id = cur_group_id())

yearly_avg <- dn %>% 
  group_by(year) %>% 
  summarise(avg_fworkers = mean(fworkers, na.rm = T),
            avg_fworkers_eoy = mean(fworkers_eoy, na.rm = T),
            avg_finformal = mean(finformal, na.rm = T),
            avg_f_ss = mean(f_ss, na.rm = T))

# Visualising data  

ggplot(yearly_avg, aes(x=factor(year), y=avg_fworkers*100)) + 
  geom_col() + 
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank()) + 
  labs(x = "Year",
       y = "Average share of workers, female (%)")

ggplot(dplyr::filter(yearly_avg, year < 2016), aes(x=factor(year), y=avg_finformal*100)) + 
  geom_col() + 
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank()) + 
  labs(x = "Year",
       y = "Average share of informal workers, female (%)") 
