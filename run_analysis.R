install.packages("dplyr")
library(dplyr)
#file a  path
pathdata <- file.path("./Data/Course3week4/UCI HAR Dataset")
files <- list.files(pathdata, recursive = TRUE)
#show whicht files are available
files

#Create datasets
#Reading xtrain /ytrain, subject train.
xtrain <- read.table(file.path(pathdata, "train", "X_train.txt"), header = FALSE)
ytrain <- read.table(file.path(pathdata, "train", "y_train.txt"), header = FALSE)
subject_train <- read.table(file.path(pathdata, "train", "subject_train.txt"), header = FALSE)

#Reading the testing variables
xtest <- read.table(file.path(pathdata, "test", "X_test.txt"), header = FALSE)
ytest <- read.table(file.path(pathdata, "test", "y_test.txt"), header = FALSE)
subject_test <- read.table(file.path(pathdata, "test", "subject_test.txt"), header = FALSE)

#Reaging feature data
features <- read.table(file.path(pathdata, "features.txt"), header = FALSE)

#Read activity labels data
activityLabels <- read.table(file.path(pathdata, "activity_labels.txt"),header = FALSE)

#Give colomn names train data
colnames(xtrain) <- features[,2]
colnames(ytrain) <- "activityId"
colnames(subject_train) <- "subjectId"

#Give colomn names test data
colnames(xtest) <- features[,2]
colnames(ytest) <- "activityId"
colnames(subject_test) <- "subjectId"

#Create sanity check for the activity labels value
colnames(activityLabels) <- c('activityId','activityType')


###########
#QUESTION 1
###########
#Mergin the train and the test data
mergetest <- cbind(ytest,subject_test, xtest)
mergetrain <- cbind(ytrain, subject_train, xtrain)

#merge the 2 datasets together
df_train_test <- rbind(mergetest, mergetrain)

###########
#QUESTION 2
###########
colnames <- colnames(df_train_test)
#Use grpl function to get the columns
mean_and_std <- (grepl("activityId" , colnames) | grepl("subjectId" , colnames) | grepl("mean.." , colnames) | grepl("std.." , colnames))
#Get all the TRUE and create a new dataset
data_mean_std <- df_train_test[ , mean_and_std== TRUE]


###########
#QUESTION 3
###########
#Desciptive activity names
activityNames <- merge(data_mean_std, activityLabels, by="activityId", all.x =TRUE)

###########
#QUESTION 4 - Already done above
###########

###########
#QUESTION 5
###########

#aggregate: Splits the data into subsets, computes summary statistics for each, and returns the result in a convenient form.
secTidySet <- aggregate(. ~subjectId + activityId, activityNames, mean)

secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]


write.table(secTidySet, "secTidySet.txt", row.name=FALSE)













