---
layout: page
root: .
title: Introducing the Shell
---

*Written by J. Kitzes, Edited by M. Wilber*

Our introduction to best practices in scientific computing begins with one of 
the oldest and most venerable software tools - the shell. As with every tool 
and practice that we'll cover during this two day workshop, we'll only have 
time to introduce you to the very basics of using the shell. We'll focus our 
time here on (a) the core skills that you'll need to get stuff done, including 
in particular those that you'll need to complete the lessons in the rest of the 
workshop, and (b) the overarching concepts of scientific computing that the use 
of the shell illustrates.

Before we get started, I'll note that some of you, especially those of you who 
deal routinely with large numbers of small files (i.e., sensor data saved every 
hour by an instrument), will benefit from learning more advanced skills than 
those that we'll cover here. If you're interested, check out this [lengthier 
and more detailed shell tutorial](http://swcarpentry.github.io/shell-novice/).

So, to kick off, what exactly is "the shell"? Although these days when we think 
of "a computer" we immediately imagine buttons, menus, a mouse, etc., you're 
probably aware that this wasn't always the case. In the days before graphical 
user interfaces (GUIs), all interaction with computers occurred through a 
process that involved sending a computer text commands and waiting for the 
computer to show you some text back in response. Today, this text-based manner 
of interacting with a computer is known as a command line interface, and using 
it is known as "working at the command line".

When we're working at the command line, our interactions with the computer 
follow what's known as a read-evaluate-print loop, which means that we type in 
something, the computer reads it, does something that we've told it to do, and 
prints the output back to us. We do this over and over again until we're done 
and log off. Although we've used the word "computer" above to indicate the 
actor who reads and replies to our text input, the actor that we are 
communicating with directly is actually a specialized program called "the 
shell". We can tell the shell to do all sorts of things, including to work with 
files on our hard drive and to run other specialized command line programs.

Since this is the 2010's, why should we bother learning 
how to use the shell? The most important reason is that much of the rest of the 
scientific computing pipeline depends on it. Once you break out of your comfortable R GUI and start trying to practice more advanced 
scientific computing, you'll immediately need to interact with the shell. On an 
immediate basis, you'll need to be comfortable with the skills in this lesson 
in order to complete our subsequent lessons on scientific programming, particularly version 
control. Furthermore, once you become 
comfortable in the shell, you'll find that there are many tasks that you can do 
more quickly through the shell than through your old graphical programs. 

More specifically, in this lesson we'll review how to use the shell for four 
common types of tasks that are a part of scientific computing.

1. Viewing and interacting with files and directories on your hard drive
2. Launching and using command line programs
3. Chaining different programs together to achieve overall computing tasks
4. Searching for text within files

Launching the shell
-------------------

To get started, let's launch a shell session. If you're on a Mac, go to your 
Applications folder, then to the folder Utilities, then open the program 
Terminal. On Windows, presuming that you've installed mysysgit as per the 
instructions, you should have a desktop shortcut and/or a shortcut in your 
Programs menu to open mysysgit. If you're running Linux, you probably already 
know where the shell is and how to use it - if you're running our Linux Virtual 
Machine for the first time, look under the button at the bottom left of the 
screen (that looks like the old Windows Start Menu) for something called shell 
or terminal.

Once you open the Terminal program, which runs the shell program for us, you'll 
see a blank window with something like this printed in it.

    Last login: Wed Mar 25 10:57:31 on ttys009
    ~$ 

This means you're set to go, even if you don't exactly know where we're going 
yet. You may have other text in front of the `$` symbol on your computer, which 
is fine. You'll notice that if you start typing, your text appears following 
the `$` symbol. This state is known as being at a command prompt, and it's the 
first step in the read-execute-print loop that we mentioned earlier. In other 
words, the shell is now waiting for us to tell it to do something.


Working with directories and files
-------------------------------------

Probably the most fundamental and most frequent type of task that you'll 
complete in the shell will involve navigating around your hard drive and 
working with files and directories. Head back to the shell and to your command 
prompt, type the command `pwd` and hit return, and watch what the shell prints 
out.

    ~$ pwd
    /Users/mqwilber

The response of your shell will be different, of course, unless your name is 
also Mark Wilber. The command `pwd` is short for "print working directory" 
and it tells us which directory the shell is currently in. (This is the command 
line equivalent to opening a particular folder on your hard drive.) When you 
launch a shell session, you're automatically placed in a location known as your 
"home directory" to start off.

So now we know what directory we're in, but we don't know what's in it. To see 
the contents of this folder, type the command `ls`, short for "listing", and 
hit return.

    ~$ ls
    Applications   Downloads   Movies      Pictures    Websites
    Desktop        Dropbox     Music       Public      anaconda
    Documents      Library     Packages    Repos

Once again, you'll see something different depending on what's actually in this 
folder on your computer. If you want to confirm that you know what's going on, 
use your "normal" graphical operating system to open the folder indicated by 
the `pwd` command, and you'll see that these folders and/or files are, in fact, 
where the shell says they are.

Now that we know what directory ("folder", in a graphical interface) we're in 
and what's in this directory, let's start moving around our file system. To do 
this, we use a command `cd`, for "change directory".

    ~$ cd
    ~$

Hmm, that didn't seem to do anything. It turns out that running the command 
`cd` without any additional information changes your working directory to your 
home directory, which is where we already are (since the shell places us in our 
home directory by default). To be useful, we need to give `cd` an argument, 
which is some information following the name of the command itself. The first 
argument that you give `cd` is an indication of which directory you'd like to 
go to.

We know from running `ls` that one of the subdirectories of your home directory 
is "Desktop" (hopefully this is true regardless of what computer or virtual 
machine you're running - if this is not true, ask one of the helpers or 
instructors for assistance). Let's change directories into our Desktop 
directory.

    ~$ cd Desktop
    Desktop$ 

If you run the command `ls`, you should now see a list of all of the files and 
folders on your computer's desktop. If `ls` prints no output, then you have no 
files or folders currently sitting on your desktop - congrats on being 
organized!

Quick tip - now that we're in the Desktop directory, how to we go back "up" to 
our home directory. For that we can use the special argument `..` to the `cd` 
command.

    Desktop$ cd ..
    ~$ pwd
    /Users/mqwilber
    ~$ cd Desktop/
    Desktop$ pwd
    /Users/mqwilber/Desktop
    Desktop$ 

Before we move on to working with files, one final important vocabulary word is 
"path". The path refers to the location of a directory or file on your hard 
drive - we would thus say that `/Users/mqwilber/Desktop` is the path to my 
Desktop directory. There are two ways to think of paths - absolute and 
relative. Absolute paths, like `/Users/mqwilber/Desktop`, give the location of a 
file or directory from the root of your entire file system, which is indicated 
by the leading `/` character (`cd /` will take you to this root). Relative 
paths specify the location of a file or folder relative to your present working 
directory (i.e., the relative path is "glued on" to your current path). If 
you're in your home folder `/Users/mqwilber`, the commands `cd 
/Users/mqwilber/Desktop` and `cd Desktop` thus take you to the same place, but 
the former uses an absolute path (and would work from anywhere) while the 
latter uses a relative path.

Finally, remember that if you ever get lost, `cd` with no arguments will take 
you back to your home folder.

Now that you're in your Desktop directory, let's create a directory to hold all 
of the materials for this workshop. The command `mkdir`, short for "make 
directory", will create a directory. It requires one argument, which is the 
path (absolute or relative) to the directory that you wish to create.

    Desktop$ mkdir workshop
    Desktop$ cd workshop
    workshop$ 

We've now created and moved into a directory named `workshop` in our Desktop 
directory. If you look at your actual Desktop on your computer, you should see 
that, in fact, a new folder called `workshop` has appeared there.

Now that we've created our directory, let's put a file in it. A simple command 
that lets us create an empty file with nothing in it is `touch`, which takes 
one argument for the path to the file (using the file name as the argument 
represents a relative path, which puts the file in your current directory).

    workshop$ touch file.txt
    workshop$ ls
    file.txt

We can easily rename or move existing files with the `mv` command, which takes 
one argument for the existing path to the file and one argument for the new 
path to the file. The command below uses two relative paths to perform a simple 
rename of the file.

    workshop$ mv file.txt file1.txt
    workshop$ ls
    file1.txt

Since this file isn't doing much for us, let's delete it using `rm`, short for 
"remove".

    workshop$ rm file1.txt
    workshop$ ls
    workshop$ 

Important note - the shell has no concept of a trash can, so once you've 
deleted a file using `rm`, it's gone forever. As such, use it carefully.

Removing an empty directory is just as easy as removing a file, but removing a 
full directory requires us to add one extra argument to the `rm` command (more 
on this concept later) - `rm -r directory-name` will delete a directory called 
`directory-name` and all of its contents.

>### Exercise 1
>Change directories to your desktop. Use `touch` to recreate `file.txt` on your 
>Desktop, and then use `mv` to move it into your `workshop` directory. Remove 
>the `workshop` directory and the file in it. Recreate the `workshop` directory 
>and `cd` back into it.

As you perform the above steps, there are two very useful productivity 
shortcuts for working in the shell that you should try out. The first is called 
tab completion. After you create the `workshop` directory, for example, try 
typing `cd wo` and then hitting tab - you'll see that the shell fills in the 
rest of the directory or file name for you (if there are multiple options that 
start with those letters, your shell will either show you all of the options or 
do nothing - in either case, you'll need to enter more letters and press tab 
again). The second is the use of the up arrow, which will scroll through all of 
your previous shell commands - once you find one that you like, you can hit 
return to execute it again.

A final tip on naming files and directories. Although modern shells try hard to 
accommodate special characters like spaces in file and directory names, these 
will sometimes (even often) cause trouble for your command line work. It's 
highly recommended that you use only regular letters, numbers, and dash and 
underscore symbols in your file names to prevent any trouble later on.

Running command line programs
--------------------------------

Now that we've discussed using the shell to navigate our file system, we'll 
move on to discussing the idea of executing command line programs from the 
shell. In the same way that you have graphical applications on your computer 
that you can run with a double click, your computer comes bundled with many 
command line programs that you can run by typing their names into the shell. 
Some of these will simply take an input and spit out an output, while some of 
them will drop you into an entirely new environment specific to that program. 
We'll examine both of these in turn.

The first kind of command line program are those that print their results right 
to the terminal in front of you. In face, we've sneakily already seen several 
of these - it turns out that the various commands that we used in the last 
section are actually programs that are executed by the shell. If you want to 
see where these programs are saved on your hard drive (sort of like the command 
line equivalent of the Applications or Programs folder that you're used to), 
use the command (excuse me, the program) `which`.

    ~$ which ls
    /bin/ls

This tells you that the program `ls` actual resides in a directory called `bin` 
that is found in the root folder of your file system. You've probably never 
gone there, and in fact most graphical operating systems will try to hide 
folders like this from you so that you don't do something dangerous. You can 
easily `cd` into those folders and list their contents from the shell, if 
you're curious, and with enough work you can also view them from your normal 
graphical operating system (on a Mac, for example, go to Finder, the Go menu, 
and Go To Folder, then type in this path).

As we saw earlier, command line programs take two additional types of input, 
known as arguments and options (or flags). Arguments are the words that you 
type after the program name (`touch file.txt`, `cd Desktop`) and usually tell 
the program what file or directory it should perform its operations on. Options 
always start with a dash or two dashes and are used to modify how the program 
operates. For example, try running the `ls` command with the option `-l`. 
Sometimes options can themselves have arguments, so that you have the program 
name, the arguments, the options, and the options to the arguments.

Other than asking an instructor (which will not be easy three days from now), 
how do you know what arguments and options are available for each program? In 
most shell sessions (this may not work on Windows with mysysgit), you can type 
the command `man` followed by the name of the program, and you will be shown 
the help file for that command, which will list all of the available arguments 
and options. Use the arrow keys to scroll up and down, and type `q` to quit 
when you're done.

Aside from programs like `ls` that print their output right to the command line 
(in technical terms, they print to "standard output"), there are also programs 
that launch entire environments for themselves. One of those is the command 
line text editor `nano`. First, make sure that you're in your `workshop` 
directory, then execute the command `nano`.

When you do this, your shell session will appear to vanish (don't worry, it's 
still there in the background), and you'll be dropped into a very simple text 
editor. Enter the following lines in your text editor.

    Fox,1
    Wolverine,5
    Wolf,3

When you're done, as helpfully suggested by the lines at the bottom of your 
window, hit Ctrl-x to exit (the `^` symbol is shorthand for the Control key). 
It will ask you if you want to save the file - type Y for yes. Name the file 
`mammals.csv` and hit return. You'll now be back in your shell session - run 
`ls` and you'll see that you've created a new csv file in this directory.

>### Exercise 2
>Create another file in this directory called `birds.csv` that indicates that 
>you saw 4 Owl, 3 Tern, and 7 Hawk (use the same format as the `mammals.csv` 
>file to enter this data).

You may recognize the file extension `csv` as standing for "comma separated 
values", and you've probably opened `csv` files before in a spreadsheet program 
such as Excel. As suggested by the above, `csv` files are actually nothing more 
than plain text files in which the "columns" of data are separated by commas. 
As plain text files, command line programs (including version control software) 
can do a lot of useful things with `csv` files, making them a good alternative 
to Excel file formats for saving and working with tabular data.

>### Exercise 3
>There are a few ways to easily view plain text files from the command line. 
>Try using the programs `cat` and `less` to view your `mammals.csv` file. Can 
>you see that one of these prints to standard out and one drops you into its 
>own environment? (For the latter, press `q` to exit when you're done.)

`R`, the program/language that we will be using during this workshop can also be invoked from the command line (**Note**: This will not work for Windows users). Just type `R` (or `r`) with no arguments at the command prompt and you should see

     ~$ R

    R version 3.1.2 (2014-10-31) -- "Pumpkin Helmet"
    Copyright (C) 2014 The R Foundation for Statistical Computing
    Platform: x86_64-apple-darwin13.4.0 (64-bit)

    R is free software and comes with ABSOLUTELY NO WARRANTY.
    You are welcome to redistribute it under certain conditions.
    Type 'license()' or 'licence()' for distribution details.

      Natural language support but running in an English locale

    R is a collaborative project with many contributors.
    Type 'contributors()' for more information and
    'citation()' on how to cite R or R packages in publications.

    Type 'demo()' for some demos, 'help()' for on-line help, or
    'help.start()' for an HTML browser interface to help.
    Type 'q()' to quit R.

    > 

Although your shell session has seemingly not vanished in the same way as it 
did when you opened `nano`, you'll notice that your command prompt at the 
bottom of the screen now starts with `>` symbols instead of `$`. This 
helpfully indicates to you that you're actually inside of the R 
console, not the shell, at this point, and that whatever you type will be 
executed by R. Try typing `pwd` and hitting return, 
for example, and notice that `R` has no idea what you're talking about. Instead, try typing `getwd()` (meaning get working directory; the equivalent of `pwd`) and notice that `R` now tells you where you are. 

As another example, type 
`2+2` and hit return, though, and you'll see that R knows what to do with 
that. To quit, type `q()` and then `y` press return, and you'll see that the `$` 
prompt indicates that you're now back in the shell.  While we often don't interact with `R` directly through the command line, it is important to know that you can!

Chaining commands
--------------------

You may have noticed (or inferred) that there are a whole lot of command line 
programs available to us, and that each of them performs a fairly narrow, 
specific task. This is one of the basic philosophies of the Unix operating 
system (where most of these command line programs originated) - have lots of 
small pieces, each of which do their job very well, that can be combined to 
create larger "pipelines" that perform more complex analyses. This is a 
perspective that will also be at the heart of our later discussions of 
structuring scientific programs. In this section, we'll look at two basic 
techniques for combining programs and working with their output, known as 
redirects and pipes.

The first of these techniques, a redirect, is most commonly used to "redirect" 
the output that a program would normally print to your terminal window into a 
file. For example, the `cat` command, which we saw above, will print the 
contents of a file (or multiple files, glued together) to the terminal window.

    workshop$ cat mammals.csv birds.csv
    Fox,1
    Wolverine,5
    Wolf,3
    Owl,4
    Tern,3
    Hawk,7

Let's say that we want to create a combined csv file `animals.csv` that 
contains both the mammal and the bird data. To do this, we can save the output 
of our `cat` command above to a file by using the `>` character, as shown 
below.

    workshop$ cat mammals.csv birds.csv > animals.csv
    workshop$ ls
    animals.csv	birds.csv	mammals.csv
    workshop$ cat animals.csv 
    Fox,1
    Wolverine,5
    Wolf,3
    Owl,4
    Tern,3
    Hawk,7

While the redirect symbol `>` will create a new file, overwriting an old one if 
it exists, using `>>` will instead append the output to a file if it already 
exists.

A second technique, a pipe, is used to turn the output of one program into the 
input for another program. Let's say that we not only wanted to combine the 
mammal and bird tables, but we also wanted to sort the resulting combined table 
by animal name. For sorting, we can use the command `sort`, which prints the 
sorted contents of a file to the terminal.

    workshop$ sort animals.csv
    Fox,1
    Hawk,7
    Owl,4
    Tern,3
    Wolf,3
    Wolverine,5
    workshop$ sort animals.csv > sorted_animals.csv
   
Note how the output of `sort animals.csv` compares to the output of `cat animals.csv`. The second command here saves our sorted list to a new `csv` 
file.

Conceptually, we can see that what we've done is use `cat` to combine our two 
files, then take the result of that combination and give it to the `sort` 
command, then take the output of sort and save it to a file. The first two of 
these steps involves taking the output of one command and giving it to another, 
which here we've done by saving the intermediate file `animals.csv`. We can 
skip that step by using a pipe.

    workshop$ rm animals.csv sorted_animals.csv
    workshop$ cat mammals.csv birds.csv | sort > sorted_animals.csv
    workshop$ cat sorted_animals.csv 
    Fox,1
    Hawk,7
    Owl,4
    Tern,3
    Wolf,3
    Wolverine,5
    
Here we first removed `animals.csv` and `sorted_animals.csv` from our previous 
commands. Then we ran the `cat` command on our two files, piped the output of 
that command directly to sort, and redirected that output directly to our file 
sorted_animals.csv.

>### Exercise 4
>The command `wc` counts the number of lines, words, and bytes in a file. 
>Combine the command `wc` with the above pipe/redirect command to instead save 
>a text file, `n_records.txt`, that contains a single number giving the number 
>of total records of both mammal and bird sightings (of which there are 6). 
>(Hint: See the `man` page for `wc` for an option to return just the line 
>count.)

Finding things
-----------------

We'll close our quick tour of the shell by discussing how to use a well-known 
command line program, `grep`to find lines within files that match a pattern. 
Although `grep` is only one of many searching tools that you might use, it is 
very widely known, relatively simple to learn, and will give us the opportunity 
to briefly examine the topic of "regular expressions".

The basic usage of `grep` involves two arguments, the first giving the string 
to match and the second giving the file to match it in. For example, if we 
wanted to find all of the animals with 3 sightings, we could run

    workshop$ grep 3 sorted_animals.csv
    Tern,3
    Wolf,3

Since `grep` matches text strings, independent of their locations within lines, 
we can also easily search, for example, for all lines containing the letter 
"n".

    workshop$ grep n sorted_animals.csv
    Tern,3
    Wolverine,5

`grep` has lots of flags that change its behavior, and I encourage you to 
review these using `man grep` (or `grep --help` in Git Bash). For example, `-n` 
will print the number line for each match and `-i` makes the search insensitive 
to case.

    workshop$ grep -n o sorted_animals.csv
    1:Fox,1
    5:Wolf,3
    6:Wolverine,5
    workshop$ grep -n -i o sorted_animals.csv
    1:Fox,1
    3:Owl,4
    5:Wolf,3
    6:Wolverine,5

The real power of `grep`, however, comes from its ability to use a special 
language, known as regular expressions, to specify the search patterns. This 
allows us to include wildcards in our searches, and to search for more complex 
patterns than just consecutive letters. Regular expressions are a whole lesson 
unto themselves, but here are a few quick tips:

- `^` stands for the start of a line, and `$` for the end of a line
- `.` stands for any character
- `*` means to match any number of the previous character, so `.*`, for 
  example, matches any number of any character
- [] matches any one of the characters between the brackets

To use regular expressions in our `grep` calls, we use the option `-E` to 
denote that we're using extended regular expression as our pattern. For 
example, here's an expression to find all lines that start with the letter "W"

    workshop$ grep -E '^W' sorted_animals.csv
    Wolf,3
    Wolverine,5

and one to find all the lines in which the second letter is "o".

    workshop$ grep -E '^.o' sorted_animals.csv
    Fox,1
    Wolf,3
    Wolverine,5

>### Exercise 6
>Using regular search strings or regular expressions where necessary, use grep 
>to extract lines from `sorted_animals.csv for which (1) the second letter is a 
>vowel (all animals except Owl), and (2) the line contains an "r" and later an 
>"n" (Tern and Wolverine).

It's usually the case in practice that we'll combine `grep` with pipes and 
redirects to immediately do additional processing on the results of our search. 
That said, a very simple and common use case is `grep TODO *.R`, which 
searches for and prints all of the lines (usually code comments) containing the 
string `TODO` that occur in all of the R files in this directory (the 
`*.R` uses a simple system wildcard to find all files ending with `.R` in 
this directory).

One final note about wildcards - unfortunately, there are several possible 
"languages" for using wildcards that you may encounter, and they are not 
consistent with each other. The other most widely used wildcard syntax is known 
as globbing, and it's what's used by the bash shell by default. The most 
important difference is the `*` symbol, which in "regular" shell commands is 
used to represent any number of characters (like `.*` in a regular expression). 
So `ls *.jpg`, for example, will list all of the JPG files in a directory, `cat 
a*.csv` will print the contents of all csv files starting with the letter "a" 
in a directory, and `mv *rd* /subdir` will move all files containing "rd" into 
subdir.

Wrapping up
-----------

Now that you're expert beginner shell users, here's a final exercise to 
integrate all that we've learned so far.

>### Exercise 5
>
>1. `cd` to your desktop and create a directory called `classes`.
>2. Using `nano`, create two text files in this directory, `fall.txt` and 
>   `spring.txt`, which contain one line for the title and units of each class 
>   that you took (or wanted to take) last fall and that you took/are taking this spring/winter. For example,  `Quantitative Bio (3)`.  If you can't remember or didn't take any, just make some up!
>3. Using pipes, redirects, and/or the programs that we've mentioned so far, 
>   save a file `3_unit_classes.txt` that contains a single number giving the 
>   count of the number of classes you will take this year that are exactly 3 
>   units (or some other unit count, if you didn't take any 3 unit classes).
