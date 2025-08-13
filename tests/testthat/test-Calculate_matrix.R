test_that("Calculate matrix returns a matrix", {
    params = c(4.504, -0.31287, 0, 0, 0.2103217)
    mat = Calculate_matrix(params, 3, 12)
    expect_true(is.matrix(mat))
})

test_that("Calculate matrix returns a matrix of correct dimension", {
    params = c(4.504, -0.31287, 0, 0, 0.2103217)
    mat = Calculate_matrix(params, 3, 12)
    expect_equal(dim(mat), c(10, 10))
})
