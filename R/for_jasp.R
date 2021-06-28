do_normal <- function (jaspResults, dataset = NULL, options) {
  ready <- options$lower != "" && options$upper != "" &&
    (length(unlist(options$predictors)) > 0 || options$interceptOnly)

  if (ready) {
    if (options$interceptOnly) {
      formula.0 <- as.formula(paste0(
        "cbind(", options$lower, ", ", options$upper, ") ~ 1"))
      variables <- c(options$lower, options$upper)
    } else {
      formula.0 <- as.formula(paste0(
        "cbind(", options$lower, ", ", options$upper, ") ~ ",
        paste0(unlist(options$predictors), collapse = " + ")))
      variables <- c(options$lower, options$upper, unlist(options$predictors))
    }
    dataset <- readData(dataset, variables)
    model <- int.normal(formula.0, dataset)
    # print(model)
    table <- createJaspTable(title = "Regression coefficients")
    jaspResults[["head"]] <- table
    table$setData(model.summary(model))
    # int.normal()
    # return(formula.0)
  }
}
do_beta <- function (jaspResults, dataset = NULL, options) {

}
do_bd <- function (jaspResults, dataset = NULL, options) {

}

readData <- function(dataset, variables) {
  if (!is.null(dataset)) return(dataset)
  result <- .readDataSetToEnd(columns = variables)
  colnames(result) <- variables
  return(result)
}
