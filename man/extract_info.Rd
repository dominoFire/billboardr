% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/billboard_extractor.R
\name{extract_info}
\alias{extract_info}
\title{Row Chart information extraction}
\usage{
extract_info(html_row)
}
\arguments{
\item{html_row}{A rvest HTML node that contains the chart row nodes (an element whose CSS class is .chart-row)}
}
\value{
A list with information of a song in the chart
}
\description{
Extracts the song info from a Billboard chart row
}
