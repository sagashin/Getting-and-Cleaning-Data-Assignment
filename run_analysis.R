##Set working directory
setwd("C:/Users/S.Sagara/Documents/Data Science/coursera/R specialization/Getting and clearning data/week4")

##Read data
X_train <- read.table("X_train.txt",sep = "")
y_train <- read.table("y_train.txt",sep = "")
X_test <- read.table("X_test.txt",sep = "")
y_test <- read.table("y_test.txt",sep = "")
features <- read.table("features.txt",sep = "")
sub_train <- read.table("subject_train.txt", sep=" ")
sub_test <- read.table("subject_test.txt", sep=" ")
activity <- read.table("activity_labels.txt")

##Assign names to datasets
names(sub_train) <- "subject"
names(sub_test) <- "subject"
names(y_train) <- "label"
names(y_test) <- "label"
colnames(activity) <- c("label","activity")
fn <- features[,2]
colnames(X_train) <- fn
colnames(X_test) <- fn

##combine data 1
train <- cbind(X_train, sub_train, y_train)
test <- cbind(X_test, sub_test, y_test)

##combine data 2
all <- rbind(train, test)
all <- merge(all, activity, by.x="label", by.y="label")
all <- all[,-1]

##select columns with mean and std as well as subject and activity
ms <- grep("mean|std",fn)
all_sel <- all[,c(ms,562,563)]

##calculate mean by subject and activity using melt and dcast
id <- c("subject", "activity")
vars <- setdiff(colnames(all_sel), id)
melt_data <- melt(all_sel, id = id, measure.vars = vars)
melt <- as.data.table(melt_data)

##create tidy_data
tidy_data <- dcast(melt, subject+activity ~ variable, mean)

##export tidy_data
write.table(tidy_data, file = "tidy_data.txt")



