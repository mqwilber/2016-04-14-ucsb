## Answers to "Analyzing multiple data sets" lesson

## Challenge: Using loops

# 1. Write a function that prints the first N natural numbers
print_N <- function(num){
    # Function prints the first n natural numbers

    for(n in seq(num)){
        print(n)
    }
}


print_N(3)

# 2. Sum a vector

total <- function(vect){
    # Sums a vector
    tot = 0

    for(i in vect){
        tot = tot + i
    }
    return(tot)
}

ex_vec <- c(4, 8, 15, 16, 23, 42)
total(ex_vec)

# 3. Write an exponential function
expo <- function(base, exponent){
    tot = 1

    # Accounts for exponent = 0. Don't worry about this for now
    if(exponent == 0){
        return(tot)
    }

    for(i in 1:exponent){
        tot = tot * base
    }
    return(tot)
}

expo(3, 0)
expo(3, 2)

## Challenge: Using loops to analyze multiple files

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

analyze_all <- function(pattern){
    # Takes in a file pattern and analyzes all files matching that pattern

    filenames <- list.files(path="data", pattern=pattern, full.names=T)

    for(file in filenames){
        print(paste("Analyzing", file))
        analyze(file)
    }

}