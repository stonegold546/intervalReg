% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/int.poisson.R
\name{int.poisson}
\alias{int.poisson}
\title{Perform interval censored-regression assuming data are binomial}
\usage{
int.poisson(formula, data, ...)
}
\arguments{
\item{formula}{an object of class "formula" (or one that can be coerced to that class).
Must be of form: cbind(lower, upper) ~ ... where lower is the lower bound and upper
is the upper bound.}

\item{data}{a data frame, list or environment (or object coercible by
as.data.frame to a data frame) containing the variables in the model}
}
\value{
A fitted model object of class mle2, Call model.summary() function for inference.
}
\description{
Perform interval censored-regression assuming data are binomial
}
