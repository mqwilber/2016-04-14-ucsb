---
layout: lesson
root: ../..
title: SQL with dataframes
---

*by Katja Seltmann* with excerpts from Software Carpentry SQLite lesson.

**Supplementary Material**: 

- [answers to exercises](sqldf-answers.txt)
- [reference](http://swcarpentry.github.io/sql-novice-survey/reference.html)
- [SQLite function reference](https://www.sqlite.org/lang_corefunc.html)

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
develop open science practices | difficult to follow methods|
easy to backup | easy to loose data|

***

# Getting Started:

We are going to learn the basics of SQL using SQLite using data frames. You can think of a data frame as if they were tables in a relational database. We can do this with sqldf package.

<img src="http://thecodebug.com/wp-content/uploads/2015/01/linq4.gif" height="200px" align="middle"  />

***

Here's how to install sqldf:

    install.packages("sqldf", dependencies = TRUE)  
    
    library("sqldf")

##`data`
For this section, let's load the file [mammal_stats.csv](http://mqwilber.github.io/2016-04-14-ucsb/lessons/plyr_reshape/mammal_stats.csv) again (it might still be in memory from the plyr lesson).

***
Check your working directory..

    setwd("~/Desktop/software-carpentry-2016")

***

# Reading and looking at your data frame using SQL.

First, read in the data frame as we did before.

    mammals <- read.csv("./data-files/mammal_stats.csv", header=TRUE)
    
- header: logical: should the data frame use the first row as headers?

***
R gives you lots of ways to look at your dataframe.

    head(mammals)
    tail(mammals)
    ncol(mammals)
    View(mammals)
    
SQL gives you more ways with Select. Select statements using SQL. * indicates selecting all columns.

    sqldf("select * from mammals limit 10")

> **TIP**: The word ***order*** is a column name, but it is also a command reserved in SQL. Put column names in `` to avoid confusion.

***
Select distinct values in rows.

    sqldf("select distinct `order` from mammals")
    
    sqldf("select distinct `order`,species from mammals")
    

Select using filters and ordering.

    sqldf("select * from mammals where `order`='Carnivora'")
    
    sqldf("select * from mammals where `order`='Carnivora' limit 10")
    
    sqldf("select * from mammals where `order`='Carnivora' order by `adult_body_mass_g` desc limit 10")

***
> **Exercise 1**:
> Select unique species with litter_size less than 1

***
Select based on wildcard searching.

    sqldf("select * from  mammals `order` where species like 'Canis%'")

***

Select, change and create new data frames

    sqldf("select distinct `order` as taxonOrder from mammals")
    
***
Save your new dataframe as a different file
    
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
Counting using SQL by Groups and then making simple barplots

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
SQL has a lot of built in [functions](https://www.sqlite.org/lang_corefunc.html) that can help with processing numbers or text. 

Some particularly helpful ones are: trim(), upper(), round(), random(), but there are many others!

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Function_machine2.svg/220px-Function_machine2.svg.png" height="200px" align="middle"  />

*** 
> **Exercise 2**:
> Use the upper() function to output the taxonOrder names in mammalsEdited all in uppercase. Write the output to a new data frame.

***

#Advanced methods sqldf() 

We have come far! Now, lets figure out how to do more complex actions in sql.

***

Merging or joining data frames

    A <- data.frame(a1 = c(1, 2, 1), a2 = c(2, 3, 3), a3 = c(3, 1, 2))
    
    B <- data.frame(b1 = 1:2, b2 = 2:1)
    
    sqlMerge <- sqldf("select * from A, B")

    head(sqlMerge)
    
Let's do this with our concatinated string for the mammal names. Remember the taxonString data frame created from editing mammalsEdited?

    head(taxonString)
    
    head(mammalsEdited)

    sqlMergeMammals <- sqldf("select * from taxonString,mammalsEdited")

    head(sqlMergeMammals)

    sqlJoinMammals <- sqldf("select taxonOrder,mass,mammalsEdited.species,taxonString.name from mammalsEdited natural join taxonString")

    head(sqlJoinMammals)
    
 <img src="https://s-media-cache-ak0.pinimg.com/736x/e3/e9/02/e3e90236dfce025c9f4ac9aec842f246.jpg" height="300px" align="middle"  />
 
***
> **Exercise 3**:
> Create a new dataframe that counts the number of species for every order. Merge that number in a new column in the sqlJoinMammals data frame.
> **TIP**: We already did the counts in the data frame **numberSpecies**.


***
Update a data frame

    sql1 <- "update sqlJoinMammals set taxonOrder='Primates' where name='Artiodactyla-Camelus-dromedarius'"
    
    sql2 <- "select * from sqlJoinMammals"
    
    sqldf(c(sql1, sql2))
    
    
***
Delete values

    noCarnivora <- sqldf(c("delete from sqlJoinMammals where taxonOrder='Carnivora'", "select * from sqlJoinMammals"))

    head(noCarnivora)
    
***

    updateValues <- sqldf(c("update sqlJoinMammals set mass = '28' where name='Artiodactyla-Camelus-dromedarius'", "select * from sqlJoinMammals"))

    head(updateValues)

***
> **Exercise 4**:  
 > Round the mass of all values in updateValues.

***
#What we did not cover

We covered basic syntax of sql using sqlLite syntax. We did not cover creating a database or inserting into a database. There are a lot of good tutorials online to learn more:

- [Sandy Muspratt's R Blog](http://sandymuspratt.blogspot.com/2012/11/r-and-sqlite-part-1.html)

