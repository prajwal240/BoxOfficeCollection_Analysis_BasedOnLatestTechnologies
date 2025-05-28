## Box Office Collection Prediction Based on VFX Shots and Release Format
 
This R script performs data analysis and linear regression modeling to predict box office collections based on the number of VFX shots and the release format of movies. It also visualizes the results using multiple ggplot2 graphs.

## Features

Reads Excel input data containing:
Number of VFX shots
Release format (e.g., 2D, 3D, IMAX, 3D + IMAX)
Box office collection
Handles missing values by removing incomplete rows
Detects and removes extreme outliers using Z-scores
Encodes Release_Format as a categorical variable
Builds a linear regression model with interaction terms
Evaluates the model using R² and residual plots
Predicts box office collection for custom inputs
Generates visualizations for analysis

## Requirements

R (version 4.0 or above recommended)
Required Libraries:
library(ggplot2)
library(readxl)

## How to Use

Clone or download this repository.
Open the R script in RStudio.
When prompted, select the .xlsx file provided.

### The script will:
Load and clean data
Build and evaluate a regression model
Predict for custom input (2500 VFX shots in IMAX is hardcoded in given code)
Save plots to your working directory

## Sample Dataset Format

| Movie\_Title                     | box\_office | CGI\_Used | Release\_Format | vfx\_shots |
| -------------------------------- | ----------- | --------- | --------------- | ---------- |
| Avatar: The Way of Water         | 2320000000  | High      | 3D,IMAX         | 4001       |
| Top Gun: Maverick                | 1490000000  | Medium    | IMAX            | 2400       |
| Jurassic World Dominion          | 1000000000  | High      | 3D,IMAX         | 1450       |
| Doctor Strange in the Multiverse | 950000000   | High      | 3D,IMAX         | 2500       |
| Black Panther: Wakanda Forever   | 850000000   | High      | 3D,IMAX         | 2233       |
