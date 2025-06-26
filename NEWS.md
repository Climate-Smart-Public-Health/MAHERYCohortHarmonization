<!-- NEWS.md is maintained by https://cynkra.github.io/fledge, do not edit -->

# MAHERYCohortHarmonization 1.1.0 (2025-06-06)

- Implemented `to_pinboard` function to standardize uploads of R objects and files to a Google Drive pin board or shared folder.
- Added documentation for the `to_pinboard` function, including parameters and examples.
- Created a new R Markdown file `flat_reporting_pins.Rmd` to serve as a template for reporting with the `pins` package.
- Updated configuration in `config_fusen.yaml` to include new R script and tests.
- Added tests for the `to_pinboard` function in `test-to_pinboard.R`.
- Created a vignette `reporting-with-pins-and-google-drive.Rmd` to demonstrate usage of the `to_pinboard` function.
- Updated various documentation files to reflect the new version 1.0.0 of the package.
- Added images for demonstration purposes in the vignette.


# MAHERYCohortHarmonization 1.0.0 (2025-06-06)

This major update introduces and closes the first milestone of the package [NSAPH-Data-Processing/MAHERYCohortHarmonization#3](https://github.com/NSAPH-Data-Processing/MAHERYCohortHarmonization/issues/3).

In it, we have developed a reproducible analysis package for the MAHERY cohort harmonization project, which includes:
- A comprehensive set of functions for data preprocessing, cleaning, and harmonization.
- A standardized lookup table for health diagnoses.
- Documentation and vignettes to guide users through the package functionalities.

Below is a summary of key commits:

- Introduced the `preprocess_2018_health` function to streamline health data processing.
- Introduced new functions `clean_2018_pregnancy` and `clean_2018_vaccinations` with corresponding documentation and tests.
- Improved the `create_health_diagnoses` function documentation to clarify its purpose and output.
- Updated the `inflate` function call in `flat_tracking_inputs.Rmd` to prevent opening the vignette automatically.
- Added a "Changelog" link to various HTML documents for better navigation.
- Updated `pkgdown.yml` to reflect the latest Pandoc version and last built date.
- Enhanced the `malagasy_diagnosis_lookup_table` with updated mappings for health diagnoses.
- Made minor formatting and code style improvements across various files for consistency.
- Update .Rbuildignore and enhance health diagnosis function documentation
- Introduced new article: Preprocessing 2018 Health Status.
- Added functions: create_health_diagnoses and preprocess_2018_health.
- Created malagasy_diagnosis_lookup_table for standardized health diagnoses.
- Updated pkgdown version to 2.1.3 and pandoc to 3.6.3.
- Updated OutputTables vignette to include health diagnoses lookup table.
- Configured a `devcontainer` for development in VS Code locally


# MAHERYCohortHarmonization (development version)

* Initial commit tracking with `fledge`.
