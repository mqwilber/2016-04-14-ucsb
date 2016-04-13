# ggplot lesson exercise answers

#---------------------------------------------------------------------------------------------------------
# Challenge 1:
## Plot Primates and Carnivora body sizes vs. home range size in the same figure, 
## distinguishing between the two orders.

# use dPlyr or other subsetting functions to select rows and vectors you need:
BrainsnTeeth<-filter(mammals, order == "Primates" | order == "Carnivora") 
str(BrainsnTeeth)
#or
BrainsnTeeth2<-subset(mammals, order == "Primates" | order == "Carnivora", select=c(adult_body_mass_g, home_range_km2, order))
#plot mass x range, and separate by order
ggplot(data=BrainsnTeeth2, aes(y=adult_body_mass_g, x=home_range_km2))+
  geom_point(aes(color=order))+
  scale_x_log10()+
  scale_y_log10()
#Carnivores are bigger and have bigger ranges than primates. Publish!

#---------------------------------------------------------------------------------------------------------

# Challenge 2:
## Make a figure that summarizes mammal body sizes with respect to their range category, 
## and separately for a few different orders? Hint: try a boxplot, and don't forget about `filter`.

summary(mammals$order)  # this summary tells us how many individuals are in each order, which helps us orders that have plenty of individuals to make an interesting plot
BunniesnStuff<-filter(mammals, order=="Lagomorpha"|order=="Artiodactyla"|order=="Soricomorpha")
ggplot(data=BunniesnStuff, aes(y=adult_body_mass_g, x=order))+
  geom_boxplot(aes(color=order))+
  scale_y_log10()+
  facet_grid(RangeCategory~.)
#or somethign like that.  

#---------------------------------------------------------------------------------------------------------
# Challenge 3:
## Yesterday we made this scatter plot: plot(avg_day_inflammation).  Reproduce and improve the inflammation plot we created yesterday.  Hint: ggplot needs a data.frame.
Inflammation<-read.csv(file.choose(), header=T)
str(Inflammation)
#use apply() to calculate means of each row or vector
AvgInflammation<-apply(Inflammation, 2, mean)
str(AvgInflammation)
#because ggplot takes only dataframes for non-summary stats, we need to add an index vector:
MeanInflammation<-data.frame(AvgInflammation, c(1:40))
ggplot(data=MeanInflammation, aes(x=c.1.40., y=AvgInflammation))+
  geom_point()
#we can improve the plot in some ways, although we don't have alot of data to work with:
ggplot(data=MeanInflammation, aes(x=AvgInflammation))+
  geom_histogram()+
  theme_bw()


#---------------------------------------------------------------------------------------------------------
# Challenge 4:
## Using `ggplot` recreate the example plot of rodent and cetacean body size v. litter size 
##  shown in the beginning of the lesson.  For extra challenge, use `plot` in base R.

ggplot(data=TailsnWhales, aes(x=log10(adult_body_mass_g), y=litter_size))+
  geom_point(aes(fill=order, shape=order),color="black", size=5)+
  scale_shape_manual(values=c(24, 21))+
  scale_fill_manual(values=c("light green", "light blue"))+
  ggtitle("Rodents and Cetaceans:\nLitter Size v. Body Size")+
  xlab("Body Mass (g)")+
  ylab("Litter Size")+
  theme_bw()

plot(litter_size~log10(adult_body_mass_g), data=TailsnWhales, 
     main="Rodents and Cetaceans:\nLitter Size v. Body Size",
     xlab="Body Mass (g)",
     ylab="Litter Size")
points(litter_size~log10(adult_body_mass_g), data=TailsnWhales[which(TailsnWhales$order=="Rodentia"),], pch=21, col="black", bg="light blue", cex=1.5)
points(litter_size~log10(adult_body_mass_g), data=TailsnWhales[which(TailsnWhales$order=="Cetacea"),], pch=24, col="black", bg="light green", cex=1.5)

#---------------------------------------------------------------------------------------------------------
# Challenge 5:
## Save one of the figures you made in this lesson, and email it to your advisor, 
## with the subject line "For your refrigerator!"

#set the resolution:
ppi<-300
jpeg(file="Figure1.jpg", width=6, height=8, units="in", res=ppi)  
#opens the graphics device and tells R where to save the next graphical object; 
#it will go to your working directory unless you specify another filepath
#in many journals, a 2-column wide graphic is a little over 6 inches. 
#Most also ask for 300 ppi resolution.  If are making graphics for a presentation you might want higher. 
myplot
#runs the graphics object as defined elsewhere in this exercise...
dev.off() # closes the graphics object.  If you don't, the next figure will overwrite `myplot`




