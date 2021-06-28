#' Perform interval censored-regression assuming data are beta-binomial
#'
#' @param formula an object of class "formula" (or one that can be coerced to that class).
#'     Must be of form: cbind(lower, upper) ~ ... where lower is the lower bound and upper
#'     is the upper bound.
#' @param data a data frame, list or environment (or object coercible by
#'     as.data.frame to a data frame) containing the variables in the model
#' @param max number of items summed to create the original scores
#' @param link link function, either logit (default) or probit
#' @return A fitted model object of class mle2, Call model.summary() function for inference.
#' @export
int.betabinomial <- function (formula, data, max, link = "logit", ...) {
  if (!link %in% c("logit", "probit")) stop("Link function must be one of logit or probit.")
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
  if (any(lo > max | hi > max)) {
    stop("Limits cannot be greater than upper bound")
  }
  lo <- ifelse(lo == 0, lo, lo - 1)
  X <- model.matrix(formula, dat.frame)
  k <- ncol(X)
  int.nLL <- function (params) {
    beta.s <- params[1:k]
    phi.hat <- exp(params[length(params)])
    if (link == "logit") mu.hat <- plogis(X %*% beta.s)
    else mu.hat <- pnorm(X %*% beta.s)
    a.s <- mu.hat * phi.hat
    b.s <- phi.hat - a.s
    -sum(log(extraDistr::pbbinom(hi, max, a.s, b.s) -
               extraDistr::pbbinom(lo, max, a.s, b.s)))
  }
  bbmle::parnames(int.nLL) <- c(colnames(X), "log(Overdispersion)")
  start.vals <- setNames(rep(0, k + 1), c(colnames(X), "log(Overdispersion)"))
  bbmle::mle2(int.nLL, start = start.vals, vecpar = TRUE, ...)
  # optim(rep(0, k + 1), int.nLL, hessian = TRUE, ...)
}
