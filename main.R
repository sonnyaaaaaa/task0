# import necessary libraries to use functions
library(plyr)
library(dplyr)

# getting a data frame by reading given sample
covidSample <- read.csv(file = 'covid19.csv')

# filtering general sample by Province_State filed to get information about All States
allStates_covidSample = covidSample %>% filter(Province_State == "All States")

# grouping sample by necessary columns
covidSample_withSelectedRows <- data.frame(Country_Region=covidSample$Country_Region, 
                                           positive=covidSample$positive, 
                                           total_tested=covidSample$total_tested)

# adding positive and total_testes columns of rows with the same Country_Region name
addedByCountries_covidSample <- ddply(covidSample_withSelectedRows, "Country_Region", numcolwise(sum));

# creating one more column that show us the diffrenece between total_testes and positive testes
addedByCountries_covidSample$diff <- (addedByCountries_covidSample$total_tested 
                                      - addedByCountries_covidSample$positive)

# detecting positive tested majority by finding the min value of diff column
positive_testes_majority <- addedByCountries_covidSample[which.min(addedByCountries_covidSample$diff),]

# printing the result
print(positive_testes_majority)