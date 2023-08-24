#' Plot stabsel object
#' @param s A stabsel object
#' @param which Either 1 to plot variable probability, or 2 to plot likelihood function
#' @param threshold Show selected MTS or ATS variables. Either "ATS" or "MTS"
#' @param top A number plotting the top number of variables. Use "all" to plot all selected variables
#' @returns Variable Probability or Likelihood Plot
#' @examples
#' library(mhstability)
#' y = mtcars[,2]
#' X = mtcars[,3:ncol(mtcars)]
#' res = stabs::stabsel(x = X, y = y, B = 50, fitfun = stabs::lars.lasso, PFER = 2, cutoff = 0.6, sampling.type = "SS", assumption = "r-concave")
#' mhstability::plot_stabs(res, which = 1)
#' mhstability::plot_stabs(res, which = 2)
#' @export
#' @import ggplot2
#' @importFrom tibble rownames_to_column
#' @import Rcpp
#' @useDynLib mhstability
#' @import dplyr
#' @importFrom forcats fct_reorder
#' @references Hofner, B. and Hothorn, T. (2021). stabs: Stability Selection with Error Control.
#'
#' Meinshausen, N. and Buehlmann, P. (2009). Stability Selection. arXiv:0809.2932 [stat]
#'
#' Shah, R. D. and Samworth, R. J. (2013). Variable selection with error control:
#' another look at stability selection. Journal of the Royal Statistical Society. Series B (Statistical
#' Methodology), 75(1):55–80. Publisher: Wiley.
#'
#' Zhu, M. and Ghodsi, A. (2006). Automatic dimensionality selection from the scree plot via the use of profile likelihood.
#' Computational Statistics & Data Analysis, 51(2):918–930.


plot_stabs = function(s, which = 1, threshold = "ATS", top = ifelse(s$p < 10, s$p, 10)){
  if(class(s) != "stabsel"){
    stop("s must be an ouptut of stabs::stabsel")
  }
  if (which != 1 & which != 2){
    stop("Which must be either 1 or 2")
  }
  if (top > s$p){
    warning("Variables selected is greater than p. Only displaying top p.")
    top = s$p
  }
  if(s$assumption == "r-concave" | s$assumption  == "unimodal"){
    B = s$B*2
    sample.type.nice = ifelse(s$assumption == "r-concave",  "CPSS (r-concave)", "CPSS (Unimodal)")
  }else{
    B = s$B
    sample.type.nice = "Random Subsampling"
  }

  if (threshold != "ATS" & threshold != "MTS"){
    stop("Threshold must be either ATS or MTS")
  }
  if (which == 1){
    q = getR(convert(s))
    q_val = (sort(s$phat[,ncol(s$phat)], decreasing = T)[q]) |> as.vector()
    el = tibble::rownames_to_column(data.frame(s$phat[,ncol(s$phat)]))
    colnames(el) = c("variable", "value")
    if(threshold == "ATS"){
      el$Legend = dplyr::case_when(el$value >= q_val ~ "Selected",
                                   el$value < q_val ~ "Not Selected")
    }
    else if(threshold == "MTS"){
      el$Legend = dplyr::case_when(el$value >= s$cutoff ~ "Selected",
                                   el$value < s$cutoff ~ "Not Selected")
    }

    el$Legend = factor(el$Legend, levels = c("Selected","Not Selected"))

    el = el[order(el$value, decreasing = T),]
    if(top == "all"){
      el_top = el[el$value >= ifelse(threshold == "ATS", q_val, s$cutoff),]
      if(nrow(el_top) == 0){
        stop("MTS Selects 0 variables")
      }else{
        Yaxis = round(nrow(el_top)/2)
      }
    }else{
      el_top = el[order(el$value, decreasing = T),][1:top,]
      Yaxis = round(top/2)
    }

    plot1 = (el_top |>  dplyr::mutate(variable = forcats::fct_reorder(variable, value, .desc = F))) |>
      ggplot2::ggplot(ggplot2::aes(variable, value)) +
      ggplot2::geom_line(group = 1) + ggplot2::geom_point(size = 3,
                                                          ggplot2::aes(shape = Legend,color = Legend, fill = Legend)) +
      ggplot2::scale_shape_manual(values = c(22,24)) + ggplot2::scale_color_manual(values = c("black", "black")) +
      ggplot2::geom_hline(yintercept = s$cutoff, colour = "red", linetype = "dashed")  +
      ggplot2::annotate("text",label = paste("MTS: ", s$cutoff) ,x = Yaxis, y = s$cutoff - 0.005, size = 3, color = "black", angle = 90) +
      ggplot2::geom_hline(yintercept = q_val, colour = "blue", linetype = "dashed") +
      ggplot2::annotate("text", label = paste("ATS: ", q_val), x = Yaxis, y = q_val - 0.005, colour = "black", size = 3, angle = 90) +
      ggplot2::theme_bw(base_size = 8) + ggplot2::ylab("Frequency Chosen") +
      ggplot2::xlab("Variables")  + ggplot2::labs(caption = paste(threshold,sample.type.nice, "; LASSO")) +
      ggplot2::theme(legend.position = "top") + ggplot2::coord_flip()

    return(plot1)
  }

  if (which == 2){
    q = getR(convert(s))
    lq = getLQ(convert(s))
    q_val = (sort(s$phat[,ncol(s$phat)], decreasing = T)[q]) |> as.vector()
    return(elbow_stabs(q,lq))
  }
}

