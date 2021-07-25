# Apache Spark Exercises

[Download](https://www.kaggle.com/usdot/flight-delays) the dataset *2015 Flight Delays and Cancellations*

**Context**

The U.S. Department of Transportation's (DOT) Bureau of Transportation Statistics tracks the on-time performance of domestic flights operated by large air carriers. Summary information on the number of on-time, delayed, canceled, and diverted flights is published in DOT's monthly Air Travel Consumer Report and in this dataset of 2015 flight delays and cancellations.

**Acknowledgements**

The flight delay and cancellation data was collected and published by the DOT's Bureau of Transportation Statistics.

```
Submit the following: 
For each task upload one .py-script with the code + one screenshot with the code results  (in order to see the final table with all data).
Purpose: evalute the result and do some code review.
```

```
Note: try to use PySpark functions (not only SQL).
```

## Task #1

Find top-5 US airports by the number of delayed frights.

Final DataFrame must contain 2 columns: airport name; number of delayed flights.

## Task #2

Name top-3 avia companies by number of canlcelled flights (in decreasing order)
Final DataFrame must contain 2 columns: company name; number of cancelled flights.

## Task #3
Name top-5 USA states by the most high average flight time for passengers **departing** from these states.

E.g. the passengers departing from Texas (doesn't matter where they fly) spend 4.3 hours flying in average.<br>
The passengers departing from Alaska - spent 7.5 flying in average etc.

Final DataFrame must contain 2 columns - state name; average number of hours flying for those departing from the state.
