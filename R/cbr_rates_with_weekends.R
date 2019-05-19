#' Get CBR rates with filled weekends
#'
#' Very useful function, when you have costs or profits on weekend. In \code{\link{cbr_rates}} you get
#' data without them.
#'
#' @param code ISO code of currency. By default, USD. You can specify one of sixty possible ISO codes.
#' @param start_date By default, 7 days ago.
#' @param end_date By default, today.
#' @usage \code{\link{cbr_possible_codes}}
#' @return Dataframe with date and Currency to 'RUB' to Currency rate.
#' Weekends fills last day, when exists CBR rates.
#' @examples
#' # For example, today is Monday 2019-04-29. Rates of today will be from Saturday 2019-04-27.
#' cbr_rates_with_weekends(start_date = '2019-04-29')
#' @export
cbr_rates_with_weekends <- function(code = "USD", start_date = Sys.Date() - 7, end_date = Sys.Date() - 1){
  start_date <- as.Date(start_date)
  end_date <- as.Date(end_date)

  if (lubridate::wday(start_date, week_start = 1) >= 6 | lubridate::wday(start_date, week_start = 1) == 1){
    start <- start_date - 3
  }

  cbr_rates <- cbr_rates(code = code, start_date = start, end_date = end_date)
  all_dates <- data.frame(Date = seq(start, end_date, by=1))
  df <- dplyr::left_join(all_dates, cbr_rates, by = "Date")
  df <- zoo::na.locf(df)
  res <- dplyr::filter(df, Date >= start_date & Date <= end_date)

  return(res)
}
