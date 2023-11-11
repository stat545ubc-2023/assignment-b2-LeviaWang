#If make data is null, the function should give error message.
test_that("Function handles empty data correctly", {
  empty <-tibble(data.frame())
  expect_error(count_by_general(empty, c("genre"), date = "release_date"),
               "Data is empty. Please provide a valid data frame.")
  expect_error(count_by_general(NULL, c("genre"), date = "release_date"),
               "Data is empty. Please provide a valid data frame.")
})
test_that("Function handles non-character columns correctly", {
  new_data <- steam_games
  new_data_1 <- new_data %>%
    mutate(new_column = 1)
  expect_error(count_by_general(new_data_1, c("new_column"), date = "release_date"),
               "Incorrect class for columns: new_column . Ensure all column_names are of class chr")
})
test_that("Function handles all NA values in specified columns correctly", {
  na_data <- steam_games
  na_data$languages <- NA
  expect_error(count_by_general(na_data, c("languages")), "All values in column\\(s\\) languages are NA.")
})
test_that("Function handles all no exist date column correctly", {
  expect_error(count_by_general(steam_games, c("languages"), date = "no_exist_column"),
               "Date column no_exist_column not found in the data.")
})
test_that("Function handles all wrong format of date column correctly", {
  na_data <- steam_games
  na_data$release_date <- "May"
  expect_error(count_by_general(na_data, c("languages"), date = "release_date"),
               "Date values in column release_date do not match the expected format \\(Month Day, Year\\).")
  na_data$release_date <- "May112022"
  expect_error(count_by_general(na_data, c("languages"), date = "release_date"),
               "Date values in column release_date do not match the expected format \\(Month Day, Year\\).")
})

