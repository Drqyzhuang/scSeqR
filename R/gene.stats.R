#' Make statistical information for each gene across all the cells (SD, mean, expression, etc.)
#'
#' This function takes an object of class scSeqR and provides some statistical information for the genes.
#' @param x An object of class scSeqR.
#' @param which.data Choose from "raw.data" or "main.data", defult = "raw.data".
#' @return An object of class scSeqR.
#' @examples
#' \dontrun{
#' my.obj <- gene.stats(my.obj, which.data = "main.data")
#' }
#' @export
gene.stats <- function (x = NULL,
                        which.data = "raw.data",
                        each.cond = F) {
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
  # get conditions
  if (each.cond == T) {
    do <- data.frame(do.call('rbind', strsplit(as.character(colnames(DATA)),'_',fixed=TRUE)))[1]
    Myconds <- as.character(as.matrix(unique(do)))
    if (length(Myconds) > 1) {
      for (i in Myconds) {
        ha <- subset(do, do == i)
        dim2 <- max(as.numeric(rownames(ha)))
        dim1 <- min(as.numeric(rownames(ha)))
        myDATA <- DATA[dim1:dim2]
        mymat = as.matrix(myDATA)
        SDs <- apply(mymat, 1, function(mymat) {sd(mymat)})
        Table <- list(row.names(myDATA),
                      as.numeric(rowSums(myDATA > 0)),
                      rep(dim(myDATA)[2], dim(myDATA)[1]),
                      (as.numeric(rowSums(myDATA > 0)) / dim(myDATA)[2])*100,
                      as.numeric(rowMeans(myDATA)),
                      as.numeric(SDs))
        names(Table) <- c("genes","numberOfCells","totalNumberOfCells","percentOfCells","meanExp","SDs")
        Table <- as.data.frame(Table)
        Table <- cbind(Table, condition = i)
        NameCol=paste("MyGeneStat",i,sep="_")
        eval(call("<-", as.name(NameCol), Table))
      }
    }
  }
  ###### do it for all too
  # calculate
  mymat = as.matrix(DATA)
  SDs <- apply(mymat, 1, function(mymat) {sd(mymat)})
  Table <- list(row.names(DATA),
                as.numeric(rowSums(DATA > 0)),
                rep(dim(DATA)[2], dim(DATA)[1]),
                (as.numeric(rowSums(DATA > 0)) / dim(DATA)[2])*100,
                as.numeric(rowMeans(DATA)),
                as.numeric(SDs))
  names(Table) <- c("genes","numberOfCells","totalNumberOfCells","percentOfCells","meanExp","SDs")
  Table <- as.data.frame(Table)
  MyGeneStat_all <- cbind(Table, condition = "all")
  ### merge
  filenames <- ls(pattern="MyGeneStat_")
  datalist <- mget(filenames)
  Table <- do.call(rbind.data.frame, datalist)
  row.names(Table) <- NULL
  attributes(x)$gene.data <- Table
  return(x)
}
