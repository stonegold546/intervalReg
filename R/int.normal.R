#' Perform interval censored-regression assuming data are normally distributed
#'
#' @param formula an object of class "formula" (or one that can be coerced to that class).
#'     Must be of form: cbind(lower, upper) ~ ... where lower is the lower bound and upper
#'     is the upper bound.
#' @param data a data frame, list or environment (or object coercible by
#'     as.data.frame to a data frame) containing the variables in the model
#' @return A fitted model object of class mle2, Call model.summary() function for inference.
#' @export
int.normal <- function (formula, data, ...) {
  dat.frame <- model.frame(formula, data, na.action = na.omit)
  Y <- model.response(dat.frame)
  lo <- Y[, 1]
  hi <- Y[, 2]
  if (any(lo > hi)) {
    stop("Lower limits must be less than or equal to upper limits")
  }
  X <- model.matrix(formula, dat.frame)
  k <- ncol(X)
  int.nLL <- function (params) {
    beta.s <- params[1:k]
    sigma <- exp(params[length(params)])
    mu.hat <- X %*% beta.s
    -sum(log(pnorm(hi, mu.hat, sigma) - pnorm(lo, mu.hat, sigma)))
  }
  bbmle::parnames(int.nLL) <- c(colnames(X), "log(Residual SD)")
  start.vals <- setNames(rep(0, k + 1), c(colnames(X), "log(Residual SD)"))
  bbmle::mle2(int.nLL, start = start.vals, vecpar = TRUE, ...)
  # optim(rep(0, k + 1), int.nLL, hessian = TRUE, ...)
}
