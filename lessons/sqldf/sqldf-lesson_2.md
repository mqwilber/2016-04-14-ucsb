---
title: "Learning SQLite databases"
output: html_document
root: ../..
layout: lesson
---
  
  *by Katja Seltmann* with excerpts from Software Carpentry SQLite lesson.

**Supplementary Material**: 
  
- [answers to exercises](sqldf-answers.txt)
- [reference](http://swcarpentry.github.io/sql-novice-survey/reference.html)
- [SQLite function reference](https://www.sqlite.org/lang_corefunc.html)
- [Sandy Muspratts R Blog](http://sandymuspratt.blogspot.com/2012/11/r-and-sqlite-part-1.html)

#`Goal of this lesson`
- Introduction to creating and storing data using SQLite, data Joins, Updates and Delete

***
 <img src="https://s-media-cache-ak0.pinimg.com/736x/e3/e9/02/e3e90236dfce025c9f4ac9aec842f246.jpg" height="300px" align="middle"  />

***

#Joining data frames

Let's make the merge in a way we can select values from 2 different data frames and put them together in a new data frame

    sqlJoinMammals <- sqldf("select taxonOrder,mass,mammalsEdited.species,taxonString.name from mammalsEdited join taxonString on taxonString.species=mammalsEdited.species")

    head(sqlJoinMammals)
    
 
***
> **Exercise 3**:
> Create a new dataframe that counts the number of species for every order. Then join that data frame as a new column in the sqlJoinMammals data frame.

***TIP***: We already did the counts in the data frame **numberSpecies**.

# Update and Delete values from a data frame

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
Update values

    updateValues <- sqldf(c("update sqlJoinMammals set mass = '28' where name='Artiodactyla-Camelus-dromedarius'", "select * from sqlJoinMammals"))

    head(updateValues)

***
> **Exercise 4**:  
 > Round the mass of all values in updateValues.

***
#Create a SQLite database

    db <- dbConnect(SQLite(), dbname="Mammaldb.sqlite")
 
***
 Attach the database to R
 
    sqldf("attach 'Mammaldb.sqlite' as new")
    
***
Create a table manually

    dbSendQuery(conn = db,
    "CREATE TABLE Mammal
    (TaxonOrder TEXT,
    species TEXT,
    mass NUMERIC,
    length NUMERIC,
    range NUMERIC,
    litterSize NUMERIC)")

***TIP***: SQLite supports TEXT, NUMERIC, INTEGER, REAL, BLOB [data types](https://www.sqlite.org/datatype3.html). 

***
Reading database tables

    dbListTables(db)
    dbListFields(db, "Mammal")


***
Drop database table

    dbRemoveTable(db, "Mammal")
    
***

***remember***: we have a data frame called mammals.

    mammals <- read.csv("mammal_stats.csv", header=TRUE)
    head(mammals)

***
Insert the data frame into the database

    dbWriteTable(conn = db, name = "Mammal", value = mammals, row.names = TRUE)

***
Select from database using sqldf

    sqldf("SELECT * FROM Mammal limit 10", dbname = "Mammaldb.sqlite") 
    
    
***
Insert a single record