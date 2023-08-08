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

# By type of firm 

yearly_avg_type <- dn %>% 
  group_by(year, type) %>% 
  summarise(avg_fworkers_eoy = mean(fworkers_eoy, na.rm = T),
            avg_finformal = mean(finformal, na.rm = T),
            avg_f_ss = mean(f_ss, na.rm = T))  %>% 
  filter(type != "NA")

ggplot(dplyr::filter(yearly_avg_type, year < 2016), aes(x = year, y = (avg_f_ss)*100, colour = type)) +
  geom_line(size = 1.2) +
  geom_vline(xintercept = 2013, linetype = "dashed", color = "gray40") +
  scale_x_continuous(breaks=seq(2008,2016,1)) +
  labs(x = "Year",
       y = "Share of workers w. SS, female (%)") +
  theme_minimal() +
  theme(axis.line = element_line(color='black'),
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank())
ggsave(file = "N_fworkers_SS_type.png", device = png, width = 7, height = 7)

ggplot(dplyr::filter(yearly_avg_type, year < 2016), aes(x = year, y = (avg_finformal)*100, colour = type)) +
  geom_line(size = 1.2) +
  geom_vline(xintercept = 2013, linetype = "dashed", color = "gray40") +
  scale_x_continuous(breaks=seq(2008,2016,1)) +
  labs(x = "Year",
       y = "Share of informal workers, female (%)") +
  theme_minimal() +
  theme(axis.line = element_line(color='black'),
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank())
ggsave(file = "N_finformal_SS_type.png", device = png, width = 7, height = 7)

ggplot(yearly_avg_type, aes(x = year, y = (avg_fworkers_eoy)*100, colour = type)) +
  geom_line(size = 1.2) +
  geom_vline(xintercept = 2013, linetype = "dashed", color = "gray40") +
  scale_x_continuous(breaks=seq(2008,2018,1)) +
  labs(x = "Year",
       y = "Share of workers, female (%)") +
  theme_minimal() +
  theme(axis.line = element_line(color='black'),
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank())
ggsave(file = "N_fworkers_type.png", device = png, width = 7, height = 7)

# Industry 

yearly_avg_industry <- dn %>% 
  group_by(year, Industry) %>% 
  summarise(avg_fworkers_eoy = mean(fworkers_eoy, na.rm = T),
            avg_finformal = mean(finformal, na.rm = T),
            avg_f_ss = mean(f_ss, na.rm = T)) %>% 
  filter(Industry != "NA")

ggplot(yearly_avg_industry, aes(x = year, y = (avg_fworkers_eoy)*100, colour = Industry)) +
  geom_line(size = 1.2) +
  geom_vline(xintercept = 2013, linetype = "dashed", color = "gray40") +
  scale_x_continuous(breaks=seq(2008,2018,1)) +
  labs(x = "Year",
       y = "Share of workers, female (%)") +
  theme_minimal() +
  theme(axis.line = element_line(color='black'),
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank())
ggsave(file = "N_fworkers_industry.png", device = png, width = 7, height = 7)

ggplot(dplyr::filter(yearly_avg_industry, year < 2016), aes(x = year, y = (avg_finformal)*100, colour = Industry)) +
  geom_line(size = 1.2) +
  geom_vline(xintercept = 2013, linetype = "dashed", color = "gray40") +
  scale_x_continuous(breaks=seq(2008,2018,1)) +
  labs(x = "Year",
       y = "Share of informal workers, female (%)") +
  theme_minimal() +
  theme(axis.line = element_line(color='black'),
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank())
ggsave(file = "N_finformal_industry.png", device = png, width = 7, height = 7)

ggplot(dplyr::filter(yearly_avg_industry, year < 2016), aes(x = year, y = (avg_f_ss)*100, colour = Industry)) +
  geom_line(size = 1.2) +
  geom_vline(xintercept = 2013, linetype = "dashed", color = "gray40") +
  scale_x_continuous(breaks=seq(2008,2018,1)) +
  labs(x = "Year",
       y = "Share of workers w. SS, female (%)") +
  theme_minimal() +
  theme(axis.line = element_line(color='black'),
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank())
ggsave(file = "N_f_ss_industry.png", device = png, width = 7, height = 7)

# Size
yearly_avg_size <- dn %>% 
  group_by(year, size) %>% 
  summarise(avg_fworkers_eoy = mean(fworkers_eoy, na.rm = T),
            avg_finformal = mean(finformal, na.rm = T),
            avg_f_ss = mean(f_ss, na.rm = T)) %>% 
  filter(size != "NA")

ggplot(dplyr::filter(yearly_avg_size, year < 2016), aes(x = year, y = (avg_finformal)*100, colour = size)) +
  geom_line(size = 1.2) +
  geom_vline(xintercept = 2013, linetype = "dashed", color = "gray40") +
  scale_x_continuous(breaks=seq(2008,2018,1)) +
  labs(x = "Year",
       y = "Share of informal workers, female (%)") +
  theme_minimal() +
  theme(axis.line = element_line(color='black'),
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank())
ggsave(file = "finformal_size.png", device = png, width = 7, height = 7)

ggplot(dplyr::filter(yearly_avg_size, year < 2016), aes(x = year, y = (avg_fworkers_eoy)*100, colour = size)) +
  geom_line(size = 1.2) +
  geom_vline(xintercept = 2013, linetype = "dashed", color = "gray40") +
  scale_x_continuous(breaks=seq(2008,2018,1)) +
  labs(x = "Year",
       y = "Share of workers, female (%)") +
  theme_minimal() +
  theme(axis.line = element_line(color='black'),
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank())
ggsave(file = "fworkers_size.png", device = png, width = 7, height = 7)

ggplot(dplyr::filter(yearly_avg_size, year < 2016), aes(x = year, y = (avg_f_ss)*100, colour = size)) +
  geom_line(size = 1.2) +
  geom_vline(xintercept = 2013, linetype = "dashed", color = "gray40") +
  scale_x_continuous(breaks=seq(2008,2018,1)) +
  labs(x = "Year",
       y = "Share of workers w. SS, female (%)") +
  theme_minimal() +
  theme(axis.line = element_line(color='black'),
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank())
ggsave(file = "f_ss_size.png", device = png, width = 7, height = 7)
