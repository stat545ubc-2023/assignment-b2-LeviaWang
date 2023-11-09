
<!-- README.md is generated from README.Rmd. Please edit that file -->

# countByGeneral

<!-- badges: start -->
<!-- badges: end -->

The `countByGeneral` package provides a flexible way to group and
summarize data in R. It is particularly useful when dealing with
categorical data where entries may include commas or when summarizing
date fields by year.

## Description

The main function `count_by_general()` groups data by one or more
specified categorical variables and returns a summary tibble. For each
specified column, only the part before any comma is kept. If a date
column is specified, only the year part of the date is used.

## Installation

You can install the development version of `countByGeneral` from GitHub
with:

``` r
# install.packages("devtools")
devtools::install_github("https://github.com/stat545ubc-2023/countByGeneral.git", upgrade = "never", force = TRUE)
#> Downloading GitHub repo stat545ubc-2023/countByGeneral@HEAD
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#>       ✔  checking for file 'C:\Users\User\AppData\Local\Temp\RtmpCmvnuF\remotes80501fe81a08\stat545ubc-2023-countByGeneral-cce47b3/DESCRIPTION'
#>       ─  preparing 'countByGeneral':
#>    checking DESCRIPTION meta-information ...     checking DESCRIPTION meta-information ...   ✔  checking DESCRIPTION meta-information
#>       ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>      Omitted 'LazyData' from DESCRIPTION
#>       ─  building 'countByGeneral_0.1.0.tar.gz'
#>      
#> 
#> Installing package into 'C:/Users/User/AppData/Local/Temp/RtmpKyQfxL/temp_libpathe848914744'
#> (as 'lib' is unspecified)
```

## Examples

Using the steam_games dataset for the data parameter.

Here will show how the function works when only one categorical
variable(genre) is used for the parameter column_names.

``` r
library(countByGeneral)
library(datateachr)
summary_result <- count_by_general(steam_games, "genre")
summary_result
#> # A tibble: 32 × 2
#>    genre                 count
#>    <chr>                 <int>
#>  1 Accounting                6
#>  2 Action                16290
#>  3 Adventure              6854
#>  4 Animation & Modeling    231
#>  5 Audio Production        122
#>  6 Casual                 6348
#>  7 Design & Illustration   471
#>  8 Early Access              6
#>  9 Education                83
#> 10 Free to Play            577
#> # ℹ 22 more rows
```

The function also works when column_names is a character vector
containing the names of two categorical grouping variables (genre,
languages).

``` r
library(countByGeneral)
library(datateachr)
summary_result <- count_by_general(steam_games, c("genre", "languages"))
summary_result
#> # A tibble: 66 × 3
#>    genre      languages          count
#>    <chr>      <chr>              <int>
#>  1 Accounting English                6
#>  2 Action     Czech                  3
#>  3 Action     Danish                 1
#>  4 Action     English            16272
#>  5 Action     German                 2
#>  6 Action     Japanese               2
#>  7 Action     Russian                2
#>  8 Action     Simplified Chinese     1
#>  9 Action     Turkish                1
#> 10 Action     <NA>                   6
#> # ℹ 56 more rows
```
