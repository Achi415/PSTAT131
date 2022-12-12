rf_model <- rand_forest() %>%
  set_mode("classification") %>%
  set_args(min_n = tune())%>%
  set_engine("ranger", importance = "impurity")


rf_workflow <- workflow() %>% 
  add_model(rf_model) %>% 
  add_recipe(recipe)

# define grid  data is small,so only tune min_n
rf_grid <- tibble(min_n = seq(3, 40) )

set.seed(123)
rf_res <- rf_workflow %>% 
  tune_grid(resamples = train_folds,
            grid = rf_grid
  )
save(rf_res, rf_workflow, file = "/Users/liusenyuan/Desktop/PSTAT131/FinalProject_Russell/rf_res3.rda")

set.seed(123)
load("/Users/liusenyuan/Desktop/PSTAT131/FinalProject_Russell/rf_res3.rda")
autoplot(rf_res, metric = "roc_auc")  ##
show_best(rf_res, metric = "roc_auc") %>% select(-.estimator, -.config)

