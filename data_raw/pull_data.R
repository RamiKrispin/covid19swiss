#-----------------------------------------
# covid19swiss pulling Raw data
#-----------------------------------------

#-------------- Functions --------------
`%>%` <- magrittr::`%>%`
#-------------- Github list of files --------------
# Required jq
command <- 'curl "https://api.github.com/repos/openZH/covid_19/contents/fallzahlen_kanton_total_csv_v2?ref=master" | jq ".[].name"'

files_list <- system(command = command, intern = TRUE)
#-------------- Pulling the raw data --------------
df_raw <- lapply(files_list, function(i){
  print(files_list)
  df <- read.csv(paste("https://raw.githubusercontent.com/openZH/covid_19/master/fallzahlen_kanton_total_csv_v2/", gsub('"', '', i), sep = ""))
  return(df)
}) %>% dplyr::bind_rows()
#-------------- Cleaning the data --------------
head(df_raw)

covid19swiss <- df_raw %>%
  dplyr::mutate(date = as.Date(date),
                canton = abbreviation_canton_and_fl) %>%
  dplyr::group_by(date, canton) %>%
  dplyr::summarise(total_tested = sum(ncumul_tested, na.rm = TRUE),
                   total_confirmed = sum(ncumul_conf, na.rm = TRUE),
                   new_hosp = sum(new_hosp, na.rm = TRUE),
                   current_hosp = sum(current_hosp, na.rm = TRUE),
                   current_icu = sum(current_icu, na.rm = TRUE),
                   current_vent = sum(current_vent, na.rm = TRUE),
                   total_recovered = sum(ncumul_released, na.rm = TRUE),
                   total_death = sum(ncumul_deceased, na.rm = TRUE)) %>%
  tidyr::pivot_longer(c(-date, - canton),
                      names_to = "type",
                      values_to = "cases") %>%
  as.data.frame()
head(covid19swiss)

usethis::use_data(covid19swiss, overwrite = TRUE)

write.csv(covid19swiss, "csv/covid19swiss.csv", row.names = FALSE)

