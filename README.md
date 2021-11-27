# matepref

This package estimates the strength of mate preference and the strength of phenotypic offset between trait values in mated pairs of organisms, as well as means and standard deviations from X and Y normally distributed phenotypic traits. The package uses a likelihood function defined by the authors that is maximized using the built-in R function optim(). The package computes maximum likelihood estimates, the log-likelihood, and a Hessian matrix, and returns parameter estimates and the standard errors for these estimates. 

See the Manuscript for full details: 

Clancey, E., Johnson, T.R., Harmon, L.J., and Hohenlohe, P.A. (2021) Estimation of the strength of mate preference from mated pairs observed in the wild. Evolution. doi:10.1111/evo.14397


The package can be installed, if the user also has devtools() installed, using the command:

devtools::install_github("erinclancey/matepref")






