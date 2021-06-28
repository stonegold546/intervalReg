#' Model summary
#'
#' @param object fitted object
#' @return Print summary of fitted model.
#' @export
model.summary <- function (object) {
  bbmle::summary(object)
}
