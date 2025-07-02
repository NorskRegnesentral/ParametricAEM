
file_path = system.file("extdata",
                         "NSS_herring_scales.csv",
                          package = "ParametricAEM")
data_nss_scales = read.csv(file_path, sep = ",")
data_exp = data_nss_scales[data_nss_scales$expertise == 1, ] # Extract experts
data_exp = data_exp[data_exp$age > 0, ]
data_analysis = Compute_modes(data_exp)
data_analysis_capped = Cap_ages(data_analysis, min_age = 3, max_age = 12)

### Fit the different models ###


# Full model
fit1 = Estimate_model(data = data_analysis_capped,
                     min_age = 3,
                     max_age = 12,
                     start = c(2, 0, 0.5, 0, 0.2),
                     estimate = c(1, 1, 1, 1, 1))

AIC1 = 2 * 5 - 2 * fit1$loglik


# alpha1 = 0
fit2 = Estimate_model(data = data_analysis_capped,
                      min_age = 3,
                      max_age = 12,
                      start = c(2, 0, 0.5, 0, 0.2),
                      estimate = c(1, 1, 1, 0, 1))
AIC2 = 2 * 4 - 2 * fit2$loglik


# alpha1 = beta1 = 0
fit3 = Estimate_model(data = data_analysis_capped,
                      min_age = 3,
                      max_age = 12,
                      start = c(2, 0, 0, 0, 0.2),
                      estimate = c(1, 0, 1, 0, 1))
AIC3 = 2 * 3 - 2 * fit3$loglik


# alpha0 = alpha1 = 0
fit4 = Estimate_model(data = data_analysis_capped,
                  min_age = 3,
                  max_age = 12,
                  start = c(2, 0, 0, 0, 0.2),
                  estimate = c(1, 1, 0, 0, 1))
AIC4 = 2 * 3 - 2 * fit4$loglik


AICs = c(AIC1, AIC2, AIC3, AIC4) # fit4 best model

fitted_pars = fit4$estimate
all_pars = c(fitted_pars[1:2, "Estimate"], 0, 0, fitted_pars[3, "Estimate"])
best_matrix = Calculate_matrix(all_pars, min_age = 3, max_age = 12)


### Fitting with lowest mode ###

fit1_l = Estimate_model(data = data_analysis_capped,
                      min_age = 3,
                      max_age = 12,
                      start = c(2, 0, 0.5, 0, 0.2),
                      estimate = c(1, 1, 1, 1, 1),
                      lowmode = TRUE)

AIC1_l = 2 * 5 - 2 * fit1_l$loglik


# alpha1 = 0
fit2_l = Estimate_model(data = data_analysis_capped,
                      min_age = 3,
                      max_age = 12,
                      start = c(2, 0, 0.5, 0, 0.2),
                      estimate = c(1, 1, 1, 0, 1),
                      lowmode = TRUE)
AIC2_l = 2 * 4 - 2 * fit2_l$loglik


# alpha1 = beta1 = 0
fit3_l = Estimate_model(data = data_analysis_capped,
                      min_age = 3,
                      max_age = 12,
                      start = c(2, 0, 0, 0, 0.2),
                      estimate = c(1, 0, 1, 0, 1),
                      lowmode = TRUE)
AIC3_l = 2 * 3 - 2 * fit3_l$loglik


# alpha0 = alpha1 = 0
fit4_l = Estimate_model(data = data_analysis_capped,
                      min_age = 3,
                      max_age = 12,
                      start = c(2, 0, 0, 0, 0.2),
                      estimate = c(1, 1, 0, 0, 1),
                      lowmode = TRUE)
AIC4_l = 2 * 3 - 2 * fit4_l$loglik


AICs_l = c(AIC1_l, AIC2_l, AIC3_l, AIC4_l) # fit2 best model

fitted_pars_l = fit2_l$estimate
all_pars_l = c(fitted_pars_l[1:3, "Estimate"], 0, fitted_pars_l[4, "Estimate"])
best_matrix_l = Calculate_matrix(all_pars_l, min_age = 3, max_age = 12)


### Simulation experiment assessing effect of modal age = true age ###
# Symmetric truth assumed in simulations
fitted_matrix_symmetric = best_matrix



## Simulation study, symmetric truth, fitting asymmetric model ##



### LOWEST MODAL AGE ###

fish_id = unique(data_analysis_capped$FishID)

