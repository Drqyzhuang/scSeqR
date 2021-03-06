% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run.diff.st.R
\name{run.diff.st}
\alias{run.diff.st}
\title{Differentiation spacetime}
\usage{
run.diff.st(x = NULL, dist.method = "euclidean")
}
\arguments{
\item{x}{An object of class scSeqR.}

\item{dist.method}{the distance measure to be used to compute the dissimilarity matrix. This must be one of: "euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski" or "NULL". By default, distance="euclidean". If the distance is "NULL", the dissimilarity matrix (diss) should be given by the user. If distance is not "NULL", the dissimilarity matrix should be "NULL".}
}
\value{
An object of class scSeqR.
}
\description{
This function takes an object of class scSeqR and finds their progenitor cells based on distance.
}
\examples{
\dontrun{
my.obj <- dst(my.obj)
}
}
