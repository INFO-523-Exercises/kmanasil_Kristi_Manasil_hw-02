# Required package for quick package downloading and loading 
install.packages("pacman")

# Downloads and load required packages
pacman::p_load(dlookr, # Exploratory data analysis
               formattable, # HTML tables from R outputs
               here, # Standardizes paths to data
               kableExtra, # Alternative to formattable
               knitr, # Needed to write HTML reports
               missRanger, # To generate NAs
               tidyverse) # Powerful data wrangling package suite

# Let's load a data set from the COVID-19 daily testing data set
dataset <- read.csv(here("data", "daily_summary.csv")) 

# What does the data look like?
dataset |>
  head() |>
  formattable()

# What are the properties of the data
dataset |>
  diagnose() |>
  formattable()

# Summary statistics of our numerical columns
dataset |>
  diagnose_numeric() |>
  formattable()

# Table showing outliers
diagnose_outlier(dataset) |>
  filter(outliers_ratio > 0) |>
  formattable()

# Selecting desired columns 
dataset |>
  plot_outlier()

# Create the NA table
dataset |>
  generateNA(p = 0.3) |>
  plot_na_pareto(only_na = TRUE, plot = FALSE) |>
  formattable() # Publishable table

# Plot the intersect of the columns with the most missing values
# This means that some combinations of columns have missing values in the same row
dataset |>
  generateNA(p = 0.3) |>
  select(test_type, test_result, test_count) |>
  plot_na_intersect(only_na = TRUE) 

# Diagnose our categorical columns
dataset |>
  diagnose_category() |> 
  formattable()
diagnose_web_report(dataset)
