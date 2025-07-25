# WARNING - Generated by {fusen} from dev/flat_preprocess_2018.Rmd: do not edit by hand # nolint: line_length_linter.

#' Generate a short, deterministic unique identifier
#'
#' This function creates a short hash-based unique identifier (UID) by combining a salt and 
#' any number of additional inputs. It is useful for generating reproducible IDs in a pipeline, 
#' especially when the same inputs should always result in the same UID.
#'
#' @param salt A character string used as the base salt for hashing. Defaults to `"cohort_secret"`.
#' @param ... Additional values to be combined with the salt to generate the UID.
#' Typically, these might include identifiers such as names, dates, or other stable fields.
#' @param nchar Integer specifying the number of characters to return from the hashed result.
#' Default is 6.
#'
#' @return A character string representing a short, deterministic unique identifier.
#'
#' @details
#' The function uses the SHA-256 hash algorithm (via the `digest` package) and truncates
#' the result to the desired number of characters. The UID is deterministic: the same inputs 
#' will always produce the same output.
#'
#' @importFrom digest digest
#' 
#' @export
#' @examples
#' generate_uid(salt = "cohort_secret", "John", "Doe", "1990-01-01")
generate_uid <- function(salt = "cohort_secret", ..., nchar=6) {
  input <- paste(salt, ..., sep = "_")
  uid <- substr(digest(input, algo = "sha256"), 1, nchar)  # 12-char unique ID
  return(uid)
}
