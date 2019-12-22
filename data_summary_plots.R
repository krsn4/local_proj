setwd("C:/Users/akirasano/Documents")
library(ggplot2)
library(tidyverse)
#library(zoo)
#final_data$`Reporting Period` <- as.yearqtr(final_data$`Reporting Period`, "%Y%qQ")

#modify Net Loss Amount column that whenever the loss exists, leave only the last quarter entry, 
#and make all previous quarters 0.  If the entry=NA, make them all zero as well.
#final_data$`Net Loss Amount` <- lapply(final_data$`Net Loss Amount`, 
#                                       function(x){
#                                         i1 <- which(is.na(x))
#                                         replace(x, i1, )
#                                       })

# 1. Plot the number of accounts by product type/segment over time in a graph.

# take (rougly) 10% sample
final_data_10 <- final_data[sample(nrow(final_data), 50000),]
attach(final_data)

#01
ggplot(final_data_10) + 
  geom_col(mapping = aes(x=`Reporting Period`, y=`Account Number`)) +
  theme(axis.text.x = element_text(angle = 90, hjust=1)) +
  #scale_x_time() +
  facet_wrap(~`Pool Name.x`)
#01a curves for selected (significant) pools

sel <- c("Commercial Loans Not Secured by Real Estate",
         "Energy Loans",
         "Market-risk Real Estate Loans - Permanent - CRE",
         "Market-risk Real Estate Loans - Interim Construction",
         "Residential Builder Finance  - Interim construction; Unsecured; & All Assets")

ggplot(as.data.frame(final_data[`Pool Name.x` %in% sel, "Account Number"]), 
       aes(x=`Reporting Period`, color=`Pool Name.x`)) +
  geom_line(group=1, stat = 'count')

ggplot(final_data[`Pool Name.x` %in% sel,], aes(x=`Reporting Period`, fill=`Pool Name.x`)) +
  geom_col(aes(y=`Account Number`))

#02
ggplot(final_data_10) +
  geom_col(mapping = aes(x=`Pool Name.x`, y=`Account Number`)) +
  labs(x="Pool Names", y="Account Counts") +
  #theme(axis.text.x = element_text(angle = 60, hjust=1)) +
  coord_flip()

#2 Principal Balance by product, and over time
#(03)
ggplot(final_data_10) +
  geom_col(mapping = aes(x=`Reporting Period`, y=`Principal Balance`)) +
  labs(x="Reporting Period", y="Principal Balance") +
  theme(axis.text.x = element_text(angle = 60, hjust=1)) +
  facet_wrap(~`Pool Name.x`)

#(04) Principal Balance, by risk rating
ggplot(final_data_10) +
  geom_col(mapping = aes(x=`Risk Rating`, y=`Principal Balance`)) +
  labs(x="Risk Rating", y="Principal Balance") +
  facet_wrap(~`Pool Name.x`)

#(05)? risk rating over time, for each pool
ggplot(final_data_10, aes(x=`Reporting Period`, y=`Risk Rating`)) +
  geom_point(size=1) +
  labs(x="Reporting Period", y="Risk Rating") +
  facet_wrap(~`Pool Name.x`)

#(06) Net Loss Amount over segment (like #02)
ggplot(final_data_10) +
  geom_col(mapping = aes(x=`Pool Name.x`, y=`Net Loss Amount`)) +
  labs(x="Pool Names", y="Net Loss Amount") +
  #theme(axis.text.x = element_text(angle = 60, hjust=1)) +
  coord_flip()


#(07) Net Loss Amount over time, for each segment
ggplot(final_data_10) +
  geom_col(aes(x=`Reporting Period`, y=`Net Loss Amount`)) +
  theme(axis.text.x = element_text(angle = 60, hjust=1)) +
  #scale_x_discrete(breaks=c("2006", "2010", "2015", "2018")) +
  facet_wrap(~`Pool Name.x`)

#(08) Net Loss Amount over time (with risk rating colored) for each segment
ggplot(final_data_10) +
  geom_point(aes(x=`Reporting Period`, y=`Net Loss Amount`, col=`Risk Rating`)) +
  theme(axis.text.x = element_text(angle = 60, hjust=1)) +
  #scale_x_discrete(breaks=c("2006", "2010", "2015", "2018")) +
  facet_wrap(~`Pool Name.x`)
 
#(09) pool/segments aggregated Net Loss Amount, but separated by risk ratings
ggplot(final_data_10) +
  geom_col(aes(x=`Reporting Period`, y=`Net Loss Amount`, fill=`Pool Name.x`)) +
  facet_wrap(~`Risk Rating`)

#(10) Principal vs Unpaid Principal Balance over time, segment level
ggplot(final_data_10, aes(x=`Reporting Period`)) +
  #geom_col(aes(y=`Principal Balance`)) +
  geom_col(aes(y=`Unpaid Principal Balance`)) +
  facet_wrap(~`Pool Name.x`)
# no essential difference between the two


s <- summary(final_data_10)
str(final_data_10)
table(is.na(final_data_10))
colSums(is.na(final_data_10))

select <- final_data_10[!is.na(`Net Loss Amount`), c("Net Loss Amount", #"Impaired Specific Reserve", 
                            #"Pool Loss Rate", "Pool Total Factors", 
                            "Classified Pool Loss Rate",
                            "Classified Pool Total Factors", "Principal Balance", "Max Credit",
                            "Total Commitment", "Unpaid Principal Balance")]
corr <- round(cor(select), 2)
library(ggcorrplot)
ggcorrplot(corr)
