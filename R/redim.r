"redim" <- function(object,dim=c(1,2)){
  test.class.ghyp(object,case="ghypmv")
  dim <- as.integer(dim)
  if(min(dim)>=1 & max(dim)<= object@dimension){
    if(sum(dim(object@data))==2){
      data=NULL
    }else{
      data=object@data[,dim]
    }
    if(length(dim)==1){
      return(ghyp(lambda = object@lambda,alpha.bar=object@alpha.bar,
                  mu = object@mu[dim],sigma=sqrt(object@sigma[dim,dim]),
                  gamma=object@gamma[dim],data=data))
    }else{
      return(ghyp(lambda = object@lambda,alpha.bar=object@alpha.bar,
                  mu = object@mu[dim],sigma=object@sigma[dim,dim],
                  gamma=object@gamma[dim],data=data))
    }
  }else{
    stop("Dimension mismatch. ghyp dimension = ", object@dimension,
         "; Input = ",paste(dim,collapse=", "),"!\n",sep="")
  }
}

