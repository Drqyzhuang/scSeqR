#' Run PCA on the main data
#'
#' This function takes an object of class scSeqR and runs PCA on the main data.
#' @param x An object of class scSeqR.
#' @param clust.method Choose from "base.mean.rank" or "gene.model", defult is "base.mean.rank".
#' @param top.rank A number taking the top genes ranked by base mean, defult = 500.
#' @param gene.list A list of genes to be used for PCA. If "clust.method" is set to "gene.model", defult = "my_model_genes.txt".
#' @return An object of class scSeqR.
#' @examples
#' \dontrun{
#' my.obj <- run.pca(my.obj, clust.method = "gene.model", gene.list = "my_model_genes.txt")
#' }
#' @export
run.pca <- function (x = NULL,
                          clust.method = "base.mean.rank",
                          top.rank = 500,
                          batch.norm = F,
                          gene.list = "character") {
  if ("scSeqR" != class(x)[1]) {
    stop("x should be an object of class scSeqR")
  }
  # geth the genes and scale them based on model
  DATA <- x@main.data
  # model base mean rank
  if (clust.method == "base.mean.rank") {
    raw.data.order <- DATA[ order(rowMeans(DATA), decreasing = T), ]
    topGenes <- head(raw.data.order,top.rank)
    TopNormLogScale <- log(topGenes + 0.1)
#    TopNormLogScale <- t(TopNormLogScale)
#    TopNormLogScale <- as.data.frame(t(scale(TopNormLogScale)))
  }
  # gene model
  if (clust.method == "gene.model") {
    if (gene.list[1] == "character") {
      stop("please provide gene names for clustering")
    } else {
      genesForClustering <- gene.list
      topGenes <- subset(DATA, rownames(DATA) %in% genesForClustering)
      if (batch.norm == F){
         TopNormLogScale <- log(topGenes + 0.1)
        # TopNormLogScale <- scale(topGenes)
      }
      if (batch.norm == T){
        ## new method
        libSiz <- colSums(topGenes)
        norm.facts <- as.numeric(libSiz) / mean(as.numeric(libSiz))
        dataMat <- as.matrix(topGenes)
        normalized <- as.data.frame(sweep(dataMat, 2, norm.facts, `/`))
        # TopNormLogScale <- log(normalized + 0.1)
        TopNormLogScale <- normalized
      }
    }
  }
# Returns
  # info
    counts.pca <- prcomp(TopNormLogScale, center = T, scale. = T)
    attributes(x)$pca.info <- counts.pca
    # DATA
    dataPCA = data.frame(counts.pca$rotation) # [1:max.dim]
    attributes(x)$pca.data <- dataPCA
    # optimal
    DATA <- counts.pca$sdev
    OPTpcs <- mean(DATA)*2
    OPTpcs <- (DATA > OPTpcs)
    OPTpcs <- length(OPTpcs[OPTpcs==TRUE]) + 1
    attributes(x)$opt.pcs <- OPTpcs
    # object
  return(x)
}
