# Summary of avg. share of female workers for each yer 

load("dn.rda")

yearly_avg <- dn %>% 
  group_by(year) %>% 
  summarise(avg_fworkers = mean(fworkers, na.rm = T),
            avg_fworkers_eoy = mean(fworkers_eoy, na.rm = T),
            avg_finformal = mean(finformal, na.rm = T),
            avg_f_ss = mean(f_ss, na.rm = T))

# Summarising yearly trends  

ggplot(yearly_avg, aes(x=factor(year), y=avg_fworkers_eoy*100)) + 
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

ggplot(dplyr::filter(yearly_avg, year < 2016), aes(x=factor(year), y=avg_f_ss*100)) + 
  geom_col() + 
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank()) + 
  labs(x = "Year",
       y = "Average share of workers receiving SS, female (%)") 
