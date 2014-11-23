readAndCombineDataSet <- function(dataFile, subjectFile, activityFile, featuresFile) {
    data <- read.table(dataFile)
    subjects <- read.table(subjectFile)
    activities <- read.table(activityFile)
    features <- read.table(featuresFile)
    
    ## Check that our columns match our features
    numColumns <- ncol(data)
    numFeatures <- nrow(features)
    if (!(numColumns == numFeatures)) {
        message("Number of features and variables do not match")
        return()
    }
    
    ## Name our columns
    colnames(data) <- as.vector(features$V2)
    
    ## Check that our sizes match
    dataSize <- nrow(data)
    subjectSize <- nrow(subjects)
    activitySize <- nrow(activities)
    if ( !(dataSize == subjectSize)) {
        message("Data size and subject size not equal!")
        return()
    }
    if ( !(dataSize == activitySize)) {
        message("Data size and activity size not equal!")
        return()
    }
    
    # Combine data, activities, and subjects 
    combined <- cbind(activities, data)
    combined <- cbind(subjects, combined)
    
    # Name the first two columns appropriately
    names <- colnames(combined)
    names[1] = "subject"
    names[2] = "activity"
    colnames(combined) <- names
    
    # Name the remainder of the columns
    
    
    # Return the data frame
    combined
}

combineDataSets <- function(data1, data2) {
    rbind(data1, data2)
}

extractMeanAndStd <- function(data) {
    ## Which columns contain the mean and the std? Use the column names to find
    ## out which ones to extract. We use a regex to do this.
    columns <- grep("mean\\(\\)|std\\(\\)",colnames(data))
    data[columns]
}

## Replace the activity column with activity names
mergeActivities <- function(data, labelsFile) {
    labels <- read.table(labelsFile)
    f <- factor(labels$V2)
    data$activity <- factor(data$activity, levels = labels$V1, labels = f)
    data
}

tidyData <- function() {
    
}

