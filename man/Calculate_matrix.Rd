% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Calculate_matrix.R
\name{Calculate_matrix}
\alias{Calculate_matrix}
\title{Calculate age-reading error matrix from parameters}
\usage{
Calculate_matrix(par, min_age, max_age)
}
\arguments{
\item{par}{Numerical vector containing the parameters
for calculating the age-reading error matrix
in order: beta0, beta1, alpha0, alpha1, phi}

\item{min_age}{Integer, minimum age}

\item{max_age}{Integer, maximum age}
}
\value{
Matrix, age-reading error matrix
}
\description{
Calculate age-reading error matrix from parameters
}
\examples{
params = c(4.504, -0.31287, 0, 0, 0.2103217)
Calculate_matrix(params, 3, 12)
}
