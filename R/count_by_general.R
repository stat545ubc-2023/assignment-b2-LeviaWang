#' Generalized Count Function
#'
#' This function groups data by one or more categorical variables and returns a summary tibble.
#' For each specified column, if a value contains a comma, only the part before the comma is kept.
#' If a date column is specified, only the year is kept.
#'
#' @param data A data frame.The data should be the raw data frame from which the user wants to extract information.
#' @param column_names character vectors containing the names of the columns to group by. It could be one or more
#' For each specified column, if a value contains a comma, only the part before the comma is kept. So be careful,
#' if you don't want to split the column values by comma, you should use you own functions. Also only accept comma split.
#' @param date A character string containing the name of the date column (optional). If you want to pass a column
#' which is a date, you should use date to specify the parameter. The date must be in the form of mm dd, yy.
#' @return A tibble containing the count of rows for each group.
#' @import dplyr
#' @import lubridate
#' @import stringr
#' @import tidyverse
#' @import purrr
#' @examples
#' \dontrun{
#' summary_result <- count_by_general(steam_games, c("genre", "language"), date = "release_date")
#' }
#' @export
count_by_general <- function(data, column_names, date = NULL) {

  # Check if data is empty
  if (is.null(data) || nrow(data) == 0) {
    stop("Data is empty. Please provide a valid data frame.")
  }

  # Check if any specified column has all NA values
  all_na_cols <- column_names[sapply(column_names, function(col) all(is.na(data[[col]])))]
  if (length(all_na_cols) > 0) {
    stop(paste("All values in column(s)", paste(all_na_cols, collapse = ", "), "are NA."))
  }

  # Check if the columns specified in column_names are of class character
  column_classes <- map(column_names, ~ class(data[[.x]])[1])
  non_char_cols <- column_names[column_classes != "character"]
  if (length(non_char_cols) > 0) {
    stop(paste("Incorrect class for columns:", paste(non_char_cols, collapse = ", "),
               ". Ensure all column_names are of class chr"))
  }

  # Process all columns specified in column_names to keep only the part before any comma
  data <- data %>%
    mutate(across(all_of(column_names), ~ str_extract(., "^[^,]*")))

  # Process date column if specified
  if (!is.null(date)) {
    date_column <- as.character(date)
    # Check if date column exists in the data
    if (!(date_column %in% names(data))) {
      stop(paste("Date column", date_column, "not found in the data."))
    }
    # Attempt to convert the date column values to Date class
    date_check <- try(as.Date(data[[date_column]], format = "%B %d, %Y"))
    # Check if any date conversion resulted in NA
    if (any(is.na(as.Date(data[[date_column]], format = "%B %d, %Y")))) {
      stop(paste("Date values in column", date_column, "do not match the expected format (Month Day, Year)."))
    }
    # Extract year from date column
    data <- data %>%
      mutate(across(all_of(date_column),
                    ~ as.Date(., format = "%B %d, %Y") %>% format("%Y")))
    # Append the date column to column_names for grouping
    column_names <- c(column_names, date_column)
  }

  # Group by and summarise
  summary_tibble <- data %>%
    group_by(across(all_of(column_names))) %>%
    summarise(count = n(), .groups = 'drop')

  return(summary_tibble)
}
