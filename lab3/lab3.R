mysd1 <- function(x, na.rm = FALSE) {
  if (is.vector(x) || is.factor(x)) {
    return(sqrt(var(x, na.rm = na.rm)))
  } else {
    return(sqrt(var(as.double(x), na.rm = na.rm)))
  }
}

mysd2 <- function(x, na.rm = FALSE) {
  if (is.data.frame(x)) {
    return(sapply(x, mysd1))
  } else {
    return(mysd1(x, na.rm))
  }
}

pythag <- function(a, b) {
  if (a <= 0 || b <= 0) {
    stop("values need to be positive")
  } else if (!is.numeric(a) || !is.numeric(b)) {
    stop("I need numeric values to make this work")
  }
  return(list("hypotenuse" = sqrt(a^2 + b^2), "sidea" = a, "sideb" = b))
}


set.seed(1)
a <- data.frame(matrix(sample(1:1000,1000000, replace=TRUE), nrow=100000, ncol=10))
names(a) <- c("alpha", "bravo", "charlie", "delta", "echo", "foxtrot", "golf", "hotel", "india", "juliet")


## Style 1
system.time({out <- data.frame(matrix(NA, nrow(a), ncol(a)))
names(out) <- names(a)
for(i in seq_along(a)){
  out[[i]] <- sqrt(a[,i])
}  
})


## Style 2
system.time({out2 <- data.frame(matrix(NA, nrow(a), ncol(a)))
names(out2) <- names(a)
nm <- names(a)
for(nm in names(a)){
  out2[[nm]] <-sqrt(a[[nm]])
}  
})


## Style 3
xs <- as.vector(unlist(a[1:1000,]))
system.time({
  res <- c()
  for (x in xs) {
    res <-c(res, sqrt(x))
  }
  res <-data.frame(matrix(res, nrow=1000, ncol=10))
})


## Lapply Style 1
system.time({a2 <- lapply(a, function(x) sqrt(x))
names(a2) <- names(a)
})

## Lapply Style 2
system.time({a2 <- lapply(seq_along(a), function(i) sqrt(a[[i]]))
names(a2) <- names(a)
})

## Lapply Style 3
system.time({nm <- names(a)
a2 <- lapply(names(a), function(nm) sqrt(a[[nm]]))
names(a2) <- names(a)
})

## Our Part 4
# 1
library(plyr)

# 2
sapply(baseball, class)

#3
sapply(baseball[6:12], function(x) {
  x / max(x)
})

library(readr)

lapply(list.files(path = ".", pattern = "death.{0,}\\.csv"), function(x) {
  assign(substring(x, 1, nchar(x) - 4), read_csv(x))
})

