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
- Introduction to creating and storing data using SQLite

***

# Advanced methods sqldf() 

We have come far! Now, lets figure out how to do more complex actions in SQLite using sqldf.

***
 <img src="https://s-media-cache-ak0.pinimg.com/736x/e3/e9/02/e3e90236dfce025c9f4ac9aec842f246.jpg" height="300px" align="middle"  />

***

Merging or joining data frames

    A <- data.frame(a1 = c(1, 2, 1), a2 = c(2, 3, 3), a3 = c(3, 1, 2))
    
    B <- data.frame(b1 = 1:2, b2 = 2:1)
    
    sqlMerge <- sqldf("select * from A, B")

    head(sqlMerge)
    
***
    
Let's do this with our concatinated string for the mammal names. Remember the taxonString data frame created from editing mammalsEdited?

    head(taxonString)
    
    head(mammalsEdited)


***
we can merge in a simple way, but it just sticks the data frames together
    
    sqlMergeMammals <- sqldf("select * from taxonString,mammalsEdited")
    
    head(sqlMergeMammals)

***
Let's make the merge in a way we can select values from 2 different data frames and put them together in a new data frame

    sqlJoinMammals <- sqldf("select taxonOrder,mass,mammalsEdited.species,taxonString.name from mammalsEdited join taxonString on taxonString.species=mammalsEdited.species")

    head(sqlJoinMammals)
    
 
***
> **Exercise 3**:
> Create a new dataframe that counts the number of species for every order. Then join that data frame as a new column in the sqlJoinMammals data frame.

> **TIP**: We already did the counts in the data frame **numberSpecies**.

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

    updateValues <- sqldf(c("update sqlJoinMammals set mass = '28' where name='Artiodactyla-Camelus-dromedarius'", "select * from sqlJoinMammals"))

    head(updateValues)

***
> **Exercise 4**:  
 > Round the mass of all values in updateValues.

***

