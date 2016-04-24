---
title: "Learning SQLite syntax with dataframes"
output: html_document
root: ../..
layout: lesson
---

*by Katja Seltmann* with excerpts from Software Carpentry SQLite lesson.

**Supplementary Material**: 

- [answers to exercises](sqldf-answers.txt)
- [reference](http://swcarpentry.github.io/sql-novice-survey/reference.html)
- [SQLite function reference](https://www.sqlite.org/lang_corefunc.html)

#`Goal of this lesson`
- Introduction to relational databases and SQL syntax using SQLlite database manager directly on data frames


# What is a relational database?

A relational database is a way to store and manipulate information. Databases are arranged as tables. Each table has columns (also known as fields) that describe the data, and rows (also known as records) which contain the data.

When we are using a spreadsheet, we put formulas into cells to calculate new values based on old ones. When we are using a database, we send commands (usually called queries) to a database manager: a program that manipulates the database for us. The database manager does whatever lookups and calculations the query specifies, returning the results in a tabular form that we can then use as a starting point for further queries.

# What is SQL?

It is a database manager. Every database manager — Oracle, IBM DB2, PostgreSQL, MySQL, Microsoft Access, and ***SQLite*** — stores data in a different way, so a database created with one cannot be used directly by another. However, every database manager can import and export data in a variety of formats, like .csv, so it is possible to move information from one to another.

***

# Benefits of relational databases

Both relational databases and spreadsheets are used to store and manipulate data.

relational DB | spreadsheets|
---------------|---------------|
handle more data | slow down quickly|
develop open science practices | difficult to follow methods|
easy to version | easy to loose data|

***

# Getting Started:

We are going to learn the basics of SQL using ***SQLite*** using data frames. You can think of a data frame as if they were tables in a relational database. We can do this with sqldf package.

<img src="http://thecodebug.com/wp-content/uploads/2015/01/linq4.gif" height="200px" align="middle"  />

***
sqldf is a powerful R package that allows 1) the use of SQLite syntax to be used directly on data frames, and 2) can create mini-SQLlite databases.

Here's how to install sqldf:

    install.packages("sqldf", dependencies = TRUE)  
    library("sqldf")

***

##`data`
For this section, let's first start by dealing with our data and folders:

- The data is found [here](http://mqwilber.github.io/2016-04-14-ucsb/data/data-files.zip) 

- createing a new folder for our **sqldf** lesson

- **cp** the mammal_stats.csv file into the sqldf folder

- create a new R file called **sqldf-lesson.R** and save it into the sqldf folder

- commit your changes to github!

***
Clear that working memory...

    rm(list = ls())

***
Check your working directory, make a new folder called sqldf

    setwd("~/Desktop/software-carpentry-2016/data-files/sqldf")
    
    getwd()

***

# Reading and looking at your data frame using SQL.

First, read in the data frame as we did before using **read.csv**

    mammals <- read.csv("mammal_stats.csv", header=TRUE)
    
    head(mammals)
    
***TIP***: header: logical: should the data frame use the first row as headers?

***

##Selecting values

R gives you lots of ways to look at your data frame.

    head(mammals)
    tail(mammals)
    ncol(mammals)
    View(mammals)
    
SQLite gives you more ways with Select. Select statements using SQLite * indicates selecting all columns.

    sqldf("select * from mammals limit 10")

***
**Select** distinct values in rows.

    sqldf("select distinct `order` from mammals")
    
    sqldf("select distinct `order`,species from mammals")


> **TIP**: The word ***order*** is a column name, but it is also a command reserved in SQL. Put column names in `` to avoid confusion.

**Select** using filters, limits and ordering

    sqldf("select * from mammals where `order`='Carnivora'")
    
    sqldf("select `order`, species from mammals where `order`='Carnivora'")
    

**Select** using limits and ordering

    sqldf("select * from mammals where `order`='Carnivora' limit 3")
  
***  
  
    sqldf("select * from mammals where `order`='Carnivora' order by `adult_body_mass_g` desc limit 10")
    
        sqldf("select * from mammals where `order`='Carnivora' order by `order` asc, litter_size desc limit 10")

**TIP**: The opposite of desc is **asc**

***

Select based on wildcard searching.

    sqldf("select * from  mammals where species like 'Canis%'")

***
#Select, change and create new data frames

Select a distinct list of values from a column

    sqldf("select distinct `order` as taxonOrder from mammals")
    
***
Select all where litter_size is not NA

    sqldf("select * from mammals where litter_size is not null limit 10")
    
or 

    sqldf("select * from mammals where litter_size != 'N/A' limit 10")
    
***

> **Exercise 1**:
> Select unique species with litter_size less than 1

***

Save your output to a new data frame
    
    mammalsEdited <-  sqldf("select `order` as taxonOrder, species, adult_body_mass_g as mass from mammals")
    
    head(mammalsEdited)

***
Concatination

    sqldf("select taxonOrder || '-' || species as name from mammalsEdited limit 10")

***
Remove white space

    taxonString <- sqldf("select species, taxonOrder || '-' || replace(species,' ','-') as name from mammalsEdited limit 10")
    
    head(taxonString)

***
Counting using SQLite by Groups and then making quick and simple barplots

    numberSpecies <- sqldf("select count(species) as cnt,taxonOrder from mammalsEdited group by taxonOrder order by cnt desc")
    
    head(numberSpecies) 
    
    par(las=2) # make label text perpendicular to axis
    par(mar=c(8,8,3,2)) # increase y-axis margin
    barplot(log(numberSpecies$cnt), names.arg=numberSpecies$taxonOrder)


***
Finding maximum and minimum

    sqldf("select max(adult_body_mass_g) from mammals")
    
    sqldf("select min(adult_body_mass_g) from mammals")
    
    sqldf("select * from mammals where adult_body_mass_g = (select max(adult_body_mass_g) from mammals)")
 
*** 
SQLite has a lot of built in [functions](https://www.sqlite.org/lang_corefunc.html) that can help with processing numbers or text. 

Some particularly helpful ones are: ***trim()***, ***upper()***, ***round()***, and ***random()***

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Function_machine2.svg/220px-Function_machine2.svg.png" height="200px" align="middle"  />

*** 
> **Exercise 2**:
> Use the upper() function to output the taxonOrder names in mammalsEdited all in uppercase. Write the output to a new data frame.

***

 