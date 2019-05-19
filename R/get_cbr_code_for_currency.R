#' @import
get_cbr_code_for_currency <- function(currency_iso_code = 'USD'){
  all_codes <- cbr_possible_codes(full_output = T)
  all_codes <- dplyr::filter(all_codes, !is.na(ISO_Char_Code))

  return(all_codes[all_codes$ISO_Char_Code == currency_iso_code, ]$ParentCode)
}

get_cbr_code_for_currency('USD')
