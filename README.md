# store-data-analysis
Shiny App - Analysis of Store Transaction Data

This data set follows supermarket sales across 3 cities in Myanmar between January and March of 2020.
There are 1,000 observations in the data set, each observation represents 1 transaction.
For each transaction, information is available about customer demographic, purchase location, and financial details. All monetary values are in Myanmar Kyat.

This Shiny app aggregates the data from the data set into 4 visualizations:

1. Total Frequency by Gender -  Histogram that shows frequencies of transaction totals by gender.
2. Total Purchase by Project Type – Stacked bar plot organized for each week contained in the data set. Each product type is represented in the total purchase amount per week.
3. Total by City – Box plot showing the distribution of total transaction amounts for each of the 3 cities in the data set.
4. Purchase by Payment Type – Pie chart showing the percentage breakdown of purchases for each of the 3 methods of payment in the data set.

Data for the visualizations can be filtered by any combination of Product Line, City, Payment Type, and Gender. Results will recalculate automatically when a new filter is chosen.

The bin width of the Total Frequency by Gender visualization can also be adjusted from the sidebar menu.
