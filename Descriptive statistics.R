# Summary of avg. share of female workers for each yer 

yearly_avg <- dn %>% 
  group_by(year) %>% 
  summarise(avg_fworkers = mean(fworkers),
            avg_fworkers_eoy = mean(fworkers_eoy),
            avg_finformal = mean(finformal),
            avg_f_ss = mean(f_ss))

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
