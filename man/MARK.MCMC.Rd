\name{MARK.MCMC}
\alias{MARK.MCMC}

\title{Mark Gibbs sampler}
\description{A Bayesian way of fitting a mark-recapture model to capture history data.}
\usage{
MARK.MCMC(ch, cov, n.iter = 100, burn.in = 50, number.of.models = 10, n.chains = 2, 
add = TRUE, quad = TRUE, corr = TRUE)
}
\arguments{
  
  \item{ch}{A matrix or a collapsed, single-columned data.frame of capture histories, 
  one row for each individual.}
  \item{cov}{A data.frame of covariates (traits) that should be considered}
  \item{n.iter}{Number iterations the sampler should take.}
  \item{burn.in}{The number of iterations to discard from each chain.}
  \item{number.of.models}{The number of models to calculate the posterior probability 
  for.}
  \item{n.chains}{The number of chains. Each chain will be run on a separate core 
  if possible.}
  \item{add}{Should all possilbe addative terms be considered.}
  \item{quad}{Should all possible quadratic terms be considered.}
  \item{corr}{Should all possible pairwise interaction terms be considered.}
}

\details{
This function implements a Gibbs sampler to estimate mark-recapture parameters. 
It is essentially a wrapper for a Jags or WinBugs model. 
Things it does not do right now: 
A. does not handle data with significant time or age dependent effects, 
B. cannot deal with re-capture heterogeniety (i.e. re-capture dependence on a trait), 
C. cannot fit a specific predefined model, 
D. cannot use predefined priors (usues diffuse priors instead, see reference). 
Other R libraries exist with this functionality, namely marked, RMark, mra. 
What it can do is do automatic model selection on all combinations of models supplied. 
See examples for usage. 
}


\value{

(mcmc = mcmc, mcmc.list = mcmc.list, pp = pp.results,
 estimates = estimates, p = p, gelman = gelman)
Returns a list: 

\item{$mcmc}{A single matrix with all the parameter estimates for each chain combined.}
\item{$mcmc.list}{An object of class mcmc.list, one element for each chain.}
\item{$pp}{A data.frame of posterior probabilities for each model.}
\item{$estimates}{A data.frame of parameter estimates for survival probability.}
\item{$p}{The estimated recapture probability.}
\item{$gelman}{The the output from gelman.diag in the library coda, 
a convergence diagnostic.}


}

\references{
Gimenez et al. 2009  
"Estimagint and visulizing fitness surfaces using mark-recapture data"
Evolution
}


\examples{

#' Example 1 perfect detection 
\dontrun{

#' generate some data to input into our simulator  
N = 100
#' Two traits
x1 = rnorm(N,0,1)
x2 = rnorm(N,0,1)

#' Use our simulator function
#' with constant and perfect recapture probability, p.constant = 1
#' with positive linear selection on trait x1 and no selection on trait x2
chObj = Simulate.CH(surv.form = 1 + 0.15*x1 + 0*x2, p.constant = 1, N = N)
str(chObj) #' what is contained in our chObj

ch = chObj$ch #' Let's pull out our simulated capture histories
ch #' what it looks like

#' make a data.frame of covariate values
cov = data.frame(x1 = x1, x2 = x2) 

#' cov should have the same number of rows as ch
nrow(ch)
nrow(cov)

#' Now let's estimate the parameters of our simulated data.
#' And test which model best fits the data.
#' We use a small number iteration here, 
#' n.iter = 1000, so it runs quickly. 
#' One should definitely use many more iterations in practice. 
#' We we throw away half of our n.iter in the the burn in, burn.in = 500
MCMC = MARK.MCMC(ch = ch, cov = cov, n.iter = 1000, burn.in = 500, number.of.models = 5, 
n.chains = 2, add = TRUE, quad = TRUE, corr = TRUE)

#' Let's look at what is inside our MCMC object
attributes(MCMC)

#' Let's look at the posterior probability, pp
#' Since we did not run very many iterations, the correct model (x1),
#' may not have the highest probability
MCMC$pp

#' Let's look at the recapture probability
#' Since we set it at 1, it should be close to 1 
MCMC$p

#' Let's look at our estimates of our parameters.
#' Since we set the gradient on trait x1 to 0.15, x1's parameters should be close to 0.15
#' However, our estimates may not be very good, since we used so few iterations 
MCMC$estimates

#' Let's look at our convergence diagnostic
#' These values should be close to 1 for all beta variables and p
#' w and sigmaeps can mostly be ignored 
#' See gelman.diag in the coda library for more details. 
MCMC$gelman


#' Example 2 imperfect detection 
#' Same procedure as in Example 1
N = 100
x1 = rnorm(N,0,1)
x2 = rnorm(N,0,1)

#' Only this time we will lower our recapture probability, p.constant, from 1 to 0.5
chObj = Simulate.CH(surv.form = 1 + 0.15*x1 + 0*x2, p.constant = 0.5, N = N)
ch = chObj$ch 

cov = data.frame(x1 = x1, x2 = x2) 
MCMC = MARK.MCMC(ch = ch, cov = cov, n.iter = 1000, burn.in = 500, number.of.models = 5, 
n.chains = 2, add = TRUE, quad = TRUE, corr = TRUE)

#' look at our output
MCMC$pp
#' p should be close to 0.5
MCMC$p
MCMC$estimates
MCMC$gelman


#' Example 3 Test Only Addative Models
#' Same as before...
N = 100
x1 = rnorm(N,0,1)
x2 = rnorm(N,0,1)

#' Only this time we will lower our recapture probability, p.constant, from 1 to 0.5
chObj = Simulate.CH(surv.form = 1 + 0.15*x1 + 0*x2, p.constant = 0.5, N = N)
ch = chObj$ch 

cov = data.frame(x1 = x1, x2 = x2) 
#' Now we set quad = FALSE, corr = FALSE
MCMC = MARK.MCMC(ch = ch, cov = cov, n.iter = 1000, burn.in = 500, number.of.models = 5,
n.chains = 2, add = TRUE, quad = FALSE, corr = FALSE)

#' Let's look at the posterior probability  
#' It should only show the four possible addative models and blank slots for the rest
#' x1 should have the highest pp, since our data was simulated under those conditions
MCMC$pp


#' Example 3 Stabilizing selection
#' We will bump up the sample size to 500,
#' since stabilizing selection is  a little bit harder 
#' to detect with small sample sizes
N = 500
x1 = rnorm(N,0,1)

#' For stabilizing selection, we will add a term to our simulator: -0.15*x1^2
#' We will keep our recapture probability at an high value
chObj = Simulate.CH(surv.form = 1 + 0*x1 + -0.3*x1^2, p.constant = 0.7, N = N)
ch = chObj$ch 

cov = data.frame(x1 = x1) 

#' We will set corr = FALSE, since we only have one trait, x1
#' May take a few minutes ~5 minutes to run...
MCMC = MARK.MCMC(ch = ch, cov = cov, n.iter = 1000, burn.in = 500, number.of.models = 5, 
n.chains = 2, add = TRUE, quad = TRUE, corr = FALSE)

#' Let's look at the posterior probability  
#' x1^2 should be the model with the higher posterior probability 
MCMC$pp

#' x1^2 term should have an estimate close to -0.3
MCMC$estimates
}


}

\author{John Waller}
\keyword{models}
