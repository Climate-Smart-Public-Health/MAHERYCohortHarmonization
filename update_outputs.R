library(MAHERYCohortHarmonization)
library(targets)
library(pins)

# a quick function to update all outputs to the google drive
# using pins
update_outputs <- function(output) {
  # load the board
  board <- board_folder("data/outputs")
  
  # list of all targets to update
  target_names <- c(
    "harmonized_data",
    "harmonized_data_dictionary",
    "harmonized_data_overview",
    "harmonized_data_overview_by_study",
    "harmonized_data_overview_by_variable",
    "harmonized_data_overview_by_domain",
    "harmonized_data_overview_by_study_and_domain",
    "harmonized_data_overview_by_study_and_variable",
    "harmonized_data_summary_statistics",
    "harmonized_data_summary_statistics_by_study",
    "harmonized_data_summary_statistics_by_variable",
    "harmonized_data_summary_statistics_by_domain",
    "harmonized_data_summary_statistics_by_study_and_domain",
    "harmonized_data_summary_statistics_by_study_and_variable"
  )
  
  # loop through each target and update the pin
  for (target_name in target_names) {
    message(paste("Updating", target_name))
    
    # read the target value
    target_value <- tar_read(target_name)
    
    # write to the pin board
    pin_write(board, target_value, name = target_name, type = "rds", versioned = TRUE)
  }
  
  message("All outputs have been updated.")
}