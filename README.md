Get CBR rates
================
<https://www.facebook.com/mongsergey>

<!-- README.md is generated from README.Rmd. Please edit that file -->

The following section helps you to get started straight away to get data
from Central Bank of Russia.

## Installation

Package available now only from GitHub:

``` r
require(devtools)
devtools::install_github("sergeymong/cbrRatesR")
```

## Usage

If you don’t know which currency code you need, use:

``` r
library(cbrRatesR)
cbr_possible_codes()
```

### Get currency rates

The simplest way get currency rates:

``` r
# This command returns rates of USD to RUB for last 7 days
cbr_rates()
```

If you want get other currencies data to more days:

``` r
cbr_rates(code = "EUR", 
          start_date = "2017-01-01",
          end_date = "2017-12-31")
```

If you want to fill weekends dates:

``` r
cbr_rates_with_weekends(code = "EUR", 
          start_date = "2017-01-01",
          end_date = "2017-12-31")
```
