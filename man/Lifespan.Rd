\name{Lifespan}
\alias{Lifespan}

\title{
minimum lifespan
}

\description{
Gives a  \code{vector} of minimum lifespans for each individual.
}

\usage{
Lifespan(ch)
}

\arguments{
  \item{ch}{input a matrix or a single-columned data.frame of capture histories. 
  It will return a vector of minimum lifespans for each row}
}

\details{ 
This function computes the mimimum lifespans given a capture history. 
This is computed as the first day seen subtracted by the last day seen. For example, 
an individual with the capture history of "1001" would have a minimum lifespan of 3; 
"1110" = 2; "1010" = 2, "01000001" = 6 etc. See examples.  
}

\value{ 
\item{vector}{A numerical vector of lifespans}
}

\examples{

#' set up variables to be used by Simulate.CH for ten individuals
N = 10 
x1 = rnorm(N) #' each trait is normally distributed

#' Run Simulate.CH with a constant recapture probability
chObj = Simulate.CH(surv.form = 1 + 0.15*x1, p.constant = 1, N = N)

attributes(chObj) #' see what is inside our object
ch_matrix = chObj$ch_split #' grab our matrix from the list
ch_matrix #' lets look at it

ch_df = chObj$ch #' lets grab a data.frame also
ch_df 

#' we can compute the minimum lifespan on either a matrix or a data.frame as input
Lifespan(ch_matrix) #' on a matrix
Lifespan(ch_df) #' on a data.frame


}

\author{
John Waller
}

\keyword{
utilities
} 
