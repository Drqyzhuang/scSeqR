% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stats.plot.R
\name{stats.plot}
\alias{stats.plot}
\title{Plot nGenes, UMIs and perecent mito}
\usage{
stats.plot(x = NULL, plot.type = "box.umi",
  cell.color = "slategray3", cell.size = 1, cell.transparency = 0.5,
  box.color = "red", box.line.col = "green", back.col = "white",
  interactive = TRUE, out.name = "plot")
}
\arguments{
\item{x}{An object of class scSeqR.}

\item{plot.type}{Choose from "box.umi", "box.mito", "box.gene", "box.s.phase", "box.g2m.phase","all.in.one", "point.mito.umi", "point.gene.umi".}

\item{cell.color}{Choose a color for points in the plot.}

\item{cell.size}{A number for the size of the points in the plot, defult = 1.}

\item{cell.transparency}{Color transparency for points in "scatterplot" and "boxplot", defult = 0.5.}

\item{box.color}{A color for the boxes in the "boxplot", defult = "red".}

\item{box.line.col}{A color for the lines around the "boxplot", defult = "green".}

\item{interactive}{If set to TRUE an intractive HTML file will be created, defult = TRUE.}

\item{out.name}{If "interactive" is set to TRUE, the out put name for HTML, defult = "plot".}
}
\value{
An object of class scSeqR.
}
\description{
This function takes an object of class scSeqR and creats QC plot.
}
\examples{
\dontrun{
stats.plot(my.obj,
          plot.type = "box.gene.umi.mito",
          out.name = "UMI-plot",
          interactive = F,
          cell.color = "slategray3",
          cell.size = 1,
          cell.transparency = 0.5,
          box.color = "red",
          box.line.col = "green",
          back.col = "white")

stats.plot(my.obj, plot.type = "point.gene.umi", interactive = T, out.name = "scatter.gene.umi")

stats.plot(my.obj, plot.type = "point.mito.umi", interactive = T, out.name = "scatter.mito.umi")
}
}
