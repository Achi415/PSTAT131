knn_model <- nearest_neighbor() %>%
  set_engine("kknn")%>%
  set_mode("classification") %>%
  set_args(neighbors = tune())


knn_workflow <- workflow() %>% 
  add_model(knn_model) %>% 
  add_recipe(recipe)

# define grid
knn_grid <- tibble(neighbors = seq(1, 30,length.out=10))

set.seed(123)
knn_res <- knn_workflow %>% 
  tune_grid(resamples = train_folds,
            grid = knn_grid
  )
save(knn_res, knn_workflow, file = "/Users/liusenyuan/Desktop/PSTAT131/FinalProject_Russell/knn_res3.rda")

set.seed(123)
load("/Users/liusenyuan/Desktop/PSTAT131/FinalProject_Russell/knn_res3.rda")
autoplot(knn_res, metric = "roc_auc")  
show_best(knn_res, metric = "roc_auc") %>% select(-.estimator, -.config)  #k=1