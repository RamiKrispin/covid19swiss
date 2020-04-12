#' Update the Package Datasets
#' @export
#' @description Checks if new data is available on the package dev version (Github).
#' In case new data is available the function will enable the user the update the datasets
#'
#' @example
#' \dontrun{
#'
#' update_swiss_data()
#'
#' }
update_swiss_data <- function(){
  flag <- FALSE

  current <- covid19swiss::covid19swiss


  git_df <- utils::read.csv("https://raw.githubusercontent.com/Covid19R/covid19swiss/master/csv/covid19swiss.csv",
                               stringsAsFactors = FALSE)




  git_df$date <- as.Date(git_df$date)



  if(!base::identical(current, git_df)){
    if(base::nrow(git_df) > base::nrow(current)){
      flag <- TRUE
    }
  }


  if(flag){
    q <- base::tolower(base::readline("Updates are available on the covid19swiss Dev version, do you want to update? n/Y"))

    if(q == "y" || q == "yes" || q == ""){

      base::tryCatch(
        expr = {
          devtools::install_github("covid19R/covid19swiss")

          base::message("The data was refresed, please restart your session to have the new data available")
        },
        error = function(e){
          message('Caught an error!')
          print(e)
        },
        warning = function(w){
          message('Caught an warning!')
          print(w)
        }

      )
    }
  } else {
    base::message("No updates are available")
  }


}
