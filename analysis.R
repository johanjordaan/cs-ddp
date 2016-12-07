library(data.table)
library(caret)
library(pROC)


mushrooms <- fread("mushrooms/mushrooms.csv",stringsAsFactors = TRUE)
names(mushrooms) <- gsub("-","_",names(mushrooms))

#mushrooms$`veil-type` <- NULL

tc <- trainControl(method = "repeatedcv", 
                   number = 5 ,
                   repeats = 5, 
                   summaryFunction = twoClassSummary, 
                   classProbs = TRUE,
                   verboseIter = TRUE)

model <- train(class ~ spore_print_color + gill_color + gill_size + stalk_root + population + habitat
               , data=mushrooms 
               , trControl=tc
               , method="ranger"
               , metric="ROC"
               , importance = 'impurity'
               )


myData <- mushrooms[1:10,]

tc <- trainControl(method = "repeatedcv", 
                   number = 5 ,
                   repeats = 5, 
                   summaryFunction = twoClassSummary, 
                   classProbs = TRUE,
                   verboseIter = TRUE)

model <- train(class ~ spore_print_color + gill_color + gill_size + stalk_root + population + habitat
               , data=myData 
               , trControl=tc
               , method="ranger"
               , metric="ROC"
               , importance = 'impurity'
)




saveRDS(model,"DDPAssignment/model.rds")

d <- data.frame(spore_print_color=c("k","k"),
                gill_color=c("k","k"),
                gill_size=c("n","n"),
                stalk_root=c("e","e"),
                population=c("s","s"),
                habitat=c("u","u"))

# feature selection
mushroomsClass <- mushrooms$class
mushroomsPreds <- mushrooms
mushroomsPreds$class <- NULL
control <- rfeControl(functions=rfFuncs, method="cv", number=10)
results <- rfe(mushroomsPreds, mushroomsClass, sizes=c(1:22), rfeControl=control)
print(results)
predictors(results)
plot(results, type=c("g", "o"))


