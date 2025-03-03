#' Log-likelihood function
#'
#' This function is the log-likelihood function for the mate preference model described by Clancey, Johnson, Harmon, and Hohenlohe (2021) (see equation 2.6 in manuscript).
#'
#' @param theta Vector of the model parameters (alpha, delta, mx, my, sx, and sy). Note that mx and my are the means of the X and Y traits, respectively, and sx and sy are the standard deviations of the X and Y traits, respectively.
#' @param xp Vector of paired observations of X.
#' @param yp Vector of paired observations of Y.
#' @param x Vector of unpaired observations of X.
#' @param y Vector of unpaired observations of Y.
#'
#' @return The value of the log-likelihood function.
#'
#' @source Clancey, E., Johnson, T. R., Harmon, L. J., and Hohenlohe, P. A. Estimation of the strength of mate preference from mated pairs observed in the wild. Unpublished manuscript.
#'
#' @examples
#' # simulate data
#' mydata <- simdata(0.5, 0, 50, 52, 1, 1, 100, 50, 50)
#' # set starting values using unpaired observations for means and standard deviations
#' theta <- c(0, 0, mean(c(mydata$xp, mydata$x)), mean(c(mydata$yp, mydata$y)), sd(c(mydata$xp, mydata$x)), sd(c(mydata$yp, mydata$y)))
#' # compute MLEs and Hessian (set fnscale = -1 to maximize rather than minimize)
#' fit <- optim(theta, loglik, method = "L-BFGS-B", control = list(fnscale = -1),
#'   lower = c(0, 0, -Inf, -Inf, 0, 0), hessian = TRUE,
#'   xp = mydata$xp, yp = mydata$yp, x = mydata$x, y = mydata$y)
#' # estimates and standard errors
#' data.frame(mle = fit$par, se = sqrt(diag(solve(-fit$hessian))))
#'
#' @export
loglik <- function(theta, xp, yp, x, y) {
   alpha <- theta[1]
   delta <- theta[2]
   mx <- theta[3]
   my <- theta[4]
   sx <- theta[5]
   sy <- theta[6]
   mxy <- mx - my - delta
   sxy <- sx^2 + sy^2
   loglik <- sum(dnorm(xp, mx, sx, log = TRUE)) + sum(dnorm(yp, my, sy, log = TRUE)) -
      sum(alpha * (xp - yp - delta)^2) - length(xp) * log(mgf(- alpha * sxy, mxy^2 / sxy))
   if (!is.null(x)) {
      loglik <- loglik + sum(dnorm(x, mx, sx, log = TRUE))
   }
   if (!is.null(y)) {
      loglik <- loglik + sum(dnorm(y, my, sy, log = TRUE))
   }
   return(loglik)
}

mgf <- function(t, lambda) {
   exp(lambda * t / (1 - 2*t)) / sqrt(1 - 2*t)
}

