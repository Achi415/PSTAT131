svm_model <- svm_rbf( cost  = tune()
) %>%
  set_engine("kernlab")%>%
  set_mode('classification')%>% 
  translate()

svm_workflow <- workflow() %>% 
  add_model(svm_model) %>% 
  add_recipe(recipe)

svm_grid <- tibble(cost = 10^seq(-2, 0, length.out = 10))

set.seed(123)
svm_res <- svm_workflow %>%
  tune_grid(resamples =train_folds,
            grid = svm_grid)
save(svm_res, svm_workflow, file = "/Users/liusenyuan/Desktop/PSTAT131/FinalProject_Russell/svm_res3.rda")

load("/Users/liusenyuan/Desktop/PSTAT131/FinalProject_Russell/svm_res3.rda")
autoplot(svm_res, metric = "roc_auc")  
show_best(svm_res, metric = "roc_auc") %>% select(-.estimator, -.config) #cost=0.2154435	 