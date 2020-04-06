#-----------------------------------------
# covid19swiss pulling Raw data
#-----------------------------------------

#-------------- Functions --------------
`%>%` <- magrittr::`%>%`
#-------------- Github list of files --------------
# Required jq
command <- 'curl "https://api.github.com/repos/openZH/covid_19/contents/fallzahlen_kanton_total_csv?ref=master" | jq ".[].name"'

files_list <- system(command = command, intern = TRUE)
#-------------- Pulling the raw data --------------
df_raw <- lapply(files_list, function(i){
  print(files_list)
  df <- read.csv(paste("https://raw.githubusercontent.com/openZH/covid_19/master/fallzahlen_kanton_total_csv/", gsub('"', '', i), sep = ""))
  return(df)
}) %>% dplyr::bind_rows()
#-------------- Cleaning the data --------------
head(df_raw)

swiss_canton <- df_raw %>%
  dplyr::mutate(date = as.Date(date),
                canton = abbreviation_canton_and_fl) %>%
  dplyr::group_by(date, canton) %>%
  dplyr::summarise(total_tested = sum(ncumul_tested, na.rm = TRUE),
                   total_confirmed = sum(ncumul_conf, na.rm = TRUE),
                   total_hospitalise = sum(ncumul_hosp, na.rm = TRUE),
                   total_ICU = sum(ncumul_ICU, na.rm = TRUE),
                   total_vent = sum(ncumul_vent, na.rm = TRUE),
                   total_recovered = sum(ncumul_released, na.rm = TRUE),
                   total_death = sum(ncumul_deceased, na.rm = TRUE)) %>%
  tidyr::pivot_longer(c(-date, - canton),
                      names_to = "type",
                      values_to = "cases")
head(swiss_canton)

usethis::use_data(swiss_canton, overwrite = TRUE)
