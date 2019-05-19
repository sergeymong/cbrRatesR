#' @export
cbr_possible_codes <- function(full_output = F){

  res <- httr::POST("http://www.cbr.ru/scripts/XML_valFull.asp")
  xml_data <- XML::xmlParse(res, encoding = 'UTF-8')
  df <- XML::xmlToDataFrame(xml_data, stringsAsFactors = F)
  df[df$ISO_Char_Code == '',]$ISO_Char_Code <- NA

  df <- dplyr::arrange(df, ISO_Char_Code)

  if (full_output){
    return(df)
  } else {
    return(dplyr::select(df, c(ISO_Char_Code, Name, EngName, Nominal)))
  }
}
