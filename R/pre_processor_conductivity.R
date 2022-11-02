#' Preprocessor conductivity data
#'
#' Just copy from input to output
#'
#' @param input directory from which to read the data
#' @param output directory to which to write the data
#'
#' @return invisibly \code{TRUE} when completed successful
#' @importFrom readxl read_excel
#' @importFrom utils write.csv
#' @import loggit
#' @export

pre_processor_conductivity <- function(
  input,
  output
) {
  if ( length( list.files( file.path(input, "conductivity") ) ) == 0 ) {
    message("\nEmpty or missing conductivity directory - nothing to do.\n")
    message("\ndone\n")
    message("########################################################\n")
    return(invisible(TRUE))
  }

  dir.create(
    file.path(output, "conductivity"),
    recursive = TRUE,
    showWarnings = FALSE
  )
  loggit::set_logfile(file.path(output, "conductivity", "conductivity.log"))

  message("\n########################################################\n")
  message("\nProcessing conductivity\n")
  ##

  fns <- list.files(
    path = file.path(input, "conductivity"),
    pattern = "\\.xlsx$",
    full.names = TRUE,
    recursive = FALSE
  )
  if (length(fns) > 0) {
    if (length(fns) > 1) {
      warning("Only one `.xlsx` file expected! Only the first one will be analysed!")
    }
    fn <- fns[[1]]
    if (length(readxl::excel_sheets(fn)) > 1) {
      warning("Only one sheet in the excel workbook expected! Only the first one will be abalysed!")
    }

    x <- readxl::read_excel(
      path = fn,
      sheet = 1
    )

    csvn <- gsub(
      pattern = "\\.xlsx$",
      replacement = ".csv",
      basename(fn)
    )

    file.copy(
      file.path( input, "..", "00.general.parameter", "." ),
      file.path( output, "conductivity" ),
      recursive = TRUE,
      overwrite = TRUE
    )

    utils::write.csv(
      x,
      file = file.path(output, "conductivity", csvn),
      row.names = FALSE
    )

  }

 ##
  message("done\n")
  message("\n########################################################\n")

  invisible(TRUE)
}
