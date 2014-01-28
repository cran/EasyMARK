\name{Maker.CH}
\alias{Maker.CH}

\title{
Make a capture history from dates.
}

\description{
Creates a capture history from a vector of dates and individual ids.
}

\usage{
Maker.CH(dates = dates, id = id, date.format)
}

\arguments{
  \item{dates}{a character vector or factor of dates in any format (see below).}
  \item{id}{a character vector or factor of unique ids the same length as the dates vector.}
  \item{date.format}{a character Rstring specifying how the date should be 
  formatted.}
}

\details{
The  vector of dates should, including date first marked. The date vector should line up 
with id vector, with ids repeated for each date 
the idvidual was re-captured or seen. Right now it assumes the capture occassions are 
per day. This might change in the future, allowing 
per month or per year time periods. Ids do not have to be sorted, but must be repeated 
for each date the individual is seen. 
}
\value{
 \item{ch}{Returns a matrix of capture histories. Row names are the individual id names 
 and column names are the dates that individual was seen}
}

\examples{

#' our date vector, which should line up with the id vector
#' we would normally pull this from a data.frame from an external source
dates = c("2012_07_05","2012_07_01","2012_07_01", "2012_07_02", "2012_07_07", 
"2012_07_01", "2012_07_03", "2012_07_07")

#' ids lined up with our dates. Each id is repeated for each day seen, including the day 
#' it was marked.  
id = c("B","B","A","A","A","C","C","C")

#' See that our vectors are the same length
length(id)
length(dates)

#' date.format can be in a variety of forms: 
#' "%Y_%m_%d" = 2012_07_01
#' "%Y:%m:%d" = 2012:07:01
#' "%Y-%m-%d" = 2012-07-01
#' "%m-%Y-%d" = 07-2012-01
#' "%d-%m-%Y" = 01-07-2012
#' and so on...

#' run our function 
ch = Maker.CH(dates = dates, id = id, date.format = "\%Y_\%m_\%d")


#' out matrix with colnames as the dates seen and rownames as the individual ids
ch

}

\author{John Waller}

\keyword{utilities}


