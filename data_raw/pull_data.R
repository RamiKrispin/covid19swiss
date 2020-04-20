#-----------------------------------------
# covid19swiss pulling Raw data
#-----------------------------------------
data_refresh <- function(){
#-------------- Setting --------------
files_list <- swiss_map <- df_raw <- NULL
#-------------- Functions --------------
`%>%` <- magrittr::`%>%`
#-------------- Github list of files --------------
# Required jq
command <- 'curl "https://api.github.com/repos/openZH/covid_19/contents/fallzahlen_kanton_total_csv_v2?ref=master" | jq ".[].name"'

files_list <- system(command = command, intern = TRUE)
if(is.null(files_list)){
  stop("Could not find the files list")
} else if(length(files_list) != 27){
  stop("The number of files on the Github repo is not aligned with the expected (27)")
}

#-------------- Pulling the map data --------------
swiss_map <- rnaturalearth::ne_states(country = "Switzerland", returnclass = "sf") %>%
  dplyr::mutate(canton = substr(gn_a1_code, 4,5)) %>%
  dplyr::select(canton, gn_a1_code) %>%
  as.data.frame()
swiss_map$geometry <- NULL
swiss_map
#-------------- Pulling the raw data --------------
df_raw <- lapply(files_list, function(i){
  print(i)
  df <- read.csv(paste("https://raw.githubusercontent.com/openZH/covid_19/master/fallzahlen_kanton_total_csv_v2/", gsub('"', '', i), sep = ""), stringsAsFactors = FALSE)
  return(df)
}) %>% dplyr::bind_rows()
#-------------- Cleaning the data --------------
head(df_raw)

covid19swiss <- df_raw %>%
  dplyr::mutate(date = as.Date(date),
                canton = abbreviation_canton_and_fl) %>%
  dplyr::group_by(date, canton) %>%
  dplyr::summarise(total_tested = sum(ncumul_tested, na.rm = any(!is.na(ncumul_tested))),
                   total_confirmed = sum(ncumul_conf, na.rm = any(!is.na(ncumul_conf))),
                   new_hosp = sum(new_hosp, na.rm = any(!is.na(new_hosp))),
                   current_hosp = sum(current_hosp, na.rm = any(!is.na(current_hosp))),
                   current_icu = sum(current_icu, na.rm = any(!is.na(current_icu))),
                   current_vent = sum(current_vent, na.rm = any(!is.na(current_vent))),
                   total_recovered = sum(ncumul_released, na.rm = any(!is.na(ncumul_released))),
                   total_death = sum(ncumul_deceased, na.rm = any(!is.na(ncumul_deceased)))) %>%
  tidyr::pivot_longer(c(-date, - canton),
                      names_to = "data_type",
                      values_to = "value") %>%
  dplyr::left_join(swiss_map, by = "canton") %>%
  dplyr::mutate(location = canton,
                location_type = ifelse(canton == "FL", "Principality of Liechtenstein", "Canton of Switzerland"),
                location_code = gn_a1_code,
                location_code_type = "gn_a1_code") %>%
  dplyr::select(date, location, location_type, location_code, location_code_type, data_type, value) %>%
  as.data.frame()
head(covid19swiss)

if(ncol(covid19swiss) != 7){
  stop("The number of columns is not align with the expected one (7)")
} else if(nrow(covid19swiss) < 8200) {
  stop("The number of rows is not align with the expected one")
} else if(min(covid19swiss$date) != as.Date("2020-02-25")){
  stop("Stop, the starting date is not Feb 25")
}


git_df <- read.csv("https://raw.githubusercontent.com/Covid19R/covid19swiss/master/csv/covid19swiss.csv", stringsAsFactors = FALSE)

git_df$date <- as.Date(git_df$date)

if(ncol(git_df) != 7){
  stop("The number of columns is not align with the expected one (7)")
} else if(nrow(git_df) < 8200) {
  stop("The number of rows is not align with the expected one")
} else if(min(git_df$date) != as.Date("2020-02-25")){
  stop("Stop, the starting date is not Feb 25")
}

if(nrow(covid19swiss) > nrow(git_df)){
  print("Updates available")
  usethis::use_data(covid19swiss, overwrite = TRUE)
  write.csv(covid19swiss, "csv/covid19swiss.csv", row.names = FALSE)
  print("The covid19swiss dataset was updated")
} else {
  print("Updates are not available")
}

return(print("Done..."))


}


data_refresh()

