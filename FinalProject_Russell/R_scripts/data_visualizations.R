theme <- theme(plot.title = element_text(hjust = 0.3, face = "bold"))

mushroom%>%
  ggplot(aes(x = factor(class), 
             y = stat(count), fill = factor(class),
             label = scales::comma(stat(count)))) +
  geom_bar(position = "dodge") + 
  geom_text(stat = 'count',
            position = position_dodge(.9), 
            vjust = -0.5, 
            size = 3) + 
  scale_y_continuous(labels = scales::comma)+
  labs(x = 'Mushroom class', y = 'Count') +
  ggtitle("Distribution of mushroom Class") +
  theme

correlation <- cor(mushroom2)
corrplot(correlation,tl.cex = 0.5, number.cex = 0.5, method = "number", type = "upper",title ='correlation matrix')
#sort(correlation[,1],decreasing=T)

library("randomForest")
set.seed(123)
m <- data.frame(mushroom2[, -1])
quick_RF <- randomForest(x = m, y = mushroom2$class, ntree=20,importance=F)
imp_RF <- importance(quick_RF)
imp_DF <- data.frame(Variables = row.names(imp_RF), MSE = imp_RF[,1])
imp_DF <- imp_DF[order(imp_DF$MSE, decreasing = TRUE),]

ggplot(imp_DF[1:20,], aes(x=reorder(Variables, MSE), y=MSE, fill=MSE)) + 
  geom_bar(stat = 'identity') + 
  labs(x = 'Variables', y= '% increase MSE if variable is randomly permuted') + 
  coord_flip() + 
  theme(legend.position="none")

mushroom1 %>%
  ggplot(aes(x = odor, 
             y = stat(count), fill = class)) +
  geom_bar( ) +
  facet_wrap(~class, scales = "free_y") +
  labs(
    title = "Distribution of the odor by mushroom class  "
  )+
  theme

mushroom1 %>%
  ggplot(aes(x = class, 
             y = stat(count), fill = class)) +
  geom_bar( ) +
  facet_wrap(~gill_size, scales = "free_y") +
  labs(
    title = "Distribution of the mushroom class by gill size"
  )+
  theme

