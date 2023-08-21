elbow_stabs <- function(q,lq) {
  df = data.frame(lq)
  plot = ggplot2::ggplot(df, ggplot2::aes(y = lq, x = 1:nrow(df))) + ggplot2::geom_line() +
      ggplot2::geom_vline(xintercept = q, linetype = "dashed", color = "blue") +
      ggplot2::ggtitle(paste("Maximum Index = ", q)) +
      ggplot2::xlab("Index") + ggplot2::ylab("Profile Log-Likelihood") +
      ggplot2::xlim(1,NA)+
      ggplot2::theme_bw()

  return(plot)
}
