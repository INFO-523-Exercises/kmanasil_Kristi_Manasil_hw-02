# Sets the number of significant figures to two - e.g., 0.01
options(digits = 2)

# Required package for quick package downloading and loading 
if (!require(pacman))
  install.packages("pacman")

pacman::p_load(dlookr, # Exploratory data analysis
               formattable, # HTML tables from R outputs
               here, # Standardizes paths to data
               kableExtra, # Alternative to formattable
               knitr, # Needed to write HTML reports
               tidyverse) # Powerful data wrangling package suite

# Let's load a data set from the canopy tree data set
dataset <- read.csv(here( "data", "Data_Fig2_Repo.csv")) 

# What does the data look like?
dataset |>
  head() |>
  formattable()

# Summary statistics 
dataset |>
  describe() |>
  formattable()

# Summary statistics, selecting the desired ones
dataset |>
  describe() |>
  select(described_variables, n, na, mean, sd, se_mean, IQR, skewness, kurtosis, p25, p50, p75) |>
  formattable()

#diagnose categorical variable
dataset |>
  diagnose_category() |>
  formattable()

# Group Desprictive Statistics
dataset |>
  group_by(Group) |>
  describe() |>
  select(described_variables, Group, n, na, mean, sd, se_mean, IQR, skewness, kurtosis, p25, p50, p75) |>
  formattable()

# Testing Normality
# Shapiro-Wilk Test
dataset |>
  normality() |>
  formattable()

dataset |>
  plot_normality()

dataset |>
  group_by(Group) |>
  select(Sap_Flow, TWaterFlux, Group) |>
  normality() |>
  formattable()

dataset |>
  group_by(Group) |>
  select(Sap_Flow, TWaterFlux, Group) |>
  plot_normality()

eda_web_report(dataset)
