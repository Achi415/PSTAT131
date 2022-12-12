bt_model <- boost_tree() %>%
  set_engine("xgboost") %>%
  set_mode("classification") %>% 
  set_args(learn_rate = tune()) 

bt_workflow <- workflow() %>% 
  add_model(bt_model) %>% 
  add_recipe(recipe)

# define grid
bt_grid <- tibble(learn_rate= 10^seq(-3, 0, length.out = 20))

set.seed(123)
bt_res <- bt_workflow %>%
  tune_grid(resamples = train_folds,
            grid = bt_grid)
save(bt_res, bt_workflow, file = "/Users/liusenyuan/Desktop/PSTAT131/FinalProject_Russell/bt_res3.rda")

set.seed(123)
load("/Users/liusenyuan/Desktop/PSTAT131/FinalProject_Russell/bt_res3.rda")
autoplot(bt_res, metric = "roc_auc")  
show_best(bt_res, metric = "roc_auc") %>% select(-.estimator, -.config) #0.1623777


set.seed(123)
bt_workflow_tuned <- bt_workflow %>% 
  finalize_workflow(select_best(bt_res, metric = "roc_auc"))
bt_final <- fit(bt_workflow_tuned, train)