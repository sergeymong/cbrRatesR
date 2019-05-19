#' @export
cbr_rates_with_weekends <- function(code = "USD", start_date = Sys.Date() - 7, end_date = Sys.Date()){
  start_date <- as.Date(start_date)
  end_date <- as.Date(end_date)

  if (lubridate::wday(start_date, week_start = 1) >= 6 | lubridate::wday(start_date, week_start = 1) == 1){
    start_date <- start_date - 3
  }

  cbr_rates <- cbr_rates(code = code, start_date = start_date, end_date = end_date)
  from <- min(cbr_rates[[1]])
  to <- max(cbr_rates[[1]])
  all_dates <- data.frame(Date = seq(start_date, end_date, by=1))
  res <- dplyr::left_join(all_dates, cbr_rates, by = "Date")

  return(zoo::na.locf(res))
}

