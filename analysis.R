library(data.table)
library(caret)
library(pROC)


mushrooms <- fread("mushrooms.csv",stringsAsFactors = TRUE)
names(mushrooms) <- gsub("-","_",names(mushrooms))
mushrooms$`veil_type` <- NULL

tc <- trainControl(method = "repeatedcv", 
                   number = 2 ,
                   repeats = 1, 
                   #summaryFunction = twoClassSummary, 
                   #classProbs = TRUE,
                   verboseIter = TRUE)

spore_print_color + gill_color + gill_size + stalk_root + population + habitat
gill_size + spore_print_color

lapply(mushrooms,unique)


#cap-shape: bell=b,conical=c,convex=x,flat=f, knobbed=k,sunken=s
#cap-color: brown=n,buff=b,cinnamon=c,gray=g,green=r,pink=p,purple=u,red=e,white=w,yellow=y
#gill-color: black=k,brown=n,buff=b,chocolate=h,gray=g, green=r,orange=o,pink=p,purple=u,red=e,white=w,yellow=y
#stalk-shape: enlarging=e,tapering=t
#stalk-root: bulbous=b,club=c,cup=u,equal=e,rhizomorphs=z,rooted=r,missing=?
#population: abundant=a,clustered=c,numerous=n,scattered=s,several=v,solitary=y
#habitat: grasses=g,leaves=l,meadows=m,paths=p,urban=u,waste=w,woods=d


model <- train(class ~ cap_shape + cap_color + gill_color + stalk_shape  +stalk_root +population + habitat , 
               data=mushrooms
               ,trControl=tc
               , method="rf"
               #, metric="ROC"
               #, importance = 'impurity' # Ranger
               )

confusionMatrix(model)
fancyRpartPlot(model$finalModel)

saveRDS(model,"mushrooms/model.rds")

head(model$finalModel$importance[order(model$finalModel$importance,decreasing=TRUE),])



