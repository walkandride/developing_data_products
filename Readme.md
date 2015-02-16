__Class:  Developing Data Products__

__Description__

This small Shiny application utilizes the USArrests dataset to demonstrate the following features:

* Some form of user input (widget: textbox, radio button, checkbox, ...)
* Some operation on the ui input in sever.R
* Some reactive output displayed as a result of server calculations

This data set contains statistics, in arrests per 100,000 residents 
for assault, murder, and rape in each of the 50 US states in 1973. 
Also given is the percent of the population living in urban areas.

In an attempt to further explore the data, the states were further categorized
into major regions and sub-divisions as defined in [this Wikipedia page](http://en.wikipedia.org/wiki/List_of_regions_of_the_United_States#Official_regions_of_the_United_States)

By including these filters, one can explore the data from an individual state
point of view all the way to a regional point of view.


__Usage__

When a selection is made from the droplist, observe the results in 
three tabs.  The states that are included in the results are listed 
below the tabs.

* The _plot_ tab displays a scatterplot matrix (which are good for determining rough linear correlations of metadata that contain continuous variable) for the four measurements:  assault, murder, rape, and urban population.
* The _table_ tab displays the measurements for each of the states based upon your selection.
* The _summary_ tab displays summary statistics based upon your selection.





