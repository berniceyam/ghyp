"show.ghyp" <- function(object)
{
  cat(object@model, "Distribution:\n", sep=" ")
  cat("\nParameters:\n")
  if(object@dimension > 1){
    if(object@parametrization == "lambda.chi.psi"){
      param <- c(object@lambda, object@chi, object@psi)    
      names(param) <- c("lambda", "chi", "psi")
    }else{
      param <- c(object@lambda, object@alpha.bar)
      names(param) <- c("lambda", "alpha.bar")
    }
    if(length(grep("Student-t", object@model)) == 1){
      # Student-t  ->  alpha.bar == 0
      nu <- -2*object@lambda
      param <- c(nu = unname(nu))
    }else if(length(grep("Variance", object@model)) == 1){
      # VG  ->  alpha.bar == 0 or chi == 0
      if(object@parametrization == "lambda.chi.psi"){
        param <- param[c(1, 3)]
      }else{
        param <- param[1]
      }
    }else if(length(grep("Generalized", object@model)) == 1){
      # ghyp
      dummy <- NULL 
      # identification problem when scanning for Hyperbolic
      # since this pattern occurs in 'Gen. Hyp.' and 'Hyp.' 
    }else{
      # hyp or NIG -> lambda set constant
      # hyp  ->  lambda == (dimension + 1) / 2 
      # NIG  ->  lambda == -0.5
      param <- param[2:length(param)]    
    }
    print(param)
    cat("\nmu:\n")
    print(object@mu)
    cat("\nsigma:\n")
    print(object@sigma)
    cat("\ngamma:\n")
    print(object@gamma)  
  }else{
    if(object@parametrization == "lambda.chi.psi"){
      param <- c(object@lambda, object@chi, object@psi, 
                 object@mu, object@sigma, object@gamma)    
      names(param) <- c("lambda", "chi", "psi", "mu", "sigma", "gamma")
    }else{
      param <- c(object@lambda, object@alpha.bar, 
                 object@mu, object@sigma, object@gamma)
      names(param) <- c("lambda", "alpha.bar", "mu", "sigma", "gamma")
    }
    if(length(grep("Student-t", object@model)) == 1){
      # Student-t  ->  alpha.bar == 0
      nu <- -2*object@lambda
      param[1] <- nu
      names(param)[1] <- "nu"
      param <- param[c(1, 3:5)]
    }else if(length(grep("Variance", object@model)) == 1){
      # VG  ->  alpha.bar == 0 or chi == 0
      if(object@parametrization == "lambda.chi.psi"){
        param <- param[c(1, 3:6)]
      }else{
        param <- param[c(1, 3:5)]
      }
    }else if(length(grep("Generalized", object@model)) == 1){
      # ghyp
      dummy <- NULL 
      # identification problem when scanning for Hyperbolic
      # since this pattern occurs in 'Gen. Hyp.' and 'Hyp.' 
    }else{
      # hyp or NIG -> lambda set constant
      # hyp  ->  lambda == (dimension + 1) / 2 
      # NIG  ->  lambda == -0.5
      param <- param[2:length(param)]    
    }
    print(param)
  }

}

setMethod("show", signature(object = "ghyp"), show.ghyp)