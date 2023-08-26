# HW ML Part 1

library(tidyverse)
library(caret)

glimpse(House_Price_India)

nrow(House_Price_India)

train_test_split <- function(data,trainRattio=0.7){
  set.seed(93)
  (n <- nrow(data))
  (id <- sample(1:n, size=trainRattio*n))
  train_data <- data[id,]
  test_data <- data[-id, ]
  list(train = train_data, test = test_data)
}

mae_metric <- function(actual, prediction){
  # mean absolute error
  abs_error <- abs(actual - prediction)
  mean(abs_error)
}

mse_metric <- function(actual, prediction){
  # mean squared error
  sq_error <- (actual - prediction)**2
  mean(sq_error)
}
  
rmse_metric <- function(actual, prediction){
  # root mean squared error
  sq_error <- (actual - prediction)**2
  sqrt(mean(sq_error)) ## back to normal unit
}

# 1.split data 70:30
spliteData <- train_test_split(House_Price_India, 0.8)
train_data <- spliteData[[1]]
test_data <- spliteData[[2]]

# normalize model
train_data$Price_norm <- log(train_data$Price)
test_data$Price_norm <- log(test_data$Price)

# 2.train
set.seed(93)

ctrl <- trainControl(
  method = "CV",
  number = 5,
  verboseIter = F
)

lm_model <- train(Price_norm ~ living_area_renov+
                    lot_area_renov+
                    `grade of the house`+
                    `Built Year`+
                    `Renovation Year`,
                  data = train_data,
                  method = "lm",
                  trControl = ctrl)
lm_model

# 3.score
pred <- predict(lm_model, newdata = test_data)

# 4.evaluate
rmse_metric(test_data$Price_norm, pred)
mse_metric(test_data$Price_norm, pred)
mae_metric(test_data$Price_norm, pred)
