# install.packages("tidyverse")
find.package("tidyverse")
# [1] "/Library/Frameworks/R.framework/Versions/3.6/Resources/library/tidyverse"

find.package("readr")
# [1] "/Library/Frameworks/R.framework/Versions/3.6/Resources/library/readr"

find.package("foreign")
# [1] "/Library/Frameworks/R.framework/Versions/3.6/Resources/library/foreign"

(79 - 32) * 5 / 9
# [1] 26.11111

tf <- as.numeric(nhtemp)
tc <- (tf - 32) * 5 / 9
tc
# [1]  9.944444 11.277778  9.666667 10.611111  9.666667  8.833333  9.888889 10.500000  9.611111 11.055556
# [11] 10.444444  9.777778  9.611111 10.333333  9.111111 10.388889 10.500000 10.333333 10.833333 11.555556
# [21] 11.000000 10.611111  9.888889 10.111111 10.222222 10.888889 11.000000 10.500000  9.333333 10.944444
# [31] 10.555556 10.333333 10.944444 10.833333 11.166667 10.722222 10.555556 12.222222 10.777778 11.500000
# [41] 11.722222 12.555556 11.111111 11.111111 10.500000 11.444444 10.111111 11.444444 10.888889 11.055556
# [51] 10.277778 10.500000 10.944444 10.777778 10.944444 10.444444 11.055556 11.000000 11.055556 11.666667


################ 3.2 ###################

cv <- c("wrath", "avarice", "sloth", "pride", "lust", "envy", "gluttony")

cv[6:7]

# this code received an error because R has no way to properly cast characters to integers in order to perform an integer operation. The reason that the code worked when adding three to the vector b is because logcial (boolean) values can be cast easily into integers, represented as either 1 for TRUE or 0 for FALSE.

############### 3.3 ###################
# Method 1
w <- matrix(49:20, nrow = 6, ncol = 5, byrow = TRUE)

# Method 2
x <- 49:20
dim(x) <- c(5,6)
t(x)

# Method 3
y <- rbind(49:45, 44:40, 39:35, 34:30, 29:25, 24:20)

# Extract 3rd row only
w[3,]

# 2nd, 4th cols only
cbind(w[,2], w[,4])



############### 3.4 ###################

data(USJudgeRatings)
class(USJudgeRatings)
# [1] "data.frame"

mode(USJudgeRatings)
# [1] "list"

# Get info about it
str(USJudgeRatings)

# get california's data
USArrests["California",]

# all urban pop values
USArrests$UrbanPop

# minimum murder rate
USArrests[USArrests$Murder == min(USArrests$Murder),]

# states with at least urban pop of 85
USArrests[USArrests$UrbanPop >= 85,]


###### this is example code??? ############
head(USArrests)
head(ChickWeight)

myUSA <- USArrests  ## we make a copy
## we can add a new variable using $ row.names() just extracts the row names 
myUSA$NAME <- row.names(USArrests) 
## always check your work
head(myUSA)

## recall row.names extracts the row names, they are going to "get" the numbers
## 1 to the number of rows, that is nrow(), in myUSA
row.names(myUSA) <- 1:nrow(myUSA) 
head(myUSA)

library(dplyr)
## we can add a new variable using mutate, the %>% means "then"
myUSA2 <- USArrests %>% mutate(NAME2 = row.names(USArrests))
## always check your work
head(myUSA2)


############### 4 ############
# Pseudocode
# Input temperature in Fahrenheit
# Subtract 32 from the value
# Multiply by 5
# Divide by 9
# Output temperature in Celsius

f2c <- function(t) {
  (t - 32) * 5 / 9
}
