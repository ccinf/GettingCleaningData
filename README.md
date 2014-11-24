GettingCleaningData
===================

The run_analysis.R script reads the UCI HAR Dataset test and training data and produces a tidy data set containing the averages of mean and standard deviation data per subject and activity.

The script contains six functions: one convenience function that requires only the UCI HAR Dataset directory to produce the tidy data set, and five functions that load, merge, and clean the raw data. Users need only to use the run_analysis convenience function.

**run_analysis(basepath = "UCI HAR Dataset")**

If the UCI HAR Dataset directory is not in the working directory, the user can provide a path to it.

**readAndCombineDataSet(dataFile, subjectFile, activityFile, featuresFile)**

Reads a measurements data set, corresponding subjects and activities, and feature names. It combines the subjects and activities with the measurements, then assigns measurement data column names based on the features file.

**mergeDataSets(data1, data2)**

Simply merges the test and train data sets. Requires data frames to be in the format provided by readAndCombineDataSet()

**extractMeanAndStd(data)**

Extracts mean and stddev data based on data frame column names. Requires the data frame to be in the format provided by readAndCombineDataSet(), and provides the same.

**mergeActivities(data, labelsFile)**

Recodes the numeric activity identifier with the corresponding label. Requires the data frame to be in the format provided by readAndCombineDataSet(), and provides the same.

**tidyData(data)**

Computes averages of measurement columns per subject and per activity. Requires the data frame to be in the format provided by readAndCombineDataSet(), and provides a tidy data set in the same format.