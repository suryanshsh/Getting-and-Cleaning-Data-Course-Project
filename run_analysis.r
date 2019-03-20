
library(plyr)
#importing data training, testing and subject
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

y_test<- read.table("./UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
#importing features
features <- read.table("./UCI HAR Dataset/features.txt")
#importing lables of features
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Data Mergin
X_complete = rbind(X_train,X_test)
y_complete = rbind(y_train,y_test)
subject_complete = rbind(subject_train,subject_test)
head(X_complete)

#Extracting only the measurements on the mean and standard deviation for each measurement

features_index<- grep("mean\\(\\)|std\\(\\)",features[,2],)
X_complete<-X_complete[,features_index]


colnames(X_complete)<-grep("mean\\(\\)|std\\(\\)",features[,2],value = T)



colnames(y_complete)<-"activity"
y_complete$label<-factor(y_complete$activity, labels = as.character(activity_labels[,2]))
label<-y_complete$label

colnames(subject_complete)<-"subject"
final_dataframe <- cbind(X_complete,label,subject_complete)


final_mean_tab <- final_dataframe %>% group_by(label, subject) %>% summarise_all(funs(mean))
head(final_mean_tab)

write.table(final_mean_tab, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)


