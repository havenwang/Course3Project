Described below is script `run_analysis.R`, which cleans and prepares the UCI HAR dataset.

## Download the data

* Download the data into a zipfile called `raw_data.zip`

## Loading all the data

* The raw set of feature names is loaded from `features.txt` into the variable `vars`
* The raw X data from `X_test.txt` and `X_train.txt` is read and combined into `X_set`
* The activity names for numbers are loaded from `activity_labels.txt` into the variable `activity_labels`
* The raw Y data from `Y_test.txt` and `Y_train.txt` is read and combined into `Y_set`
* The raw subject data from `subject_test.txt` and `subject_train.txt` is read and combined into `subject_set`

## Extract only mean and standard deviation measurements

* Modify `X_set` so that we keep only columns that include `mean()` or `std()` in the column name

## Combine all the data into a single data set

* Combine `X_set`, `Y_set`, `subject_set` into a single data set `complete_set`

## Clean up some of the column names

* Rename `mean()` to `Mean`, and `std()` to `Standard Deviation`
* Rename names beginning with `t` to say `Time`, and beginning with `f` to say `Frequency`
* Clean up the `-` before `-X`, `-Y`, `-Z` to have a space

## Group the data by subject and activity

* Group the data by subject and activity using dplyr `group_by`

## Take the mean of measurements for subject and activity groups

* Use `summarise_all` to take the means of subject and activity groups and save into variable `grouped_data`

## Export the data

* Export the data as a CSV to a file `grouped_data.csv`