B = 1000
mean_diff = c()
pars = c()
fitted_matrix_boot = matrix(0, nrow = max_age-min_age + 1, ncol = max_age-min_age+1)
min_age = 3
max_age = 12
for (b in 1:B){
    print(b)
    true_ages = c()
    ages = c()
    df = data.frame()
    for (i in 1:length(fish_id)){
        subdata = data_analysis_capped[data_analysis_capped$FishID==fish_id[i], ]
        true_age = subdata$modal_age_low[1]
        ind = which(rownames(fitted_matrix_symmetric) == true_age)
        age_s = sample(colnames(fitted_matrix_symmetric), prob = fitted_matrix_symmetric[ind, ], size = dim(subdata)[1], replace = TRUE)
        true_ages = c(true_ages, true_age)
        age = min(as.numeric(names(table(age_s))[table(age_s)==max(table(age_s))]))
        ages = c(ages, age)
        df_sub = data.frame(true_age = age, age = age_s)
        df = rbind(df, df_sub)
    }
    mean_diff = c(mean_diff, mean(as.numeric(ages) != true_ages))
    true_age = as.numeric(df$true_age)
    df$age = as.numeric(df$age)
    df$weight = 1
    weight = as.numeric(df$weight)
    df$modal_age_low = true_age
    fit = Estimate_model(data = df, min_age = 3, max_age = 12, start = c(2, 0, 0, 0, 0.2), estimate = c(1, 1, 1, 0, 1), lowmode = TRUE)
    pars = c(fit$estimate[1:3, "Estimate"], 0, fit$estimate[4, "Estimate"])
    fitted_matrix_boot = fitted_matrix_boot + Calculate_matrix(pars, min_age = min_age, max_age = max_age)
}

fitted_matrix_boot = fitted_matrix_boot[rowSums(fitted_matrix_boot) != 0, rowSums(fitted_matrix_boot) != 0] / B
rownames(fitted_matrix_boot) = min_age:max_age
colnames(fitted_matrix_boot) = min_age:max_age

difference = fitted_matrix_boot - fitted_matrix_symmetric


### MODAL AGE CLOSEST TO MEAN ###

mean_diff = c()
pars = c()
fitted_matrix_boot = matrix(0, nrow = max_age-min_age + 1, ncol = max_age-min_age+1)
for (b in 1:B){
    print(b)
    true_ages = c()
    ages = c()
    df = data.frame()
    for (i in 1:length(fish_id)){
        subdata = data_analysis_capped[data_analysis_capped$FishID==fish_id[i], ]
        true_age = subdata$modal_age_low[1]
        ind = which(rownames(fitted_matrix_symmetric) == true_age)
        age_s = sample(colnames(fitted_matrix_symmetric), prob = fitted_matrix_symmetric[ind, ], size = dim(subdata)[1], replace = TRUE)
        true_ages = c(true_ages, true_age)
        tbl = table(age_s)
        ages_names = names(tbl)
        mod = ages_names[which(tbl == max(tbl))]
        n = length(mod)
        if(n>1){
            mean_age = mean(as.numeric(age_s))
            dist = abs(as.numeric(mod) - mean_age)
            min_dist = mod[which(dist == min(dist))]
            age = min_dist
            weight = 1/length(min_dist)
            for(j in age){
                df_sub = data.frame(true_age = j, age = age_s, weight = weight)
                df = rbind(df, df_sub)
            }
        }
        else{
            age = as.numeric(mod)
            weight = 1
            df_sub = data.frame(true_age = age, age = age_s, weight = weight)
            df = rbind(df, df_sub)
        }
    }
    mean_diff = c(mean_diff, mean(as.numeric(ages) != true_ages))
    true_age = as.numeric(df$true_age)
    df$age = as.numeric(df$age)
    df$modal_age_closest = true_age
    fit = Estimate_model(data = df, min_age = 3, max_age = 12, start = c(2, 0, 0, 0, 0.2), estimate = c(1, 1, 1, 0, 1), lowmode = FALSE)
    pars = c(fit$estimate[1:3, "Estimate"], 0, fit$estimate[4, "Estimate"])
    fitted_matrix_boot = fitted_matrix_boot + Calculate_matrix(pars, min_age = min_age, max_age = max_age)
}


fitted_matrix_boot = fitted_matrix_boot[rowSums(fitted_matrix_boot) != 0, rowSums(fitted_matrix_boot) != 0] / B
rownames(fitted_matrix_boot) = min_age:max_age
colnames(fitted_matrix_boot) = min_age:max_age

difference = fitted_matrix_boot - fitted_matrix_symmetric

print(xtable(round(difference, 5), digits = 3), type = "latex", file = "M_difference_symmetric_truth_modalmean.tex")

