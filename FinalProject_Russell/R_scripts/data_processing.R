library(tidyverse) 
library(tidymodels) 
library(corrplot) 
library(janitor)
library(skimr)
library(patchwork)
library(lubridate)
library(ranger)
library(rlang)
library(ggplot2)
library(corrr)
library(klaR)
library(MASS)
library(discrim)
library(installr)
library(kernlab)
library(kknn)
library(vip)
library(conflicted)
conflict_prefer("contr.dummy", "kknn")
tidymodels_prefer()
mushroom <- read_csv("mushrooms.csv")

colnames(mushroom)
mushroom <- mushroom %>% 
  clean_names()

head(mushroom)
lapply(mushroom,unique) 
#checking missing values
mushroom %>% sapply(function(x) {sum(is.na(x))})
mushroom$stalk_root[mushroom$stalk_root=='?'] <- 'm'
mushroom<-mushroom %>%
  select(-veil_type)

mushroom1<-mushroom
#colnames(mushroom1)
mushroom1<-mushroom1 %>%
  mutate(class=                    factor(class),
         cap_shape=                factor(cap_shape),
         cap_surface=              factor(cap_surface),
         cap_color=                factor(cap_color),
         bruises=                  factor(bruises),
         odor=                     factor(odor),
         gill_attachment=          factor(gill_attachment),
         gill_spacing=             factor(gill_spacing),
         gill_size=                factor(gill_size),
         gill_color=               factor(gill_color),
         stalk_shape=              factor(stalk_shape),
         stalk_root=               factor(stalk_root),
         stalk_surface_above_ring= factor(stalk_surface_above_ring),
         stalk_surface_below_ring= factor(stalk_surface_below_ring),
         stalk_color_above_ring=   factor(stalk_color_above_ring),
         stalk_color_below_ring=   factor(stalk_color_below_ring),
         veil_color=               factor(veil_color),
         ring_number=              factor(ring_number),
         ring_type=                factor(ring_type),
         spore_print_color=        factor(spore_print_color),
         population=               factor(population),
         habitat=                  factor(habitat),
  )

mushroom2<-mushroom1
mushroom2<-mushroom2 %>%
  mutate(class=                    as.numeric(class),
         cap_shape=                as.numeric(cap_shape),
         cap_surface=              as.numeric(cap_surface),
         cap_color=                as.numeric(cap_color),
         bruises=                  as.numeric(bruises),
         odor=                     as.numeric(odor),
         gill_attachment=          as.numeric(gill_attachment),
         gill_spacing=             as.numeric(gill_spacing),
         gill_size=                as.numeric(gill_size),
         gill_color=               as.numeric(gill_color),
         stalk_shape=              as.numeric(stalk_shape),
         stalk_root=               as.numeric(stalk_root),
         stalk_surface_above_ring= as.numeric(stalk_surface_above_ring),
         stalk_surface_below_ring= as.numeric(stalk_surface_below_ring),
         stalk_color_above_ring=   as.numeric(stalk_color_above_ring),
         stalk_color_below_ring=   as.numeric(stalk_color_below_ring),
         veil_color=               as.numeric(veil_color),
         ring_number=              as.numeric(ring_number),
         ring_type=                as.numeric(ring_type),
         spore_print_color=        as.numeric(spore_print_color),
         population=               as.numeric(population),
         habitat=                  as.numeric(habitat),
  )
#View(mushroom2)

