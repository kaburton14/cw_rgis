library(tidyverse)


# point figure ------------------------------------------------------------
## Shift + Control + M for pipe %>% 
iris%>% 
  ggplot(
    aes(x = Sepal.Length,
        y = Sepal.Width)
  ) +
  geom_point()


## aes(... color= Colorname) to color data by data
iris %>% 
  ggplot(
    aes(x = Sepal.Length,
        y= Sepal.Width,
        color = Species)
    )+
  geom_point()
  

iris %>% 
  ggplot(
    aes(x = Sepal.Length,
        y = Sepal.Width)
  )+
  geom_point(color = "darkgreen")


# Line figure -------------------------------------------------------------

df_x <- tibble(x = 1:50,
       y = 2 * x)

df_x %>%
  ggplot(
    aes(x = x,
        y = y)
  )+
  geom_line()


# Histogram ---------------------------------------------------------------

iris %>% 
  ggplot(
    aes(x = Sepal.Length)
  )+
  geom_histogram()

# Boxplot -----------------------------------------------------------------

iris %>% 
  ggplot(
    aes(x = Species,
        y = Sepal.Length)
  )+
  geom_boxplot()

##  change color border box
iris %>% 
  ggplot(
    aes(x = Species,
        y = Sepal.Length,
        color = Species)
  )+
  geom_boxplot()


## change color inside box
iris %>% 
  ggplot(
    aes(x = Species,
        y = Sepal.Length,
        fill= Species)
  )+
  geom_boxplot()

# Exercise  ---------------------------------------------------------------

#using iris data, identify longest Sepal.Length using arrange()

iris %>% 
  arrange(desc(Sepal.Length))
# using iris data, filter individuals with Sepal.Width greater then 3.0

iris %>% 
  filter(Sepal.Width >3)
# using iris data, select the column "Petal.Length" and "Petal.Width",
# and arrange the order of rows by "Petal.Length" (desc)
# assign the results to object "df_petal"


df_petal<- iris %>%
  select(Petal.Length,Petal.Width) %>% 
  arrange(desc(Petal.Length))

# calculate mean Sepal.Width by species: assign the result to df_mean

df_mean <- iris %>% 
group_by(Species) %>% 
summarize(mean = mean(Sepal.Width))
  
#create a point figure of Petal.Width (y-axis) and sepal.width (x-axis)
# with colors disiniguishing species

iris %>% 
  ggplot(aes(x=Sepal.Width,
             y=Petal.Width,
             color = Species)
         )+
  geom_point()
