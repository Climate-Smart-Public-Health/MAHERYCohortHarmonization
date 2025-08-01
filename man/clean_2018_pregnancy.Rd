% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clean_2018_pregnancy.R
\name{clean_2018_pregnancy}
\alias{clean_2018_pregnancy}
\title{Title}
\usage{
clean_2018_pregnancy(df)
}
\description{
Description
}
\examples{
health_data_ \%>\% 
  clean_2018_pregnancy() -> health_data_

health_data_ \%>\%
  select(matches("pregnancy|birth|deliveries")) \%>\%
  select(contains("clean")) \%>\%
  skimr::skim()
}
