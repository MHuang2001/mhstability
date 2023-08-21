convert = function(s){
  return((as.vector(s$phat[,ncol(s$phat)]) |> sort(decreasing = T))*100)
}
