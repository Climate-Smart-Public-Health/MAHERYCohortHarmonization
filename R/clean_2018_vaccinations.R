# WARNING - Generated by {fusen} from dev/flat_preprocess_2018_health.Rmd: do not edit by hand # nolint: line_length_linter.

#' Title
#' 
#' Description
#' 
#' @return
#' 
#' @export
#' @examples
#' health_data_ %>%
#'   clean_2018_vaccinations() -> health_data_
#'   
#' health_data_ %>%
#'   select(contains("vacc_")) %>%
#'   skimr::skim()
clean_2018_vaccinations <- function(df){

  df %>%
    mutate(
      vaccine_card_clean = case_when(
        vaccine_card == "Yes" ~ "Yes",
        vaccine_card == "No" ~ "No",
        vaccine_card == "Idk" ~ "Unknown_or_misplaced",
        TRUE ~ NA_character_
      ),
      vaccination_history = 
        str_to_lower(vaccination_history) %>%
        str_replace("vacc idr", "other") %>%
        str_replace("vacc other", "other"),
      id = row_number()
    ) %>%
    separate_longer_delim(
      vaccination_history,
      delim = " "
    ) %>%
    mutate(vaccination_history = str_c("vacc_", vaccination_history, "_clean")) %>%
    mutate(flag = TRUE) %>%
    distinct(id, vaccination_history, .keep_all = TRUE) %>%
    filter(!is.na(vaccination_history)) %>%
    pivot_wider(
      names_from = vaccination_history,
      values_from = flag,
      values_fill = FALSE
    ) %>%
    select(-id)

}
