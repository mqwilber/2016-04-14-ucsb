## Answers to "Making choices" lesson

## Challenge: Using conditions for change behavior

# a.
plot_dist <- function(vect, threshold=10){
    if(length(vect) > threshold){
        boxplot(vect)
    } else{
        stripchart(vect)
    }
}

plot_dist(1:20)

# b.
plot_dist <- function(vect, threshold=10, use_boxplot=TRUE){
    # Plot the vector as either a stripchart, hist, or boxplot
    #
    # Parameters:
    #   vect: numeric vector to plot
    #   threshold: integer, if vect is longer than threshold plot a boxplot
    #   use_boxplot: bool, if TRUE use boxplot, else plot histogram
    if(length(vect) > threshold){

        if(use_boxplot){
            boxplot(vect)
        } else{
            hist(vect)
        }

    } else{
        stripchart(vect)
    }
}

plot_dist(1:20)
plot_dist(1:20, use_boxplot=F)

## Challenge: Changing the behavior of the plot command

analyze <- function(filename, output=NULL, plot_type="p") {
    # Plots the average, min, and max inflammation over time.
    # Input:
    #    filename: character string of a csv file
    #    output: character string of pdf file for saving
      if (!is.null(output)) {
        pdf(output)
      }
      dat <- read.csv(file = filename, header = FALSE)
      avg_day_inflammation <- apply(dat, 2, mean)
      plot(avg_day_inflammation, type=plot_type)
      max_day_inflammation <- apply(dat, 2, max)
      plot(max_day_inflammation, type=plot_type)
      min_day_inflammation <- apply(dat, 2, min)
      plot(min_day_inflammation, type=plot_type)
      if (!is.null(output)) {
        dev.off()
      }
}

analyze_all <- function(pattern, plot_type="p") {
    # Runs the function analyze for each file in the current working directory
    # that contains the given pattern.
    #filenames <- list.files(path = "data", pattern = pattern, full.names = TRUE)

    # A more robust alternative to list.files
    filenames <- Sys.glob(file.path("data", pattern))

    for (f in filenames) {
        pdf_name <- sub("csv", "pdf", f)
        analyze(f, output = pdf_name, plot_type=plot_type)
    }
}

# Point plots
analyze_all("inflammation*.csv")

# Line plots
analyze_all("inflammation*.csv", plot_type="l")


