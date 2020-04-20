# Creating a file list
# need to refresh incase changes in the reop

#-------------- Github list of files --------------
# Required jq
command <- 'curl "https://api.github.com/repos/openZH/covid_19/contents/fallzahlen_kanton_total_csv_v2?ref=master" | jq ".[].name"'

files_list <- system(command = command, intern = TRUE)
if(is.null(files_list)){
  stop("Could not find the files list")
} else if(length(files_list) != 27){
  stop("The number of files on the Github repo is not aligned with the expected (27)")
}

write.csv(files_list, "csv/files_list.csv",
          row.names = FALSE )
