% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/raw_data_ok.R
\name{raw_data_ok}
\alias{raw_data_ok}
\title{Check if data in raw data folder is OK}
\usage{
raw_data_ok(input)
}
\arguments{
\item{input}{raw data folder containing conductivity data, i.e usually is \code{some/path/mnualcount}}
}
\value{
\code{TRUE} if ok, \code{FALSE} or \code{list} of problems if not
}
\description{
Check if data in raw data folder is OK
}
\examples{
\dontrun{
raw_data_ok()
}
}
