run_analysis.R script is used to analyze and clean the data set into a tidy data for further analysis.

Data Files: 
Assume source data (all text files) are downloaded and stored in the same folder of this script
Folder structure and location of files is illustrated as below
   run_analysis.R
  >UCI HAR Dataset
     activity_labels.txt
     features.info.txt
     features.txt
     >test
        subject_test.txt
        X_test.txt
        y_test.txt
     >train
        subject_train.txt
        X_train.txt
        y_train.txt

What the script does?
Step 1. Read activity labels and features (activity_labels.txt and features.txt) into R
Step 2. Keep only those columns of mean and standard deviation
Step 3. Combine training and test data into one file, then add column names
Step 4. Turn activities & subjects into factors for gathering data
Step 5. Export result to a text file