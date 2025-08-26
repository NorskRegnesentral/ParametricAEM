#' Compute modal ages per fish
#'
#' Takes a data frame of read ages with multiple readings per fish (identified by a unique identifier) and adds
#' the modal age(s) closest to the mean with weights, and the lowest modal age.
#'
#' @param data A data frame with one row per age-reading containing at least the columns:
#'  FishID, a unique identifier per fish
#'  age, an age-reading
#'
#' @return A data frame with three added columns:
#' modal_age_low, the lowest modal age
#' modal_age_closest, the modal age closest to the mean
#' weight, the corresponding weights for the modes (differs from 1 when the modal age closest to the mean is not unique)
#' @export
#'
#' @examples
#' file_path = system.file("extdata",
#'                         "NSS_herring_scales.csv",
#'                          package = "ParametricAEM")
#' data_nss_scales = read.csv(file_path, sep = ",")
#' data_exp = data_nss_scales[data_nss_scales$expertise == 1, ] # Extract experts
#' data_exp = data_exp[data_exp$age > 0, ]
#' data_analysis = Compute_modes(data_exp)
Compute_modes = function(data){
    fish_id = unique(data$FishID)
    data$modal_age_low = NA
    data$modal_age_closest = NA
    data$weight = 1

    for (i in 1:length(fish_id)){
        subdat = data[data$FishID == fish_id[i], ]
        tbl = table(subdat$age)
        ages = names(tbl)
        mod = ages[which(tbl == max(tbl))]
        data$modal_age_low[data$FishID == fish_id[i]] = as.numeric(mod[1])
        n = length(mod)
        if(n>1){
            mean_age = mean(subdat$age)
            dist = abs(as.numeric(mod) - mean_age)
            min_dist = mod[which(dist == min(dist))]
            data$modal_age_closest[data$FishID == fish_id[i]] = as.numeric(min_dist[1])
            if(length(min_dist) > 1){
                nm = length(min_dist)
                data$weight[data$FishID == fish_id[i]]  = 1/nm
                for(j in 2:nm){
                    extra = data[data$FishID == fish_id[i], ]
                    extra$modal_age_closest = as.numeric(min_dist[j])
                    extra$weight  = 1/nm
                    data = rbind(data, extra)
                }
            }
        }
        else{
            data$modal_age_closest[data$FishID == fish_id[i]] = as.numeric(mod)
        }
    }
    return(data)
}
