test_that("Estimate model returns the parameter estimates", {
    file_path = system.file("extdata",
                            "NSS_herring_scales.csv",
                             package = "ParametricAEM")
    data_nss_scales = read.csv(file_path, sep = ",")
    data_exp = data_nss_scales[data_nss_scales$expertise == 1, ] # Extract experts
    data_exp = data_exp[data_exp$age > 0, ]
    data_analysis = Compute_modes(data_exp)
    data_analysis_capped = Cap_ages(data_analysis)
    fit = Estimate_model(data = data_analysis_capped,
                         min_age = 3,
                         max_age = 12,
                         start = c(2, 0, 0, 0, 0.2),
                         estimate = c(1, 1, 0, 0, 1))
    expect_equal(dim(fit$estimate), c(3,2))

})

test_that("Estimate model's parameter estimates are numeric", {
    file_path = system.file("extdata",
                            "NSS_herring_scales.csv",
                            package = "ParametricAEM")
    data_nss_scales = read.csv(file_path, sep = ",")
    data_exp = data_nss_scales[data_nss_scales$expertise == 1, ] # Extract experts
    data_exp = data_exp[data_exp$age > 0, ]
    data_analysis = Compute_modes(data_exp)
    data_analysis_capped = Cap_ages(data_analysis)
    fit = Estimate_model(data = data_analysis_capped,
                         min_age = 3,
                         max_age = 12,
                         start = c(2, 0, 0, 0, 0.2),
                         estimate = c(1, 1, 0, 0, 1))
    expect_true(is.numeric(fit$estimate))
})

test_that("Estimate model's Sigma is numeric", {
    file_path = system.file("extdata",
                            "NSS_herring_scales.csv",
                            package = "ParametricAEM")
    data_nss_scales = read.csv(file_path, sep = ",")
    data_exp = data_nss_scales[data_nss_scales$expertise == 1, ] # Extract experts
    data_exp = data_exp[data_exp$age > 0, ]
    data_analysis = Compute_modes(data_exp)
    data_analysis_capped = Cap_ages(data_analysis)
    fit = Estimate_model(data = data_analysis_capped,
                         min_age = 3,
                         max_age = 12,
                         start = c(2, 0, 0, 0, 0.2),
                         estimate = c(1, 1, 0, 0, 1))
    expect_true(is.numeric(fit$Sigma))
})


test_that("Estimate model's Sigma has the correct dimension", {
    file_path = system.file("extdata",
                            "NSS_herring_scales.csv",
                            package = "ParametricAEM")
    data_nss_scales = read.csv(file_path, sep = ",")
    data_exp = data_nss_scales[data_nss_scales$expertise == 1, ] # Extract experts
    data_exp = data_exp[data_exp$age > 0, ]
    data_analysis = Compute_modes(data_exp)
    data_analysis_capped = Cap_ages(data_analysis)
    fit = Estimate_model(data = data_analysis_capped,
                         min_age = 3,
                         max_age = 12,
                         start = c(2, 0, 0, 0, 0.2),
                         estimate = c(1, 1, 0, 0, 1))
    expect_equal(dim(fit$Sigma), c(3, 3))
})


test_that("Estimate model's loglik is numeric", {
    file_path = system.file("extdata",
                            "NSS_herring_scales.csv",
                            package = "ParametricAEM")
    data_nss_scales = read.csv(file_path, sep = ",")
    data_exp = data_nss_scales[data_nss_scales$expertise == 1, ] # Extract experts
    data_exp = data_exp[data_exp$age > 0, ]
    data_analysis = Compute_modes(data_exp)
    data_analysis_capped = Cap_ages(data_analysis)
    fit = Estimate_model(data = data_analysis_capped,
                         min_age = 3,
                         max_age = 12,
                         start = c(2, 0, 0, 0, 0.2),
                         estimate = c(1, 1, 0, 0, 1))
    expect_true(is.numeric(fit$loglik))
})
