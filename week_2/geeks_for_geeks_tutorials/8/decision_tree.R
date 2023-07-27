install.packages('datasets')
install.packages('caTools')
install.packages('party')
install.packages('dplyr')
install.packages('magrittr')

library(datasets)
library(caTools)
library(party)
library(dplyr)
library(magrittr)

data("readingSkills")
head(readingSkills)

# Split data
data <- sample.split(readingSkills, SplitRatio = 0.8)
train_set <- subset(readingSkills, data == TRUE)
test_set <- subset(readingSkills, data = FALSE)

# create model
dc_model <- ctree(nativeSpeaker ~ ., train_set)
plot(dc_model)


# predict model on test data
prediction <- predict(dc_model, test_set)

# creating a table to count how many are classified as native speakers and how many are not
count_table <- table(test_set$nativeSpeaker, prediction)
count_table

# Accuracy
ac_test <- sum(diag(count_table)) / sum(count_table)
print(paste("Accuracy for test set is found to be: ", ac_test))














