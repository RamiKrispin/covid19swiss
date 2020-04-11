#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Switzerland Outbreak Dataset
#'
#' @description  daily summary of the Coronavirus (COVID-19) pandemic cases in Switzerland by Canton
#'
#'
#' @format A data.frame object
#' @source Specialist Unit for Open Government Data Canton of Zurich \href{http://open.zh.ch/internet/justiz_inneres/ogd/de/daten.html/}{website}
#' @keywords datasets coronavirus COVID19 Switzerland Canton Liechtenstein
#' @details The dataset contains the daily summary of the Coronavirus pandemic cases in Switzerland and Principality of Liechtenstein.
#' The data includes the following fields:
#'
#' date - the timestamp of the case, a Date object
#'
#' canton - the cantons of Switzerland and Principality of Liechtenstein (FL) abbreviation code
#'
#' type - the type of case
#'
#' cases - the number of cases corresponding to the date and case type fields
#'
#' gn_a1_code - a canton index code for merging geometry data from the rnaturalearth package, available only for Switzerland cantons
#'
#'
#' Where the available type field includes the following cases:
#'
#' total_tested - number of tests performed as of the date
#'
#' total_confirmed - number of positive cases as of the date
#'
#' new_hosp - new hospitalizations with respect to the previously reported date
#'
#' current_hosp - number of hospitalized patients as of the current date
#'
#' current_icu - number of hospitalized patients in ICUs as of the current date
#'
#' current_vent - number of hospitalized patients requiring ventilation as of the current date
#'
#' total_recovered - total number of patients recovered as of the current date
#'
#' total_death - total number of death as of the current date
#'
#' @examples
#'
#' data(covid19swiss)
#'
#' head(covid19swiss)
#'

"covid19swiss"
