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

mgf <- function(t, lambda) {
   exp(lambda * t / (1 - 2*t)) / sqrt(1 - 2*t)
}

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

