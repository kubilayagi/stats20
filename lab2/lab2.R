library(readr)
library(ggplot2)
library(dplyr)

'''
Possible graphs

the category of the job compared to the number of years of experience required

the type of job vs the degree required

state versus the salary offered

months of experience required versus 

box plots by the degree required showing the quartiles for the salaries

'''
PERM2018 <- read.csv("PERM2018.csv")

pdata <- select(PERM2018, CASE_NUMBER, EMPLOYER_NAME, WAGE_OFFER_FROM_9089, WAGE_OFFER_UNIT_OF_PAY_9089, JOB_INFO_WORK_STATE, JOB_INFO_JOB_TITLE, JOB_INFO_EDUCATION, JOB_INFO_EXPERIENCE_NUM_MONTHS)

rm(PERM2018)

pdata$WAGE_OFFER_FROM_9089 <- gsub("#############", "0", pdata$WAGE_OFFER_FROM_9089)

pdata$WAGE_OFFER_FROM_9089 <- gsub(",", "", pdata$WAGE_OFFER_FROM_9089)

pdata <- subset(pdata, !is.na(pdata[,3]))
pdata <- subset(pdata, !is.na(pdata[,6]))
pdata <- subset(pdata, !is.na(pdata[,4]))
pdata <- subset(pdata, !is.na(pdata[,5]))
pdata <- subset(pdata, !(pdata[,7] == "NA" | pdata[,7] == "Other"))
pdata$WAGE_OFFER_FROM_9089 = as.numeric(pdata$WAGE_OFFER_FROM_9089)


pdata <- subset(pdata, pdata$WAGE_OFFER_FROM_9089 < 200000)

salary <- function(df){
  for (i in 1:dim(df)[1]) {
    if (df$WAGE_OFFER_UNIT_OF_PAY_9089[i] == "Hour") {
      df$WAGE_OFFER_FROM_9089[i] = df$WAGE_OFFER_FROM_9089[i] * 40 * 50
    } else if (df$WAGE_OFFER_UNIT_OF_PAY_9089[i] == "Week") {
      df$WAGE_OFFER_FROM_9089[i] = df$WAGE_OFFER_FROM_9089[i] * 50
    } else if (df$WAGE_OFFER_UNIT_OF_PAY_9089[i] == "Bi-Weekly") {
      df$WAGE_OFFER_FROM_9089[i] = df$WAGE_OFFER_FROM_9089[i] * 25
    } else if (df$WAGE_OFFER_UNIT_OF_PAY_9089[i] == "Month") {
      df$WAGE_OFFER_FROM_9089[i] = df$WAGE_OFFER_FROM_9089[i] * 12
    }
    df$WAGE_OFFER_UNIT_OF_PAY_9089[i] = "Year"
  }
  return(df)
}

pdata <- salary(pdata)

# using https://en.wikipedia.org/wiki/List_of_regions_of_the_United_States

pdata <- mutate(pdata, JOB_INFO_REGION = "TERRITORY")

region <- function(df) {
  for (i in 1:dim(df)[1]) {
    state = df$JOB_INFO_WORK_STATE[i]
    if (is.na(state)) {
      print(i)
    }
    if (state == "WA" | state == "OR" | state == "CA" | state == "NV" | state == "ID" | state == "AZ"
        | state == "MT" | state == "UT" | state == "WY" | state == "CO" | state == "NM") {
      df$JOB_INFO_REGION[i] = "WEST"
    } else if (state == "ND" | state == "SD" | state == "NE" | state == "KS" | state == "MO"
               | state == "IA" | state == "MN" | state == "WI" | state == "IL" | state == "IN"
               | state == "OH" | state == "MI") {
      df$JOB_INFO_REGION[i] = "MIDWEST"
    } else if (state == "TX" | state == "OK" | state == "AR" | state == "LA" | state == "MS"
               | state == "AL" | state == "TN" | state == "KY" | state == "FL" | state == "GA"
               | state == "SC" | state == "NC" | state == "VA" | state == "WV" | state == "MD"
               | state == "DE" | state == "DC") {
      df$JOB_INFO_REGION[i] = "SOUTH"
    } else if (state == "PA" | state == "NY" | state == "NJ" | state == "CT" | state == "RI"
               | state == "MA" | state == "VT" | state == "NH" | state == "ME") {
      df$JOB_INFO_REGION[i] = "NORTHEAST"
    }
  }
  return(df)
}

pdata <- region(pdata)

pdata$JOB_INFO_REGION <- as.factor(pdata$JOB_INFO_REGION)

pdata <- subset(pdata, pdata$JOB_INFO_REGION != "TERRITORY")
# pdata <- mutate(pdata, JOB_INFO_REGION = region(pdata$JOB_INFO_WORK_STATE))

pdata <- subset(pdata, pdata$WAGE_OFFER_FROM_9089 < 200000)

g <- ggplot(pdata, aes(x = JOB_INFO_EDUCATION, y = WAGE_OFFER_FROM_9089, fill = JOB_INFO_EDUCATION)) + geom_boxplot() + facet_grid(. ~ JOB_INFO_REGION)

g + labs(title = "Salary Offered vs. Level of Education by Region", x = "Education Level (Degree)", y = "Salary Offered ($)", fill = "Education Level") + theme(plot.title = element_text(hjust = 0.5)) + coord_cartesian(ylim=c(0, 2000)) + coord_flip()
