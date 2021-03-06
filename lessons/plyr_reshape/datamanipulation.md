---
layout: lesson
root: ../..
title: Data Manipulation - plyr
---

*Prepared by [Umihiko Hoshijima](mailto:umihiko.hoshijima@lifesci.ucsb.edu), Inspiration/Material from Sean Anderson in [Reshape2](http://seananderson.ca/2013/10/19/reshape.html) and [plyr](http://seananderson.ca/2014/09/13/dplyr-intro.html)*

Goals
-----

The goal of this module is to give a brief introduction to the world of quick data analysis using `plyr`, to serve as reference when working with your own datasets. 

By the end of this lesson, you should be able to: 

1. use `dPlyr` examples to understand the principles behind the "Split-Apply-Recombine" method of data analysis
2. Streamline and increase legibility of code by using `pipes`

Summarizing and Operating: the dPlyr world
---------------------------------

For this section, let's load the file [mammal_stats.csv](https://raw.githubusercontent.com/mqwilber/2016-04-14-ucsb/gh-pages/lessons/plyr_reshape/mammal_stats.csv). This is a subset of a *["species-level database of extant and recently extinct mammals](http://esapubs.org/archive/ecol/E090/184/)*. 

So far we've successfully loaded data by navigating to the directory and typing the name into `read.csv()`. But what if we're writing the script for another computer, or for a collaborator that may have the data in a different location? We can instead have the script pop up a window to select their data from. 

    # Instead of this: 
    # mammals <- read.csv("mammal_stats.csv")
    # Use this: 
    mammals <- read.csv(file.choose())
    dim(mammals)
    
The function `file.choose()` is what pulls up the window and lets you select a file. It then returns that file name and directory, which gets used by `read.csv()`. 
    
Alright, back to mammals! You'll notice that as we work on larger datasets, viewing and visualizing the entire dataset can become more and more difficult. Similarly, analyzing the datasets becomes more complex. Is there a good way to be able to summarize datasets succinctly, and to be able to analyze subsets of a dataset automatically? 

The answer lies in a handy library called `dplyr`. `dplyr` will allow us to perform more complex operations on datasets in intuitive ways.

First off, though, let's explore some very handy sorting and viewing functions in `dplyr`. `glimpse()` is a quick and pretty alternative to `head()`:

    install.packages('dplyr')
    library(dplyr)  
    head(mammals)
    glimpse(mammals) 

If i want to shrink the dataset, we can `select()` columns. We can do that either manually (by naming the columns we want), or by using an operation. where the column name `contains()` a certain string, or `starts_with()` or `ends_with()` one. 

    head(select(mammals, order, species)) #narrows down to these two columns
    head(select(mammals, species, starts_with("adult"))) #the column species, and any column that starts with "adult"
    head(select(mammals, -order)) #every row, except `Order`.

We can also select certain rows using the function `filter()`. As rows aren't named the same way columns are, we will instead use the logical operators `>`, `<` , `==`, etc. to select the rows we want. 

    filter(mammals, order == "Carnivora") # only carnivores
    filter(mammals, order == "Carnivora" & adult_body_mass_g < 5000) # only carnivores smaller than 5kg
    filter(mammals, order == "Carnivora" | order == "Primates") #Any carnivore or primate

We can also arrange the rows in a dataset based on whichever column you want, using `arrange()`. 

    head(arrange(mammals, adult_body_mass_g)) #row 1 is the smallest mammals, the bumblebee bat. 
    head(arrange(mammals, desc(adult_body_mass_g))) #sorts by descending. row 1 is the blue whale. 
    head(arrange(mammals, order, adult_body_mass_g)) #sorts first alphabetically by order, then by mass within order. 

You can see how these can be immediately helpful for certain tasks. A lot of these functions are doable in different ways as well (i.e. logical indexing), but using these function can improve the legibility of your code. 

> ### EXERCISE 1 - animals
> What is the heaviest carnivore?
> How many primates are in our dataset?

<img src="https://upload.wikimedia.org/wikipedia/en/b/be/Craseonycteris_thonglongyai.JPG" height="400px" align="middle"  />

> The bumblebee bat. *Wikipedia Commmons*


With these large datasets, `dplyr` also lets you quickly summarize the data. It operates on a principle called *[split - apply - recombine](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.182.5667&rep=rep1&type=pdf)* : we will *split* up the data, *apply* some sort of operation, and *combine* the results to display them. Suppose we want to find the average body masss of each order. We first want to *split* up the data by order using the function `group_by()`, *apply* the `mean()` function to the column `adult_body_mass_g`, and report all of the results using the function `summarise()`. 

    a <- group_by(mammals, order)
    summarize(a, mean_mass = mean(adult_body_mass_g, na.rm = TRUE))

To we can add other functions here, such as `max()`, `min()`, and `sd()`. 

    summarize(a, mean_mass = mean(adult_body_mass_g, na.rm = TRUE), sd_mass = sd(adult_body_mass_g, na.rm = TRUE))

`summarize` makes a new dataset, but `mutate` will add these columns instead to the original dataframe. 

    a <- group_by(mammals, order)
    mutate(a, mean_mass = mean(adult_body_mass_g, na.rm = TRUE))

This outputs the same numbers as the equivalent `summarize` function, but puts them in a new column on the same dataset. 

What if we want to figure out how the mass of each animal relates to other animals of its order? To do this, we will divide each species' body mass by its order's mean body mass. 

    a <- group_by(mammals, order)
    mutate(a, mean_mass = mean(adult_body_mass_g, na.rm = TRUE), normalized_mass= a dult_body_mass_g / mean_mass)

Using Pipes for code streamlining
---------------------
You might be noticing that in each of these examples, we are feeding the result of the first line into the second line, using `a` as an intermediate variable. While this is functional, there is a more legible solution called `Pipes`. `Pipes` uses the operation `%>%` to push the results of one line to the next. for example, instead of writing 

   a = group_by(mammals, order)
   mutate(a, mean_mass <- mean(adult_body_mass_g, na.rm = TRUE))
we would write

    
    a = mammals %>%  #take the mammals data
        group_by(order) %>% #split it up by "order"
        mutate(mean_mass = mean(adult_body_mass_g, na.rm = TRUE))


<img src="http://uploads7.wikiart.org/images/rene-magritte/the-treachery-of-images-this-is-not-a-pipe-1948(2).jpg" height="400px" align="middle"  />


This can make it easy to follow the logical workflow, which makes more and more sense as your operations become more complex. Suppose we want to find the organisms with the biggest mass relative to the rest of its order. We want to split the data by `order`, apply the mutate functions from above, sort by `normalized_mass`, and only display the `species`, `adult_body_mass_g`, and `normalized_mass` columns. In longhand it would look like this:

    a = group_by(mammals, order)
    b = mutate(a, mean_mass = mean(adult_body_mass_g, na.rm = TRUE), normalized_mass = adult_body_mass_g / mean_mass)
    c = arrange(b, desc(normalized_mass))
    d = select(c, species, normalized_mass)

pipes makes it less messy by reducing the number of variables: 

    e = mammals %>%
        group_by(order) %>%
        mutate(mean_mass = mean(adult_body_mass_g, na.rm = TRUE), 
        normalized_mass = adult_body_mass_g / mean_mass) %>%
        arrange(desc(normalized_mass)) %>%
        select(species, normalized_mass, adult_body_mass_g) 

This lets us see that many of the animals relatively large for their size are rodents. It seems to make sense that the smaller your order's average mass, the easier it would be to be 116x larger than the average! 


> ### EXERCISE 2 - Data exploration. Try to use pipes!
> Which order has the most species? Which order has the widest range of body mass (max-min)?
> Which species of carnivore has the largest body length to body mass ratio? (Hint: that's `adult_head_body_len_mm / adult_body_mass_g')`
> 


**Sources and Umi's additional tips/tricks:**

* The best cheat sheet for data wrangling in R: [Data Wrangling in dplyr and tidyr](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
* A great set of slides that expounds on this: [Date Wrangling in R](http://ucsb-bren.github.io/env-info/wk03_dplyr/wrangling-webinar.pdf)
* This is where I learned dplyr: [Sean Anderson](http://seananderson.ca/2014/09/13/dplyr-intro.html). He actually helped me over twitter in suggesting dPlyr - so a shout-out to him for being awesome and accessible!
* This is another dplyr tutorial that may help in addition to that first one: [Kevin Markham](http://rpubs.com/justmarkham/dplyr-tutorial)
* Sometimes `dPlyr` might not do exactly what you want. In reality, `dPlyr` is a streamlined version of a more powerful (but slower) library called `plyr`. [Sean Anderson's plyr tutorial](https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=plyr). While `dplyr` always takes in a dataframe and outputs a dataframe (summarize and mutate), `plyr` can take in a dataframe, list, or array and output a dataframe, list, or array. There are also individual R functions that go from array to array (`apply`) or data frame to data frame (`aggregate`) but plyr brings them all under one roof for easier syntax. 

