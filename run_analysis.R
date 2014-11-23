## Reads a data set from a file and combines subjects and activities, and names the variables
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

## Simply merges the test and training data sets
mergeDataSets <- function(data1, data2) {
    rbind(data1, data2)
}

## Provides the mean and stddev columns
extractMeanAndStd <- function(data) {
    ## Which columns contain the mean and the std? Use the column names to find
    ## out which ones to extract. We use a regex to do this.
    columns <- grep("mean\\(\\)|std\\(\\)",colnames(data))
    data[c(1,2,columns)]
}

## Replace the activity column with activity names
mergeActivities <- function(data, labelsFile) {
    labels <- read.table(labelsFile)
    f <- factor(labels$V2)
    data$activity <- factor(data$activity, levels = labels$V1, labels = f)
    data
}

## Produces tidy data from a clean data set (i.e. subject, activity factors, and data vars)
tidyData <- function(data) {
    ## Create a new data frame based on data dimensions
    ##newData <- data.frame(matrix(nrow=0, ncol=ncol(data)))
    newData <- NULL;
    
    ## Unique subjects
    subjects <- unique(data$subject)
    
    ## Unique activities
    activities <- unique(data$activity)
    
    ## Iterate over all subjects and activities, calculating the mean for each variable
    numColumns <- ncol(data)
    for (subject in subjects) {
        for (activity in activities) {
            ssData <- subset(data, subject == subject & activity == activity, select = 3:ncol(data))
            means <- data.frame(colMeans(ssData))
            newData <- rbind(newData,data.frame(subject=subject, activity=activity, t(means), stringsAsFactors=TRUE))
        }
    }
    
    ## Finally, set our column names and return
    names(newData) <- names(data)
    newData
}

## Executes all five steps of the assignment
run_analysis <- function(basepath = "UCI HAR Dataset") {
    ## All the files we load
    activityLabelsFile <- paste(basepath, "activity_labels.txt", sep="/")
    featuresFile <- paste(basepath, "features.txt", sep="/")
    xtestFile <- paste(basepath, "test", "X_test.txt", sep="/")
    xtestsubjectsFile <- paste(basepath, "test", "subject_test.txt", sep="/")
    xtestactivitiesFile <- paste(basepath, "test", "y_test.txt", sep="/")
    xtrainFile <- paste(basepath, "train", "X_train.txt", sep="/")
    xtrainsubjectsFile <- paste(basepath, "train", "subject_train.txt", sep="/")
    xtrainactivitiesFile <- paste(basepath, "train", "y_train.txt", sep="/")
    
    ## Load the data
    data1 <- readAndCombineDataSet(xtestFile, xtestsubjectsFile, xtestactivitiesFile, featuresFile)
    data2 <- readAndCombineDataSet(xtrainFile, xtrainsubjectsFile, xtrainactivitiesFile, featuresFile)
    
    ## Merge the data
    mergedData <- mergeDataSets(data1, data2)
    
    ## Extract mean and std
    meanStdData <- extractMeanAndStd(mergedData)
    
    ## Add activity names
    completeData <- mergeActivities(meanStdData, activityLabelsFile)
    
    ## Tidy up
    tidy <- tidyData(completeData)
    
    ## Sort based on subject and return
    tidy[order(tidy$subject),]
    
}