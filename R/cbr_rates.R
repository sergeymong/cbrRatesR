#' @export
cbr_rates <- function(code = "USD", start_date = Sys.Date() - 7, end_date = Sys.Date()) {

  start <- strftime(start_date, "%d/%m/%Y")
  end <- strftime(end_date, "%d/%m/%Y")

  fx_url <-
    httr::modify_url(
      "http://www.cbr.ru/scripts/XML_dynamic.asp",
      query = list(
        VAL_NM_RQ = get_cbr_code_for_currency(code),
        date_req1 = start,
        date_req2 = end
      ))

  res <- httr::POST(fx_url)
  if(httr::http_error(res))
    stop("Http ", res$status_code)

  xml <- XML::xmlParse(res)
  result <- XML::xmlToDataFrame(xml)
  date <- XML::getNodeSet(xml, '//Record/@Date')
  result$Date <- date
  result$Date <- lubridate::dmy(result$Date)
  result$Value <- as.double(gsub(",", ".", result[[2]]))

  return(result[c(3, 2)])
}

cbr_rates()


