install.packages("swirl")
library("swirl")
ls()

#cleaning the variable list in workspace
rm(list = ls())
ls()

#installing the R Programming Course
install_from_swirl("R Programming")

swirl()

#Exit => Esc key
#Exit and save your progress => bye()
#When you are at the R prompt (>):
| -- Typing skip() allows you to skip the current question.
| -- Typing play() lets you experiment with R on your own;
| swirl will ignore what you do...
| -- UNTIL you type nxt() which will regain swirl's
| attention.
| -- Typing bye() causes swirl to exit. Your progress will be
| saved.
| -- Typing main() returns you to swirl's main menu.
| -- Typing info() displays these options again.

help.start()
5 + 7

#we want our vector to contain 10 zeros, then 10 ones, then 10 twos
rep(c(0, 1, 2), each = 10)

#we want our vector to contain 10 repetitions of the vector (0, 1, 2)
rep(c(0, 1, 2), times = 10)

#((111 >= 111) | !(TRUE)) & ((4+1) == 5)
#(TRUE | FALSE) & TRUE
#TRUE & TRUE
#TRUE

#Character Vector
my_char <- c("My", "name", "is")
#Let's say we want to join the elements of my_char together into one continuous character string 
paste(my_char, collapse = " ")

# we can join two vectors, each of length 3. Use paste() to join the integer vector 1:3 with the character vector c("X", "Y", "Z"). This time, use sep = "" to leave no space between the joined elements.
paste(c(1:3), c("X", "Y", "Z"), sep = "")

#1000 draws form the standard normal distribution
y <- rnorm(1000)

#1000 NAs
z <- rep(NA, 1000)

#a sample of 100 from 2000 values
my_data <- sample(c(y,z), 100)

#ask the question of where our NAs are located in our data
my_na <- is.na(my_data)

#count the number of all TRUEs
sum(my_na)

#Subsetting
#x[Not NAs in x and positive values in x]
x[!is.na(x) & x > 0]

#Can you figure out how we'd subset the 3rd, 5th, and 7th elements of x?
x[c(3,5,7)]

#gives us only the 2nd and 10th elements of x
x[c(2,10)]

##gives us only the elements except 2nd and 10th of x
x[c(-2, -10)]

#named elements
vect <- c(foo = 11, bar = 2, norf = NA)

#naming "vect2" vector
names(vect2) <- c("foo", "bar", "norf")


my_matrix2 <- matrix( data = 1:20, nrow = 4, ncol = 5, byrow = FALSE, dimnames = NULL)

