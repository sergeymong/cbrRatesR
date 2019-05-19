#' Get rates of Central Bank of Russian Federation
#'
#' Get rates: Currency to 'RUB' by dates.
#'
#' @param code ISO code of currency. By default, USD. You can specify one of sixty possible ISO codes.
#' @param start_date By default, 7 days ago.
#' @param end_date By default, today.
#' @usage \code{\link{cbr_possible_codes}}
#' @return Dataframe with date and Currency to 'RUB' to Currency rate.
#' @examples
#' # How many roubles costs of 1 American dollar during last week?
#' cbr_rates()
#'
#' # Dynamic of cost rouble to 1 EUR in 2017
#' cbr_rates(code = 'EUR', '2017-01-01', '2017-12-31')
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
  if (httr::http_error(res))
    stop("Http ", res$status_code)

  xml <- XML::xmlParse(res)
  result <- XML::xmlToDataFrame(xml)
  date <- XML::getNodeSet(xml, "//Record/@Date")
  result$Date <- date
  result$Date <- lubridate::dmy(result$Date)
  result$Value <- as.double(gsub(",", ".", result[[2]]))

  return(result[c(3, 2)])
}
