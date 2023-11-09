
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
devtools::install_github("https://github.com/stat545ubc-2023/countByGeneral.git")
#> Downloading GitHub repo stat545ubc-2023/countByGeneral@HEAD
#> utf8        (1.2.3 -> 1.2.4) [CRAN]
#> withr       (2.5.1 -> 2.5.2) [CRAN]
#> fansi       (1.0.4 -> 1.0.5) [CRAN]
#> vctrs       (0.6.3 -> 0.6.4) [CRAN]
#> rlang       (1.1.1 -> 1.1.2) [CRAN]
#> lifecycle   (1.0.3 -> 1.0.4) [CRAN]
#> curl        (5.0.2 -> 5.1.0) [CRAN]
#> tinytex     (0.46  -> 0.48 ) [CRAN]
#> htmltools   (0.5.6 -> 0.5.7) [CRAN]
#> xfun        (0.40  -> 0.41 ) [CRAN]
#> evaluate    (0.21  -> 0.23 ) [CRAN]
#> knitr       (1.44  -> 1.45 ) [CRAN]
#> vroom       (1.6.3 -> 1.6.4) [CRAN]
#> textshaping (0.3.6 -> 0.3.7) [CRAN]
#> systemfonts (1.0.4 -> 1.0.5) [CRAN]
#> ragg        (1.2.5 -> 1.2.6) [CRAN]
#> lubridate   (1.9.2 -> 1.9.3) [CRAN]
#> ggplot2     (3.4.3 -> 3.4.4) [CRAN]
#> Installing 18 packages: utf8, withr, fansi, vctrs, rlang, lifecycle, curl, tinytex, htmltools, xfun, evaluate, knitr, vroom, textshaping, systemfonts, ragg, lubridate, ggplot2
#> Installing packages into 'C:/Users/User/AppData/Local/Temp/RtmpKyQfxL/temp_libpathe841a583d70'
#> (as 'lib' is unspecified)
#> package 'utf8' successfully unpacked and MD5 sums checked
#> package 'withr' successfully unpacked and MD5 sums checked
#> package 'fansi' successfully unpacked and MD5 sums checked
#> package 'vctrs' successfully unpacked and MD5 sums checked
#> package 'rlang' successfully unpacked and MD5 sums checked
#> package 'lifecycle' successfully unpacked and MD5 sums checked
#> package 'curl' successfully unpacked and MD5 sums checked
#> package 'tinytex' successfully unpacked and MD5 sums checked
#> package 'htmltools' successfully unpacked and MD5 sums checked
#> package 'xfun' successfully unpacked and MD5 sums checked
#> package 'evaluate' successfully unpacked and MD5 sums checked
#> package 'knitr' successfully unpacked and MD5 sums checked
#> package 'vroom' successfully unpacked and MD5 sums checked
#> package 'textshaping' successfully unpacked and MD5 sums checked
#> package 'systemfonts' successfully unpacked and MD5 sums checked
#> package 'ragg' successfully unpacked and MD5 sums checked
#> package 'lubridate' successfully unpacked and MD5 sums checked
#> package 'ggplot2' successfully unpacked and MD5 sums checked
#> 
#> The downloaded binary packages are in
#>  C:\Users\User\AppData\Local\Temp\Rtmpm0GUmU\downloaded_packages
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#>          checking for file 'C:\Users\User\AppData\Local\Temp\Rtmpm0GUmU\remotes7df4508562cc\stat545ubc-2023-countByGeneral-f7c313b/DESCRIPTION' ...  ✔  checking for file 'C:\Users\User\AppData\Local\Temp\Rtmpm0GUmU\remotes7df4508562cc\stat545ubc-2023-countByGeneral-f7c313b/DESCRIPTION'
#>       ─  preparing 'countByGeneral':
#>    checking DESCRIPTION meta-information ...     checking DESCRIPTION meta-information ...   ✔  checking DESCRIPTION meta-information
#>       ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>      Omitted 'LazyData' from DESCRIPTION
#>       ─  building 'countByGeneral_0.1.0.tar.gz'
#>      
#> 
#> Installing package into 'C:/Users/User/AppData/Local/Temp/RtmpKyQfxL/temp_libpathe841a583d70'
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
