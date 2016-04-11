---
layout: lesson
root: ../..
title: SQL with dataframes
---

*by Katja Seltmann*

**Supplementary Material**: 

- [answers to exercises](ggplot-lesson-answers.R)
- [reference](http://swcarpentry.github.io/sql-novice-survey/reference.html)

# What is a relational database?

A relational database is a way to store and manipulate information. Databases are arranged as tables. Each table has columns (also known as fields) that describe the data, and rows (also known as records) which contain the data.

When we are using a spreadsheet, we put formulas into cells to calculate new values based on old ones. When we are using a database, we send commands (usually called queries) to a database manager: a program that manipulates the database for us. The database manager does whatever lookups and calculations the query specifies, returning the results in a tabular form that we can then use as a starting point for further queries.

# What is SQL?

It is a database manager. Every database manager — Oracle, IBM DB2, PostgreSQL, MySQL, Microsoft Access, and SQLite — stores data in a different way, so a database created with one cannot be used directly by another. However, every database manager can import and export data in a variety of formats, like .csv, so it is possible to move information from one to another.


# Why do we need SQL?

Both SQL and spreadsheets are used to store and manipulate data.

SQL | spreadsheets|
---------------|---------------|
relational | not relational|
handle more data | slow down quickly|
develop good practices | bad practices|
easy to backup | easy to loose data|

***

# Getting Started:

We are going to learn the basics of SQL using dataframes as if they were tables in a relational database. We can do this with sqldf.

Here's how to install sqldf:

    install.packages("sqldf", dependencies = TRUE)  
    library("sqldf")


##`data`
- The link to the mammal dataset again, or find the one you used during the last lesson
[Download data files here](https://github.com/mqwilber/2016-04-14-ucsb/blob/gh-pages/data/mammal_stats.csv)

***

# Reading and looking at your data frame using SQL.

First, read in the data frame as we did before.
mammals <- read.csv("mammal_stats.csv", header=TRUE, stringsAsFactors=FALSE,check.names=FALSE)

> **Tip**: R gives you lots of ways to look at your dataframe.

    head(AWM) tail(AWM) ncol(AWM) View(AWM)

***

sql <- paste("select naOUTPlant.species,naOUTPlant.`",x,"`as cover from naOUTPlant where naOUTPlant.`",x,"` is not NULL", sep = "")
transPlantPairs <- sqldf(sql)
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



