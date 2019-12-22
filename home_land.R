library(dplyr) #data manipulation
library(broom) #tidy, anova
library(tibble) #better data frame
library(ggplot2) #plot
library(zoo) #year quarter
setwd("/Users/akira/Documents/SharedFolder/Programming/R")
landdata <- as.tibble(read.csv("data/landdata-msas-2016q1.csv", skip=0))
landdata$Date <- as.yearqtr(paste(substr(landdata$Date, 1,4),
                                  " ",
                                  substr(landdata$Date, 5,6)))
attach(landdata)
ggplot(landdata, aes(Date)) +
  geom_line(aes(y=HomeValue, color = "Home Value")) +
  geom_line(aes(y=StructureCost, color = "Structure Cost")) +
  geom_line(aes(y=LandValue, color = "Land Value")) +
  #geom_line(aes(y=LandShare, color = "Land Share")) +
  labs(x="Year", y="Values") +
  #theme(axis.line.y.right = element_line("Land Share")) +
  facet_wrap(~ MSA)

all_corr <- landdata %>%
            group_by(MSA) %>%
            summarize(hme_str = cor(HomeValue, StructureCost),
                      hme_lnd = cor(HomeValue, LandValue),
                      str_lnd = cor(StructureCost, LandValue),
                      lnd_shr = mean(LandShare)
                      )

all_corr2 <- landdata %>%
             group_by(MSA) %>%
             do(tidy(cor(.[,3:5])))

library(ggcorrplot)
#all_corr2 %>%
#  group_by(MSA) %>%
#  filter(MSA==MSA) %>%
#  ggcorrplot(.[.$MSA==MSA,3:5])

# lock in factor level order


#ggplot(all_corr) + 
#  geom_col(aes(x="hme_str", y=hme_str, colour="2. Home-Structure")) + 
#  geom_col(aes(x="hme_lnd", y=hme_lnd, colour="1. Home-Land")) + 
#  geom_col(aes(x="str_lnd", y=str_lnd, colour="4. Structure-Land")) + 
#  geom_col(aes(x="land_share", y=mean(landdata$LandShare), colour="3. Land Share")) +
#  labs(y="Correlations or Land Share", title="Correlations of Home-, Land-, Structure- Prices, and Land-Share %") +
#  theme(axis.text.x = element_text(angle = 60, hjust=1)) +
#  facet_wrap(~ MSA)

library(reshape2)
all_corb <- melt(all_corr, MSA="MSA")
ggplot(all_corb, aes(x=variable, y=value, colour=variable, fill=variable)) +
  geom_col() +
  labs(x="Year", y="Correlations, Land Share", title="Correlationsof Home-, Land-, Structure- Prices, and Land-Share %") +
  theme(axis.text.x = element_text(angle = 60, hjust=1)
        #,
        #axis.ticks.y.right = element_line("Land Share")
        ) +
  facet_wrap(~ MSA, ncol=8)

ggplot(landdata, aes(Date)) +
  geom_line(aes(y = HomePriceIndex, color = "Home Price Index")) +
  geom_line(aes(y = LandPriceIndex, color = "Land Price Index")) +
  geom_line(aes(y = 5.0 * LandShare, color = "Land Share"), linetype = "dashed") +
  labs(x="Year", y="Values") +
  scale_y_continuous(sec.axis = sec_axis(~./5.0, name = "Land Share")) +
  facet_wrap(~ MSA)

