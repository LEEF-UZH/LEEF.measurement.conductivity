#' Extractor conductivity data
#'
#' Convert all \code{.cvs} files in \code{conductivity} folder to \code{data.frame} and save as \code{.rds} file.
#'
#' This function is extracting data to be added to the database (and therefore make accessible for further analysis and forecasting)
#' from \code{.csv} files.
#'
#' @param input directory from which to read the data
#' @param output directory to which to write the data
#'
#' @return invisibly \code{TRUE} when completed successful
#' @importFrom yaml read_yaml
#' @importFrom utils read.csv write.csv
#'
#' @export
#'
extractor_conductivity <- function( input, output ) {
  dir.create(
    file.path(output, "conductivity"),
    recursive = TRUE,
    showWarnings = FALSE
  )
  if ( length( list.files( file.path(input, "conductivity") ) ) == 0 ) {
    message("\nEmpty or missing conductivity directory - nothing to do.\n")
    message("\ndone\n")
    message("########################################################\n")
    return(invisible(TRUE))
  }

  loggit::set_logfile(file.path(output, "conductivity", "conductivity.log"))

  message("\n########################################################\n")
  message("Extracting conductivity...\n")

  # Get csv file names ------------------------------------------------------

  conductivity_path <- file.path( input, "conductivity" )
  conductivity_file <- file.path(conductivity_path, "conductivity.csv")

  if (!file.exists(conductivity_file)) {
    message("`nothing to extract`conductivity.csv` does not exist\n")
    message("nothing to extract\n")
    message("\n########################################################\n")
    return(invisible(FALSE))
  }


# Read file ---------------------------------------------------------------


  dat <- utils::read.csv(conductivity_file)

  timestamp <- yaml::read_yaml(file.path(input, "conductivity", "sample_metadata.yml"))$timestamp
  dat <- cbind(timestamp = timestamp, dat)

  names(dat) <- tolower(names(dat))

# SAVE --------------------------------------------------------------------

  add_path <- file.path( output, "conductivity" )
  dir.create(
    add_path,
    recursive = TRUE,
    showWarnings = FALSE
  )
  utils::write.csv(
    dat,
    file = file.path(add_path, "conductivity.csv"),
    row.names = FALSE
  )

  fns <- grep(
    paste0(basename(conductivity_file), "|conductivity.log"),
    list.files(file.path(input, "conductivity")),
    invert = TRUE,
    value = TRUE
  )
  file.copy(
    from = file.path(input, "conductivity", fns),
    to = file.path(output, "conductivity", "")
  )

# Finalize ----------------------------------------------------------------

  message("done\n")
  message("\n########################################################\n")

  invisible(TRUE)
}
