#R Programming
#Week 2

#Control Structures
#If Statement

if(<condition>) {
        #Do something
} else {
        # do somthing else
}

#you can have many else if in the middle of the if statement
if(<condition>) {
        # do something
} else if (<condition>) {
        # do something different
} else {
        # do somthing different
}

#if
x <- 10
if(x > 3) {
        y <- 10
} else {
        y <- 0
}
y


y <- if(x > 3){
        10
} else {
        0
} 

#for

for(i in 1:10) {
        print(i)
}

x <- c("a", "b", "c" ,"d ")
for( i in 1:4) {
        print(x[i])
}

for(i in seq_along(x)) {
        print(x[i])
}

for(letter in x ) {
        print(letter)
}

for(i in 1:4) print(x[i])

#nested for loop
x <- matrix(1:6, 2, 3)

#printing every element of a matrix
for(i in seq_len(nrow(x))) {
        for(j in seq_len(ncol(x))) {
                print(x[i, j])
        }
}
x

#while
#loops while the condition is true
count <- 0
while(count < 10) {
        print(count)
        count <- count + 1
}

#random walk
z <- 5

while(z >= 3 && z <= 10) {
        print(z)
        coin <- rbinom(1, 1, 0.5)
        
        if(coin == 1) { #random walk
                z <- z + 1
        } else {
                z <- z - 1
        }
}

#Repeat
x0 <- 1
tol <- 1e-8

repeat {
        x1 <- computeEstimate()
        
        if(abs(x1 - x0) < tol) {
                break
        } else {
                x0 <- x1
        }
        
}

#next, return
for(i in 1:100) {
        if( i <= 20) {
                ## Skip the first 20 iterations
                next
        }
        ## Do something here
}

#My first function
add2 <- function(x, y){
        x + y
}
add2(6,7)

above10 <- function(x){
        use <- x > 10
        x[use]
}

#given that x is a vector
above <- function(x, n){
        use <- x > n
        x[use]
}
x <- 1:20
above(x, 15)

#with default value n = 10
above <- function(x, n = 10){
        use <- x > n
        x[use]
}



xcolumnmean <- function(y) {
        nc <- ncol(y)
        #means is just a palce holder for means
        means <- numeric(nc)
        for(i in 1:nc) {
                means[i] <- mean(y[, i])
        }
        means
}

#Remove NAs
columnmean <- function(y, removeNA = TRUE) {
        nc <- ncol(y)
        #means is just a palce holder for means
        means <- numeric(nc)
        for(i in 1:nc) {
                means[i] <- mean(y[, i], na.rm = removeNA)
        }
        means
}

columnmean(airquality)


#Function
f <- function(<arguments>) {
        #Do something interesting
}

#Argument Matching

mydata <- rnorm(100)
sd(mydata)
sd(x = mydata)
sd(x = mydata, na.rm = FALSE)
sd(na.rm = FALSE, x = mydata)
sd(na.rm = FALSE, mydata)
sd(na.rm = FALSE, mydata)

#Argument Matching
args(lm)

#The Following Calls are equivalent
lm(data = mydata, y - x, model = FALSE, 1:100)
lm(y - x, mydata, 1:100, model = FALSE)

#Lazy Evaluation
f <- function(a, b) {
        a ^ 2
}
f(27)

f <- function(a, b) {
        print(a)
        print(b)
}
f(45)

#The "..." Argument
myplot <- function(x, y, type = "l", ...) {
        plot(x ,y, type = type, ...)
}

#Arguments Coming After the "..." Argument
args(paste)

paste("a", "b", sep = ":")
paste("a", "b", se = ":")

#A Diversion on Binding Values to Symbol
lm <- function(x) { x * x }
lm
lm(2)

x <- 1:10
if(x > 5) {
        x <- 0
}

f <- function(x) {
        g <- function(y) {
                y + z
        }
        z <- 4
        x + g(x)
}

z <- 10
f(3)

x <- 5
y <- if(x < 3) {
        NA
} else {
        10
}
y

h <- function(x, y = NULL, d = 3L) {
        z <- cbind(x, d)
        if(!is.null(y))
                z <- z + y
        else
                z <- z + f
        g <- x + y / z
        if(d == 3L)
                return(g)
        g <- g + 10
        g
}

#Lazy Evaluation
f <- function(a, b = 10) {
        a ^ 2 + b
}
f(3)

myplot <- function(x, y, type = "l", ...) {
        plot(x, y, type = type, ...)
        
}

#Constructor function
make.power <- function(n){
        pow <- function(x) {
                x ^ n
        }
        pow
}
make.power(9)


#Complicated
y <- 10
f <- function(x){
        y <- 2
        y ^ 2 + g(x)
}
g <- function(x) {
        x * y
}
f(3)

#Dates in R
x <- as.Date("1970-01-01")
x
unclass(x)
unclass(as.Date("1970-01-03"))
x <-Sys.time()
x

cube <- function(x, n){
        x^3
}
cube(3)

x <- 1:10
if(x > 5) {
        x <- 0
}



f <- function(x) {
        g <- function(y) {
                y + z
        }
        z <- 4
        x + g(x)
}


z <- 10
f(3)

#How are free variables in R functions resolved?
#The values of free variables are searched for in the environment in which the function was defined

#In R, what is the parent frame?
#It is the environment in which a function was defined









