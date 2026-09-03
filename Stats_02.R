
library(tidyverse)

set.seed(123)

iris_sub <- as_tibble(iris) %>% 
  group_by(Species) %>% 
  sample_n(3) %>% 
  ungroup()

print(iris_sub)

filter(iris_sub, Species == "virginica") 
filter(iris_sub, Species %in% c("virginica", "versicolor"))
filter(iris_sub, Species != "setosa")
filter(iris_sub, Petal.Length >5 & Sepal.Length > 5)



arrange(iris_sub,Sepal.Width)

# Assignment
iris_3 <- filter(iris_sub, Sepal.Width >3)

# Select
select(iris_sub, Sepal.Length)
select(iris_sub,c(Sepal.Length, Sepal.Width))
select(iris_sub, -Sepal.Length)
select(iris_sub, contains("al."))


# Mutate
(x_max <- nrow(iris_sub))
x <- 1:x_max

mutate(iris_sub, row_id = x)
mutate(iris_sub,mu_sl = mean(Sepal.Length))
mutate(iris_sub, sep.area = Sepal.Length * Sepal.Width / 2)
mutate(group_by(iris_sub, Species), mus_sl = mean (Sepal.Length))


# Pipe
iris_sub |>
filter(Species == "virginica")

# grouping by "Species", then take means "Speal.Length" for each species
iris_sub %>% 
  group_by(Species) %>% 
  mutate(mu_sl = mean(Sepal.Length)) %>% 
  ungroup()

(iris_pipe <- iris_sub |> 
  filter(Species == "setosa") |>
  mutate(pw_2times = 2*Petal.Width))

mean(iris_sub$Sepal.Length)                  

iris_sub |> 
  group_by(Species) |> 
  summarize(mu_sl = mean(Sepal.Length),
            sum_sl = sum(Sepal.Length))
