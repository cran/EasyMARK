\name{Simulate.CH}
\alias{Simulate.CH}
\title{Simulate capture histories for individuals}
\description{This function will simulate capture histories  }
\usage{
Simulate.CH(surv.form, p.form, p.constant = NULL, surv.constant = NULL, 
N = 100, max.occ = 100, noise = 0.2)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{surv.form}{an expression dictating how survival probability should 
  depend on a given trait}
  \item{p.form}{an expression dictating how re-capture probability should depend on 
  a given trait }
  \item{p.constant}{ a constant value for recapture probability. Should be 
  between 0 and 1 }
  \item{surv.constant}{a constant value for survival probability. Should be between 
  0 and 1 }
  \item{N}{ the number of individual recapture histories to make. Should be the same 
  length as any "trait" variables }
  \item{max.occ}{the maximum number of re-capture occassions}
  \item{noise}{the level of random error to add. Probably should be a value between 0-1, 
  but probably not much higher than 1}
}

\details{
This function will produce simulated capture histories. It is designed to simulate traits 
under some selection pressure. As of now
it does not simulate time or age dependent effects. See the examples for how to implement 
various types of selection.  

}
\value{

Returns a list:

\item{$ch }{a single-columned data.frame of capture histories, one row for each indvidual}
\item{$ch_split }{a matrix of capture histories, one row for each individual}
\item{$p}{a vector of recapture probabilities, one for each individual}
\item{$phi}{a vector of survival probablities, one for each individual }

}

\examples{

#' a simple example to start with... 
N = 10 #' number of individual capture histories 

trait = rnorm(N,0,1) #' make a normal distributed trait value, with mean 0 and sd 1

#' here we will simulate a trait with positive linear selection
#' while keeping our recapture probability, p ,constant
chObj = Simulate.CH(surv.form = 1 + 0.15*trait, p.constant = 1, N = N)

#' negative moderate linear selection 
chObj = Simulate.CH(surv.form = 1 + -0.15*trait, p.constant = 1, N = N)

#' weaker negative linear selection 
chObj = Simulate.CH(surv.form = 1 + -0.05*trait, p.constant = 1, N = N)

#' very strong negative linear slection  
chObj = Simulate.CH(surv.form = 1 + -0.5*trait, p.constant = 1, N = N)

#' now lets add a stabilizing term
chObj = Simulate.CH(surv.form = 1 + -0.03*trait + -0.15*trait^2, p.constant = 1, N = N)

#' we can make selection disruptive simply by changing the sign
chObj = Simulate.CH(surv.form = 1 + -0.03*trait + 0.15*trait^2, p.constant = 1, N = N)

#' we can use multiple traits
trait1 = rnorm(N,0,1)
trait2 = rnorm(N,0,1)

#' negative linear selection on trait1 and positive selection on trait2
chObj = Simulate.CH(surv.form = 1 + -0.5*trait1 + 0.5*trait2, p.constant = 1, N = N)

#' stabilizing selection on trait1 and positive selection on trait2
chObj = Simulate.CH(surv.form = 1 + 0.03*trait1 + -0.5*trait^2 + 
0.5*trait2, p.constant = 1, N = N)


#' We can also vary our intercept term
N = 10
trait1 = rnorm(N,0,1)

chObj = Simulate.CH(surv.form = 0 + 0.13*trait1, p.constant = 1, N = N)

phi = chObj$phi #' lets grab the survival probability 
mean(phi) #' lets get the mean survival probability 

#' Now lets raise the intercept value
chObj = Simulate.CH(surv.form = 2 + 0.13*trait1, p.constant = 1, N = N)

phi = chObj$phi
#' We see that the intercept term controls the mean survival probability 
mean(phi) #' this value should be higher now


#'We can now play with recapture probability, p.constant 
N = 10 
trait = rnorm(N,0,1)

#' p.constant at 0.5, we see individuals in our population 50% of the time 
chObj = Simulate.CH(surv.form = 1 + 0.15*trait, p.constant = 0.5, N = N)

#' p.constant at 0.1, we see individuals in our population 10% of the time 
chObj = Simulate.CH(surv.form = 1 + 0.15*trait, p.constant = 0.1, N = N)


#' We can make recapture probability dependent on some trait in the same way 
N = 10
trait = rnorm(N,0,1)

#' Here is a situation with weak linear selection but strong bias in detection probability 
#' for a given trait
chObj = Simulate.CH(surv.form = 1 + 0.03*trait, p.form = 1 + 0.5*trait)


#' Finally we can make survival probability constant and recapture probability 
#' dependent on some trait
chObj = Simulate.CH(p.form = 1 + 0.5*trait, surv.constant = 0.8)

#' One more thing, let's look at the structure chObj list
str(chObj)
chObj$ch #' is a data.frame of capture histories 
chObj$ch_split #' is a matrix of capture histories 
chObj$p #' is a vector of recapture probabilities 




}

\author{John Waller}
\keyword{datagen}

