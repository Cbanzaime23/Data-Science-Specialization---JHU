library("swirl")
swirl()

(TRUE != FALSE) == !(6 == 7)
TRUE == !(FALSE)
TRUE

TRUE & c(TRUE, FALSE, FALSE) == (c(TRUE, TRUE,
                                 | TRUE) & c(TRUE, FALSE, FALSE))

TRUE && c(TRUE, FALSE, FALSE) != TRUE && c(TRUE)

#All AND operators are evaluated before OR operators

TRUE && 62 < 62 && 44 >= 44
FALSE < FALSE >= 44
FALSE

FALSE || TRUE && FALSE
FALSE || FALSE
FALSE

TRUE && FALSE || 9 >= 4 && 3 < 6
FALSE || TRUE && TRUE
TRUE

FALSE || TRUE && 6 != 4 || 9 > 4
FALSE || FALSE != 4 || 9 > 4
FALSE || TRUE || TRUE
TRUE

!(8 > 4) || 5 == 5.0 && 7.8 >= 7.79
FALSE || 5 == FALSE >= 7.79


6 >= -9 && !(6 > 7) && !(!TRUE)
TRUE && TRUE && TRUE

FALSE || TRUE && 6 != 4 || 9 > 4
FALSE || FALSE != 4 || TRUE
TRUE

#xor() == exclusive OR

6 >= 6 || 7 >= 8 || 50 <= 49.5

# Everything that exist is an object and Everything that happens is a function call

#POSIXlt objects is just a list of values that make up the date and time
