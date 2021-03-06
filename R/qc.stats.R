#' Calculate the number of UMIs and genes per cell and percentage of mitochondrial genes per cell.
#'
#' This function takes data frame and calculates the number of UMIs, genes per cell and percentage of mitochondrial genes per cell.
#' @param x A data frame containing gene counts for cells.
#' @return The data frame object
#' @examples
#' \dontrun{
#' UMIs.genes.mit(my.data)
#' }
#' @export
qc.stats <- function (x = NULL,
                      which.data = "raw.data",
                      mito.genes = "defult",
                      s.phase.genes = s.phase,
                      g2m.phase.genes = g2m.phase) {
  if ("scSeqR" != class(x)[1]) {
    stop("x should be an object of class scSeqR")
  }
  # get data
  if (which.data == "raw.data") {
    DATA <- x@raw.data
  }
  if (which.data == "main.data") {
    DATA <- x@main.data
  }
  # get UMIs
  UMIs <- colSums(DATA)
  # get nGENEs
  nGenes <- sapply(DATA, function(DATA) length(as.numeric(subset(DATA, DATA != 0))))
  # get mito gene names
  if (mito.genes == "defult") {
    mito.genes <- grep(pattern = "^mt\\-", x = rownames(DATA), value = TRUE, ignore.case = TRUE)
    if ( length(mito.genes) == 0 ) {
      mito.genes <- grep(pattern = "^mt\\.", x = rownames(DATA), value = TRUE, ignore.case = TRUE)
    }
  }
  if (mito.genes[1] != "defult") {
    mito.genes = mito.genes
  }
  # get mito percent
  mito <- subset(DATA,rownames(DATA) %in% mito.genes)
  mitoSiz <- colSums(mito)
  mito.percent <- (mitoSiz/UMIs)
  # get cell cycle genes
  data <- row.names(DATA)
  # s
  s.phase.genes <- paste("^",s.phase.genes,"$", sep="")
  s.phase.genes <- paste(s.phase.genes,collapse="|")
  s.phase.genes <- grep(s.phase.genes, x = data, value = T, ignore.case = TRUE)
  s.phase.genes <- subset(DATA,rownames(DATA) %in% s.phase.genes)
  s.phase.genes <- colSums(s.phase.genes)
  s.phase.genes <- (s.phase.genes/UMIs)
  # g2m
  g2m.phase.genes <- paste("^",g2m.phase.genes,"$", sep="")
  g2m.phase.genes <- paste(g2m.phase.genes,collapse="|")
  g2m.phase.genes <- grep(g2m.phase.genes, x = data, value = T, ignore.case = TRUE)
  g2m.phase.genes <- subset(DATA,rownames(DATA) %in% g2m.phase.genes)
  g2m.phase.genes <- colSums(g2m.phase.genes)
  g2m.phase.genes <- (g2m.phase.genes/UMIs)
  # get all the data into DF
  QC <- list(colnames(DATA),
             as.numeric(nGenes),
             as.numeric(UMIs),
             as.numeric(mito.percent),
             as.numeric(s.phase.genes),
             as.numeric(g2m.phase.genes))
  names(QC) <- c("CellIds",
                 "nGenes",
                 "UMIs",
                 "mito.percent",
                 "S.phase.probability",
                 "g2m.phase.probability")
  STATS <- as.data.frame(QC)
  attributes(x)$stats <- STATS
  return(x)
}
