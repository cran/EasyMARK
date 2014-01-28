\name{Collapse.CH}
\alias{Collapse.CH}
\title{Collapse a capture history matrix}
\description{
Collapses a capture history matrix into a single-columned data.frame. 
}
\usage{
Collapse.CH(ch)
}

\arguments{
 \item{ch}{ Input a \code{matrix} of 1's and 0's to be collapsed. 
 Most likely this matrix will have one individual per row and one capture occassion 
 per column. }
}
\details{
Some mark-recapture programs want data in collapsed form, as a character string. 
This function will collapse a matrix into a single columned character sring of 
ones and zeros.  
}
\value{
 \item{\code{data.frame} of capture histories}{Returns a single-columned data frame of 
 the capture histories as a character string. }
}

\seealso{
 \code{\link{Split.CH}}
}
\examples{

#' set up variables to be used by Simulate.CH for ten individuals
N = 10 
x1 = rnorm(N) #' each trait is normally distributed

#' Run Simulate.CH with a constant recapture probability
chObj = Simulate.CH(surv.form = 1 + 0.15*x1, p.constant = 1, N = N)

attributes(chObj) #' see what is inside our object
ch = chObj$ch_split #' grab our matrix from the list
ch #' lets look at it

Collapse.CH(ch) #' now let's turn it into a data.frame


}

\author{John Waller
}
\keyword{ utilities
}

