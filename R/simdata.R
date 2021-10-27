#' Simulate data
#'
#' This function simulates data for the mate preference model described by Clancey, Johnson, Harmon, and Hohenlohe (2021).
#'
#' @param alpha Value of the alpha parameter.
#' @param delta Value of the delta parameter.
#' @param mx Value of the mean of the X trait.
#' @param my Value of the mean of the Y trait.
#' @param sx Value of the standard deviation of the X trait.
#' @param sy Value of the standard deviation of the Y trait.
#' @param np Number of paired observations of X and Y.
#' @param nx Number of unpaired observations of X.
#' @param ny Number of unpaired observations of Y.
#' @param gamma Value of the gamma parameter (defaults to one).
#'
#' @return The function returns a list of four vectors consisting of the paired observations of X and Y (\code{xp} and \code{yp}, respectively), and the unpaired observations of X and Y (\code{x} and \code{y}, respectively).
#'
#' @source Clancey, E., Johnson, T. R., Harmon, L. J., and Hohenlohe, P. A. Estimation of the strength of mate preference from mated pairs observed in the wild. Unpublished manuscript.
#'
#' @examples
#' mydata <- simdata(0.5, 0, 50, 52, 1, 1, 100, 50, 50)
#'
#' @export
simdata <- function(alpha, delta, mx, my, sx, sy, np, nx, ny, gamma = 1) {

   xp <- rep(NA, np)
   yp <- rep(NA, np)

   for (i in 1:np) {
      repeat {
         x <- rnorm(1, mx, sx)
         y <- rnorm(1, my, sy)
         if (runif(1) < gamma * exp(-alpha * (x - y - delta)^2)) {
            xp[i] <- x
            yp[i] <- y
            break
         }
      }
   }

   if (nx > 0) {
      x <- rnorm(nx, mx, sx)
   } else {
      x <- NULL
   }

   if (ny > 0) {
      y <- rnorm(ny, my, sy)
   } else {
      y <- NULL
   }

   return(list(xp = xp, yp = yp, x = x, y = y))
}
