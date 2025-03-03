% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simdata.R
\name{simdata}
\alias{simdata}
\title{Simulate data}
\source{
Clancey, E., Johnson, T. R., Harmon, L. J., and Hohenlohe, P. A. Estimation of the strength of mate preference from mated pairs observed in the wild. Unpublished manuscript.
}
\usage{
simdata(alpha, delta, mx, my, sx, sy, np, nx, ny, gamma = 1)
}
\arguments{
\item{alpha}{Value of the alpha parameter.}

\item{delta}{Value of the delta parameter.}

\item{mx}{Value of the mean of the X trait.}

\item{my}{Value of the mean of the Y trait.}

\item{sx}{Value of the standard deviation of the X trait.}

\item{sy}{Value of the standard deviation of the Y trait.}

\item{np}{Number of paired observations of X and Y.}

\item{nx}{Number of unpaired observations of X.}

\item{ny}{Number of unpaired observations of Y.}

\item{gamma}{Value of the gamma parameter (defaults to one).}
}
\value{
The function returns a list of four vectors consisting of the paired observations of X and Y (\code{xp} and \code{yp}, respectively), and the unpaired observations of X and Y (\code{x} and \code{y}, respectively).
}
\description{
This function simulates data for the mate preference model described by Clancey, Johnson, Harmon, and Hohenlohe (2021).
}
\examples{
mydata <- simdata(0.5, 0, 50, 52, 1, 1, 100, 50, 50)

}
