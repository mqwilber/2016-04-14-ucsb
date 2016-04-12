---
layout: lesson
root: ../..
title: SQL with dataframes
---

*by Katja Seltmann* with excerpts from Software Carpentry SQLite lesson.

**Supplementary Material**: 

- [answers to exercises](ggplot-lesson-answers.R)
- [reference](http://swcarpentry.github.io/sql-novice-survey/reference.html)

# What is a relational database?

A relational database is a way to store and manipulate information. Databases are arranged as tables. Each table has columns (also known as fields) that describe the data, and rows (also known as records) which contain the data.

When we are using a spreadsheet, we put formulas into cells to calculate new values based on old ones. When we are using a database, we send commands (usually called queries) to a database manager: a program that manipulates the database for us. The database manager does whatever lookups and calculations the query specifies, returning the results in a tabular form that we can then use as a starting point for further queries.

# What is SQL?

It is a database manager. Every database manager — Oracle, IBM DB2, PostgreSQL, MySQL, Microsoft Access, and SQLite — stores data in a different way, so a database created with one cannot be used directly by another. However, every database manager can import and export data in a variety of formats, like .csv, so it is possible to move information from one to another.

***

# Benefits of relational databases

Both SQL and spreadsheets are used to store and manipulate data.

SQL | spreadsheets|
---------------|---------------|
relational | not relational|
handle more data | slow down quickly|
develop good practices | bad practices|
easy to backup | easy to loose data|

***

# Getting Started:

We are going to learn the basics of SQLite using data frames. You can think of a data frame as if they were tables in a relational database. We can do this with sqldf package.

<img src="http://thecodebug.com/wp-content/uploads/2015/01/linq4.gif" height="200px" align="middle"  />

***

Here's how to install sqldf:

    install.packages("sqldf", dependencies = TRUE)  
    library("sqldf")

##`data`
- The link to the mammal dataset again, or find the one you used during the last lesson
[Download data files here](https://github.com/mqwilber/2016-04-14-ucsb/blob/gh-pages/data/mammal_stats.csv)

***

# Reading and looking at your data frame using SQL.

First, read in the data frame as we did before.

    mammals <- read.csv("mammal_stats.csv", header=TRUE, stringsAsFactors=FALSE)
    
- stringsAsFactors: logical: should character vectors be converted to factors?
- header: logical: should the data frame use the first row as headers?

***
R gives you lots of ways to look at your dataframe.

    head(mammals) tail(mammals) ncol(mammals) View(mammals)
    
SQL gives you more ways..

    sqldf("select distinct species from mammals")
    sqldf("select distinct `order`,species from mammals")

> **TIP**: The word ***order*** is a column name, but it is also a command reserved in SQL. Put column names in `` to avoid confusion.

***
Select statements using SQL. * indicates selecting all.

    sqldf("select * from mammals")

Select distinct values

    sqldf("select distinct `order` from mammals")
    

Select using filters and ordering

    sqldf("select * from mammals where `order`='Carnivora'")
    sqldf("select * from mammals where `order`='Carnivora' limit 10")
    sqldf("select * from mammals where `order`='Carnivora' order by `adult_body_mass_g` desc limit 10")

***

> **Exercise 1**:
> Select unique species with litter_size greater than 1

***

Select, change and create new data frames

    sqldf("select distinct `order` as TOrder from mammals")
    mammalsEdited <-  sqldf("select `order` as TOrder, species, adult_body_mass_g as mass from mammals")

***
Concatination

    sqldf("select TOrder || '-' || species as name from mammalsEdited limit 10")

***
Remove white space

    sqldf("select TOrder || '-' || replace(species,' ','-') as name from mammalsEdited limit 10")

***

Counting using SQL by Groups

***

Finding maximum and minimum

    sqldf("select max(adult_body_mass_g) from mammals")
    sqldf("select min(adult_body_mass_g) from mammals")
    sqldf("select * from mammals where adult_body_mass_g = (select min(adult_body_mass_g) from mammals)")
 
*** 

> **Exercise 2**:
>  

*** 

Save your new dataframe as a different file.

***

Joining multiple tables (or data frames)

    mammalsJoined <- sqldf("select ")
    mammalsEdited <-  sqldf("select `order` as TOrder, species, adult_body_mass_g as mass from mammals")
***




