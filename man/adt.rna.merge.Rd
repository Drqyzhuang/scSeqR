% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adt.rna.merge.R
\name{adt.rna.merge}
\alias{adt.rna.merge}
\title{Merge RNA and ADT data}
\usage{
adt.rna.merge(x = NULL, adt.data = "raw")
}
\arguments{
\item{x}{An object of class scSeqR.}

\item{adt.data}{Choose from raw or main (normalized) ADT data. Defult = "raw"}
}
\value{
An object of class scSeqR
}
\description{
This function is to merge the RNA and ADT data to the main.data slot of the scSeqR object.
}
\examples{
\dontrun{
my.obj <- adt.rna.merge(my.obj, adt.data = "raw")
}

}
