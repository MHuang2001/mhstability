#' Compute index and probability of stable threshold using automatic threshold selection
#' @param s A stabsel object
#' @param type Either "index" or "prob" to return index or probability threshold
#' @returns Index or probability of the last selected threshold


ats = function(s, type = "index"){
  if(type != "index" & type != "prob"){
    stop("type must be either index or prob")
  }
  q = getR(convert(s))
  q_val = (sort(s$phat[,ncol(s$phat)], decreasing = T)[q]) |> as.vector()
  res = ifelse(type == "prob", q_val, q)
  return(res)
}
