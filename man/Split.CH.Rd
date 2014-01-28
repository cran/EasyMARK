\name{Split.CH}
\alias{Split.CH}

\title{Split a capture history data.frame }
\description{Splits a data.frame into a matrix}
\usage{
Split.CH(ch)
}
\arguments{
  \item{ch}{a single-column data.frame of class character to split}
}
\details{Mark-recapture software often requires data in split form, 
with each value in its own matrix cell. Here is a function to split a 
data.frame into a matrix with each column representing a capture occassion and 
each row representing an 
individual's capture history}
\value{
 A matrix of 1's and 0's, a row for each individual.  
}

\seealso{
\code{\link{Collapse.CH}}
}
\examples{


#' set up variables to be used by Simulate.CH for ten individuals
N = 10 
x1 = rnorm(N) #' each trait is normally distributed

#' Run Simulate.CH with a constant recapture probability
chObj = Simulate.CH(surv.form = 1 + 0.15*x1, p.constant = 1, N = N)
str(chObj)
ch = chObj$ch #' grab our data.frame
ch #' it isn't split

Split.CH(ch) #' returns a matrix

}

\author{John Waller}
\keyword{utilities}
