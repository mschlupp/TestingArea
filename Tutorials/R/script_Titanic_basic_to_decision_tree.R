
setwd("~/TestingArea/Tutorials/R")

train<-read.csv("train.csv")

test<-read.csv("test.csv")

head(train,2)

tail(test,2)

str(train)

head(train$Survived,4) # separate a column from the dataset ($ operator)

table(train$Survived) # table sums occurances in the train$Survived column

prop.table(table(train$Survived)) 

test$Survived <- rep(0,418)

head(test,2) # check if survived column is present now?

summary(train$Sex)

prop.table(table(train$Sex, train$Survived),1) #1,2 for horizontal (row) or vertical (column) proportion

test$Survived <- 0
test$Survived[test$Sex=='female'] <- 1

summary(train$Age)

train$Child <- 0
train$Child[train$Age<18] <- 1

aggregate(Survived ~ Child + Sex, data=train, FUN=sum)

aggregate(Survived ~ Child + Sex, data=train, FUN=length)

aggregate(Survived ~ Child + Sex, data = train, FUN=function(x){sum(x)/length(x)})

train$Fare2 <- '30+'

train$Fare2[train$Fare>=20 & train$Fare<30] <- '20-30'

train$Fare2[train$Fare>=10 & train$Fare<20] <- '10-20'

train$Fare2[train$Fare<10] <- '<10'

aggregate(Survived ~ Fare2 + Pclass + Sex, data=train, FUN=function(x){sum(x)/length(x)})

test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1
test$Survived[test$Sex == 'female' & test$Pclass==3 & test$Fare>=20] <- 0

test$Survived[test$Sex=='male' & test$Pclass==1 & test$Fare>=10 & test$PassengerId %% 10<=3] <- 1

head(subset(test, test$Sex=='male' & test$Pclass==1 & test$Fare>10),4)

prop.table(table(test$Survived[test$Sex=='male' & test$Pclass==1 & test$Fare>10]))

prop.table(summary(train$Sex))

library(rpart)

decTree <- rpart(Survived~ Pclass + Sex + Age + SibSp + Parch+ Fare+ Embarked, 
     data = train,
     method = "class")

plot(decTree)
text(decTree)

library(rattle)
library(rpart.plot)
library(RColorBrewer)


fancyRpartPlot(decTree)

decTreeOverfit <- rpart(Survived~Pclass+Sex+Age+SibSp+Parch+Fare+Embarked,
                       data=train,
                       method='class',
                       control = rpart.control(minsplit=2, cp=0))

dt_prediction <- predict(decTree, test, type='class')

test$Survived <- dt_prediction

solution <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)

write.csv(solution, file="solution.csv", row.names=FALSE) # not exactly sure if Kaggle allows for row names. to be tested
