# General MATLAB code for handling DIV datasets

>Note 1: the datasets are only available for the members of the [DIV project](http://divproject.eu)


>Note 2: the following instructions will be shown for WP2 data, but the same applies for WP3

### Load data
First you should look at the 3rd line of ```w2exclusionFcn.removeExtraTrials.m```, and modify the array with the trial numbers that you are excluding from the dataset. If you want to keep only the trials from the full factorial design (2x2x3), you should have the following array ```[0 13:19]```.

To load the data, you just have to type the following:
```matlab
w2func.loadData();

```
The variables ```DataWP2``` and ```experimentalTable``` will be loaded.

### Handling of data
You can then use the different functions that are in the ```+common``` folder. Typically, to get extract specific fields of the dataset using the function ```common.getFromData``` as follows.

#### Dataset fields extraction
To extract particular fields from the data, you just have to type the following:
```matlab
[order, timestamps] = common.getFromData(DataWP2, {"orderOfExperiments", "Timestamp"})

```

The cell array can contain ```1``` to ```n``` fieldnames of the DataWP2. Additionally, all the fieldnames under ```DataWP2.Metrics``` are as well extractable using the same function.

#### Some helper functions
There are some helper functions that are present in ```+common```. These functions can extract metrics such as the time-to-arrival of the car or of the cyclist at specific point in time .
