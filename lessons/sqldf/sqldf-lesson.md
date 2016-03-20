---
layout: lesson
root: ../..
title: sql with dataframes
---

*by Katja Seltmann*

**Supplementary Material**: 
- [answers to exercises](ggplot-lesson-answers.R)
- [reference] (http://swcarpentry.github.io/sql-novice-survey/reference.html)

# What is sql?

- SQL is a specialized programming language used with databases.
- 
- 
- 


# Why do we need sql?

Both base sql and spreadsheets are used to store and manipulate data. Why do we not like spreadsheets?

sql | spreadsheets|
---------------|---------------|
relational | not relational|
handle more data | slow|
develop good practices | bad practices|
easy to backup | easy to loose data|

***

# Getting Started:

Here's how to install sqldf:

    install.packages("sqldf", dependencies = TRUE)  
    library("sqldf")

> **Tip**:
***





##`data`
- The link to the dataset

***

# Reading and looking at your data frame:
View the data frame:
  
1. 
2. 
	head(AWM)
	tail(AWM)
	ncol(AWM)
	View(AWM)

***


***

***

> **Exercise 1**:
> 
  
> Save your new dataframe as a different file.

***
#### Compare to "base" graphics:

- `plot(BloodPressure~Age, data=dat)`

vs.

- `ggplot2(data=dat, aes(x=Age, y=BloodPressure)) + geom_point()`



