% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/loglik.R
\name{loglik}
\alias{loglik}
\title{Log-likelihood function}
\source{
Clancey, E., Johnson, T. R., Harmon, L. J., and Hohenlohe, P. A. Estimation of the strength of mate preference from mated pairs observed in the wild. Unpublished manuscript.
}
\usage{
loglik(theta, xp, yp, x, y)
}
\arguments{
\item{theta}{Vector of the model parameters (alpha, delta, mx, my, sx, and sy). Note that mx and my are the means of the X and Y traits, respectively, and sx and sy are the standard deviations of the X and Y traits, respectively.}

\item{xp}{Vector of paired observations of X.}

\item{yp}{Vector of paired observations of Y.}

\item{x}{Vector of unpaired observations of X.}

\item{y}{Vector of unpaired observations of Y.}
}
\value{
The value of the log-likelihood function.
}
\description{
This function is the log-likelihood function for the mate preference model described by Clancey, Johnson, Harmon, and Hohenlohe (2021) (see equation 2.6 in manuscript).
}
\examples{
# simulate data
mydata <- simdata(0.5, 0, 50, 52, 1, 1, 100, 50, 50)
# set starting values using unpaired observations for means and standard deviations
theta <- c(0, 0, mean(c(mydata$xp, mydata$x)), mean(c(mydata$yp, mydata$y)), sd(c(mydata$xp, mydata$x)), sd(c(mydata$yp, mydata$y)))
# compute MLEs and Hessian (set fnscale = -1 to maximize rather than minimize)
fit <- optim(theta, loglik, method = "L-BFGS-B", control = list(fnscale = -1),
  lower = c(0, 0, -Inf, -Inf, 0, 0), hessian = TRUE,
  xp = mydata$xp, yp = mydata$yp, x = mydata$x, y = mydata$y)
# estimates and standard errors
data.frame(mle = fit$par, se = sqrt(diag(solve(-fit$hessian))))

}
