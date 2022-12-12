log_model <- logistic_reg() %>% 
  set_engine("LiblineaR")%>% 
  set_mode('classification')%>%
  set_args(penalty = tune())

log_workflow <- workflow() %>% 
  add_model(log_model) %>% 
  add_recipe(recipe)

log_grid <- tibble(penalty = 10^seq(-3, 0, length.out = 10))

library('LiblineaR')
log_res <- log_workflow %>% 
  tune_grid(resamples = train_folds,
            grid = log_grid,
            control = control_grid(save_pred = TRUE),
            metrics = metric_set(roc_auc))
save(log_res, log_workflow, file = "/Users/liusenyuan/Desktop/PSTAT131/FinalProject_Russell/log_res3.rda")

load("/Users/liusenyuan/Desktop/PSTAT131/FinalProject_Russell/log_res3.rda")
autoplot(log_res, metric = "roc_auc")  ##0.001 best
show_best(log_res, metric = "roc_auc") %>% dplyr::select(-.estimator, -.config) #100% penalty=0.001

