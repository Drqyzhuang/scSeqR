% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/heatmap.plot.R
\name{heatmap.plot}
\alias{heatmap.plot}
\title{Create heatmaps for genes in clusters or conditions.}
\usage{
heatmap.plot(x = NULL, gene = "NULL", cluster.by = "clusters",
  cluster.rows = F, heat.colors = c("blue", "white", "red"))
}
\arguments{
\item{x}{A data frame containing gene counts for cells.}

\item{gene}{A set of gene names to be heatmapped.}

\item{cluster.by}{Choose from "clusters" or "conditions", defult = "clusters".}

\item{cluster.rows}{If set to FALSE the genes would not be clustered, defult = TRUE.}

\item{heat.colors}{Colors for heatmap, defult = c("blue" ,"white", "red").}

\item{scale}{Choose from "row" or "column", defult = "row".}
}
\value{
An object of class scSeqR
}
\description{
This function takes an object of class scSeqR and genes and provides a heatmap.
}
\examples{
\dontrun{
MyGenes <- c("SOD1","CD7")
MyGenes <- top.markers(marker.genes, topde = 10, min.base.mean = 0.8)
heatmap.plot (my.obj, gene = MyGenes, cluster.by = "clusters", cluster.rows = T)
}
}
