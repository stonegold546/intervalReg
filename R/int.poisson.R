#' Perform interval censored-regression assuming data are binomial
#'
#' @param formula an object of class "formula" (or one that can be coerced to that class).
#'     Must be of form: cbind(lower, upper) ~ ... where lower is the lower bound and upper
#'     is the upper bound.
#' @param data a data frame, list or environment (or object coercible by
#'     as.data.frame to a data frame) containing the variables in the model
#' @return A fitted model object of class mle2, Call model.summary() function for inference.
#' @export
int.poisson <- function (formula, data, ...) {
  dat.frame <- model.frame(formula, data, na.action = na.omit)
  Y <- model.response(dat.frame)
  lo <- Y[, 1]
  hi <- Y[, 2]
  if (any(lo > hi)) {
    stop("Lower limits must be less than or equal to upper limits")
  }
  if (any(lo < 0 | hi < 0)) {
    stop("Limits cannot be less than zero")
  }
  lo <- ifelse(lo == 0, lo, lo - 1)
  X <- model.matrix(formula, dat.frame)
  k <- ncol(X)
  int.nLL <- function (params) {
    mu.hat <- exp(X %*% params)
    -sum(log(ppois(hi, mu.hat) - ppois(lo, mu.hat)))
  }
  bbmle::parnames(int.nLL) <- colnames(X)
  start.vals <- setNames(rep(0, k), colnames(X))
  bbmle::mle2(int.nLL, start = start.vals, vecpar = TRUE, ...)
  # optim(rep(0, k), int.nLL, hessian = TRUE, ...)
}
