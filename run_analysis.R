library(dplyr)

# Downlaod rawdata
filename <- "raw_data.zip"
if (!file.exists(filename)){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", filename, method="curl")
}

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load the X data
vars <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
X_set <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
X_set <- rbind(X_set, read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE))
names(X_set) <- vars$V2

# Load the Y data
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
Y_set <- read.table("UCI HAR Dataset/test/Y_test.txt", header = FALSE)
Y_set <- rbind(Y_set, read.table("UCI HAR Dataset/train/Y_train.txt", header = FALSE))
names(Y_set) <- "ActivityName"
Y_set$ActivityName <- activity_labels$V2[Y_set$ActivityName]

# Load the subject data
subject_set <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
subject_set <- rbind(subject_set, read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE))
names(subject_set) <- "subject"

# Extract only the mean and std columns
X_set <- X_set[, which(grepl('mean\\(\\)|std\\(\\)', names(X_set)))]

# Combine the X and Y data
complete_set <- cbind(X_set, Y_set, subject_set)

# Clean up the column names
names(complete_set) <- gsub("-mean\\(\\)", " Mean", names(complete_set))
names(complete_set) <- gsub("-std\\(\\)", " Standard Deviation", names(complete_set))
names(complete_set) <- gsub("^t", "Time ", names(complete_set))
names(complete_set) <- gsub("^f", "Frequency ", names(complete_set))
names(complete_set) <- gsub("-X$", " X", names(complete_set))
names(complete_set) <- gsub("-Y$", " Y", names(complete_set))
names(complete_set) <- gsub("-Z$", " Z", names(complete_set))

# Group the data
grouped_data <- complete_set %>%
  group_by(subject, ActivityName) %>%
  summarise_all(list(mean = mean))

write.csv(grouped_data, file="grouped_data.csv", row.names=FALSE)
