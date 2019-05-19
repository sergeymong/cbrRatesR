#' Get list of possible currencies
#'
#' Use this, if you don't know, which ISO code of currency you need.
#' Or if you don't shure that CBR have this rates or not.
#'
#' @param full_output By default, FALSE. If TRUE return columns:
#' \itemize{
#'   \item Name
#'   \item EngName
#'   \item Nominal
#'   \item ParentCode
#'   \item ISO_Num_Code
#'   \item ISO_Char_Code
#' }
#' @return Data frame, sorted by ISO code with currency names and nominals.
#' @export
cbr_possible_codes <- function(full_output = F){

  res <- httr::POST("http://www.cbr.ru/scripts/XML_valFull.asp")
  xml_data <- XML::xmlParse(res, encoding = "UTF-8")
  df <- XML::xmlToDataFrame(xml_data, stringsAsFactors = F)
  df[df$ISO_Char_Code == "", ]$ISO_Char_Code <- NA

  df <- dplyr::arrange(df, ISO_Char_Code)

  if (full_output){
    return(df)
  } else {
    return(dplyr::select(df, c(ISO_Char_Code, Name, EngName, Nominal)))
  }
}
