# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c(
    # Packages that your targets need for their tasks.
    "tibble", "googledrive", "purrr", "dplyr", "lubridate",
    "tidyr", "here", "readxl", "readr",
    "MAHERYCohortHarmonization"   # This pipeline
  )    
  # format = "qs", # Optionally set the default storage format. qs is fast.
  #
  # Pipelines that take a long time to run may benefit from
  # optional distributed computing. To use this capability
  # in tar_make(), supply a {crew} controller
  # as discussed at https://books.ropensci.org/targets/crew.html.
  # Choose a controller that suits your needs. For example, the following
  # sets a controller that scales up to a maximum of two workers
  # which run as local R processes. Each worker launches when there is work
  # to do and exits if 60 seconds pass with no tasks to run.
  #
  #   controller = crew::crew_controller_local(workers = 2, seconds_idle = 60)
  #
  # Alternatively, if you want workers to run on a high-performance computing
  # cluster, select a controller from the {crew.cluster} package.
  # For the cloud, see plugin packages like {crew.aws.batch}.
  # The following example is a controller for Sun Grid Engine (SGE).
  # 
  #   controller = crew.cluster::crew_controller_sge(
  #     # Number of workers that the pipeline can scale up to:
  #     workers = 10,
  #     # It is recommended to set an idle time so workers can shut themselves
  #     # down if they are not running tasks.
  #     seconds_idle = 120,
  #     # Many clusters install R as an environment module, and you can load it
  #     # with the script_lines argument. To select a specific verison of R,
  #     # you may need to include a version string, e.g. "module load R/4.3.2".
  #     # Check with your system administrator if you are unsure.
  #     script_lines = "module load R"
  #   )
  #
  # Set other options as needed.
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()
# tar_source("other_functions.R") # Source other scripts as needed.

# Replace the target list below with your own:
list(

  # First, we check that we have secure access to google drive
  tar_target(
    name = secure_access_true,
    command = authenticate_google_drive()
  ),

  # Next, we create the paths for the data files
  tar_target(
    name = data_directory_ready,
    command = {
      if(secure_access_true){
        create_datapaths()
      }
    }
  ),

  # set the freeze date; I'm setting this as April 1st 2025
  tar_target(
    name = freeze_date,
    command = {
      lubridate::mdy("01-04-2025")
    }
  ),
  
  # now, let's get the files that we are interested in tracking
  tar_target(
    name = data_files,
    command = {
      mahery_input_files(freeze_date = freeze_date)
    }
  ),

  # and we check whether the files have changed since the last time we ran the pipeline
  tar_target(
    name = gdrive_files_have_NOT_changed,
    command = {
      authenticate_google_drive()
      any_changed <- data_files %>%
        mutate(

          # find the file in google drive
          search_results = map(regex, ~ drive_find(.x, n_max = 1))
        ) %>%
        unnest(cols=c(search_results)) %>%

        # use the ID to check if it has changed
        mutate(has_changed = has_drive_file_changed(id, freeze_date)) %>%

        # evaluate all() of the has_changed column
        summarise(any_changed = any(has_changed == TRUE)) %>%
        pull(any_changed)

      any_changed == FALSE
    }
  ),

  # if the files have changed, we stop the pipeline
  tar_target(
    name = guard_pipeline_freeze,
    command = {
      if (!gdrive_files_have_NOT_changed) {
        stop("🚨 Google Drive files have changed since the freeze date. Halting pipeline to prevent overwrite.")
      }
      TRUE  # Return TRUE if safe
    }
  ),

  # now we can download the raw files
  tar_target(
    name = raw_files,
    command = {
      
      invisible(guard_pipeline_freeze)
      auth_status <- authenticate_google_drive()
      
      data_files %>%
        mutate(output_path = map(regex, download_to_local, download_dir = here("data", "raw"))) %>%
        unnest(output_path)
    }
  ),

  # each file
  tar_target(
    name = opensrp,
    command = {
      read_excel(raw_files$output_path[1])
    }
  ),
  tar_target(
    name = opensrp_dict,
    command = {
      read_excel(raw_files$output_path[2])
    }
  ),
  tar_target(
    name = dharma2019,
    command = {
      read_csv(raw_files$output_path[3])
    }
  ),
  tar_target(
    name = dharma2020,
    command = {
      read_excel(raw_files$output_path[4])
    }
  )
)
