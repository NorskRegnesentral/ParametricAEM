#' Calculate age-reading error matrix from parameters
#'
#' @param par Numerical vector containing the parameters
#'            for calculating the age-reading error matrix
#'            in order: beta0, beta1, alpha0, alpha1, phi
#' @param min_age Integer, minimum age
#' @param max_age Integer, maximum age
#'
#' @return Matrix, age-reading error matrix
#' @export
#'
#' @examples
#' params = c(4.504, -0.31287, 0, 0, 0.2103217)
#' Calculate_matrix(params, 3, 12)
Calculate_matrix = function(par, min_age, max_age){
    fitted_matrix = matrix(0, nrow = max_age, ncol = max_age)
    beta0 = par[1]
    beta1 = par[2]
    alpha0 = par[3]
    alpha1 = par[4]
    phi = par[5]
    for(i in min_age:max_age){
        paa = exp(beta0 + beta1 * i) / (1 + exp(beta0 + beta1 * i))
        qa = exp(alpha0 + alpha1 * i) / (1 + exp(alpha0 + alpha1 * i))

        for(j in min_age:max_age){
            if(i == j){
                fitted_matrix[i, j] = paa
            }
            if(i == max_age & j == max_age){
                fitted_matrix[i, j] = qa + paa - qa * paa
            }
            if(i == min_age & j == min_age){
                fitted_matrix[i, j] = 1 - qa + paa * qa
            }
            if(j > i){
                if(j == max_age){
                    fitted_matrix[i, j] = (1 - paa) * qa * phi ^ (max_age - i - 1)
                }else{
                    fitted_matrix[i, j] = (1 - paa) * qa * (1 - phi) * phi ^ (j - 1 - i)
                }

            }
            if(i > j){
                d = i - min_age
                fitted_matrix[i, j] = (1 - paa) * (1 - qa) * phi ^ (i - j - 1)  * (1 - phi) / (1 - phi ^ (d))
            }
        }
    }

    fitted_matrix = fitted_matrix[rowSums(fitted_matrix) != 0, rowSums(fitted_matrix) != 0]
    rownames(fitted_matrix) = min_age:max_age
    colnames(fitted_matrix) = min_age:max_age
    return(fitted_matrix)
}
