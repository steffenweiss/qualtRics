test_that("read_survey() reads data in qualtrics standard and legacy format and converts columns", { # nolint

  # Test if can read standard format
  survey <- suppressWarnings(qualtRics::read_survey("files/sample.csv"))
  # Tests
  expect_equal(dim(survey)[1], 1)
  expect_equal(dim(survey)[2], 20)
  expect_true(is.numeric(as.numeric(survey$StartDate)))
  expect_true(is.numeric(survey$LocationLatitude))

  # Test if can read legacy format
  survey_legacy <- suppressWarnings(
    qualtRics::read_survey("files/sample_legacy.csv", # nolint
                           legacy = TRUE)
  )
  # Tests
  expect_equal(dim(survey_legacy)[1], 1)
  expect_equal(dim(survey_legacy)[2], 15)
  expect_true(is.numeric(as.numeric(survey_legacy$V8))) # StartDate
  expect_true(is.numeric(survey_legacy$LocationLatitude))

  # Test if it respects col_types argument
  survey <- suppressWarnings(
    qualtRics::read_survey("files/sample.csv",
                           col_types = readr::cols(StartDate = readr::col_character()))
  )
  #Tests
  expect_equal(dim(survey)[1], 1) #Ensure no change in dims
  expect_equal(dim(survey)[2], 20) #Ensure no change in dims
  expect_true(is.character(survey$StartDate))


  # Test if legacy version respects col_types argument
  survey_legacy <- suppressWarnings(qualtRics::read_survey(
    "files/sample_legacy.csv", # nolint
    legacy = TRUE,
    col_types = readr::cols(StartDate = readr::col_character()
    )
  ))
  # Tests
  expect_equal(dim(survey)[1], 1) #Ensure no change in dims
  expect_equal(dim(survey)[2], 20) #Ensure no change in dims
  expect_true(is.character(survey$StartDate))


})

test_that("Survey exists to read from disk", {
  expect_error(
    qualtRics::read_survey("/users/julia/desktop/error.csv"),
    "does not exist"
  )
})
