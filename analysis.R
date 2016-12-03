library(data.table)
library(caret)
library(pROC)


mushrooms <- fread("DDPAssignment/mushrooms.csv",stringsAsFactors = TRUE)

mushrooms$`veil-type` <- NULL

tc <- trainControl(method = "repeatedcv", 
                   number = 5 ,
                   repeats = 5, 
                   summaryFunction = twoClassSummary, 
                   classProbs = TRUE,
                   verboseIter = TRUE)

model <- train(class ~ `spore-print-color` + `gill-color` + `gill-size` + `stalk-root` + population + habitat
               , data=mushrooms 
               , trControl=tc
               , method="ranger"
               , metric="ROC"
               , importance = 'impurity'
               )

# feature selection
mushroomsClass <- mushrooms$class
mushroomsPreds <- mushrooms
mushroomsPreds$class <- NULL
control <- rfeControl(functions=rfFuncs, method="cv", number=10)
results <- rfe(mushroomsPreds, mushroomsClass, sizes=c(1:22), rfeControl=control)
print(results)
predictors(results)
plot(results, type=c("g", "o"))


