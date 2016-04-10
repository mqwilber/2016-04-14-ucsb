## Answers to "Creating functions" exercises

## Challenge: Creating a function

# a. Create the funce function
fence <- function(original, wrapper){
    # Comment about your function here
    return(c(wrapper, original, wrapper))
}

best_practice <- c("Write", "programs", "for", "people", "not", "computers")
asterisk <- "***"  # R interprets a variable with a single value as a vector
                   # with one element.
fence(best_practice, asterisk)


# b. Create a function outside

outside <- function(input){
    # Comment about your function here

    first <- input[1]
    last <- input[length(input)]
    return(c(first, last))

    # A more compact solution
    #return(input[c(1, length(input))])
}

dry_principle <- c("Don't", "repeat", "yourself", "or", "others")
outside(dry_principle)


## Challenge: Following the call stack

inner_vec <- "carbon"
outer_vec <- "+"
result <- outside(fence(inner_vec, outer_vec))

# fence(inner_vec, outer_vec) is evaluated first. The result is then passed to
# outside when evaluates the result as input and returns "+" "+"


## Challenge: A more advanced function

analyze <- function(filename){
    # Produces plots of average, min and max inflammation from given file
    #
    # filename: string/character

    dat <- read.csv(filename) # read file

    # Calculate the avgs, mins and maxs
    avg_inf <- apply(dat, 2, mean)
    min_inf <- apply(dat, 2, min)
    max_inf <- apply(dat, 2, max)

    # Plot the results
    plot(avg_inf)
    plot(min_inf)
    plot(max_inf)
}

# Try out the function
analyze("data/inflammation-01.csv")

rescale <- function(original_vect){
    # Takes a vector as input and returns a corresponding vector of values
    # scaled to lie in the range 0 to 1.
    #
    # original_vect : vector of doubles

    L <- max(original_vect)
    H <- min(original_vect)
    scaled <- (H - original_vect) / (H - L)
    return(scaled)
}

# Test rescale function
vals = rescale(1:10)
min(vals)
max(vals)
plot(vals)


## Challenge: A function with default argument value

rescale <- function(original_vect, lower=0, upper=1){
    # Takes a vector as input and returns a corresponding vector of values
    # scaled to lie in the range 0 to 1. The user can specify the
    # lower and upper bounds that are desired
    #
    # original_vect : vector of doubles

    # Rescale to 0 and 1
    L <- max(original_vect)
    H <- min(original_vect)
    scaled <- (H - original_vect) / (H - L)

    # Convert to the given lower and upper bounds
    scaled <- (upper - lower) * scaled + lower

    return(scaled)
}

rescale(1:10)
rescale(1:10, lower=3, upper=20)
