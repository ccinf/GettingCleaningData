function readAndCombineDataSet(dataFile, subjectFile, activityFile) {
    data <- read.table(dataFile)
    subjects <- read.table(subjectFile)
    activities <- read.table(activityFile)
    
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
    
    # Combine data and return table 
    combined <- cbind(activities, data)
    cbind(subjects, combined)
}

function combineDataSets(data1, data2) {
    
}

function extractMeanAndStd(data) {
    
}

function readActivities(labelsFile) {
    read.table(labelsFile)
}

function readSubjects(subjectsFile) {
    read.table(subjectsFile)
}

function mergeActivities(data, labelsData) {
    
}

function mergeSubjects(data, subjectsData) {
    
}

function tidyData {
    
}

