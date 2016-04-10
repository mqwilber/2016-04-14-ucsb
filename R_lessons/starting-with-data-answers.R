## Answers to 'Analyzing Raptor Data' lesson

## Challenge: Assigning values to variables

mass <- 47.5
age <- 122
mass <- mass * 2.0
age <- age - 20

# Look at age and mass after the assignments
age
mass


## Challenge: Slicing (subsetting) data
animal = c("m", "o", "n", "k", "e", "y")

# 1. Obtain the first four
animal[4:1]

# 2.
animal[-1]
# Removes the "m" from monkey
animal[-4]
# Removes the "k" from monkey
animal[-1:-4]
# Removes the first four letters from monkey


# 3. To get "eon" try...
animal[c(5, 2, 3)]


## Challenge: Subsetting data 2
# c. gives the answer we want

## Challenge: Plotting Data

# Check your working directory
dat <- read.csv(file = "data/inflammation-01.csv", header = FALSE)
raptor_sds = apply(dat, 2, sd)
plot(raptor_sds)