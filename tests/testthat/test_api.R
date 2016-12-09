#R binding unit tests

# mock all HTTP httr::GET requests
test_that("httr::GET function mocks correctly", {
  with_mock(
    `httr::GET` = function(x, y) "mocked response",
    expect_equal(get_endpoint("fakekey", "endpoint", "https://api.rosette.com/rest/v1/"), "mocked response")
  )
})

# mock all HTTP httr::POST requests
test_that("httr::POST functions mock correctly", {
  parameters <- jsonlite::toJSON(list())
  with_mock(
    `httr::POST` = function(x, y, ...) "mocked response",
    expect_equal(post_endpoint("fakekey", parameters, "endpoint", "https://api.rosette.com/rest/v1/"), "mocked response")
  )
})

test_that("The function detects a multipart", {
  parameters <- list()
  parameters[[ "content" ]] <- "Rosette Api"
  parameters[[ "documentFile" ]] <- "true"
  expect_equal(check_for_multipart(parameters), TRUE)
})

test_that("The function creates a multipart", {
  parameters <- list()
  parameters[[ "content" ]] <- "Rosette Api"
  parameters[[ "documentFile" ]] <- "true"
  expect_equal(create_multipart(parameters), "--89dszpjalrbmlsor\r\nContent-Type: application/json\r\nContent-Disposition: mixed; name=\"request\"\r\n\r\n{}\r\n\r\n--89dszpjalrbmlsor\r\nContent-Type: text/plain\r\nContent-Disposition: mixed; name=\"content\";\r\n\r\nRosette Api\r\n--89dszpjalrbmlsor--")
})

test_that("Check error does not return an error", {
  response <- list()
  response[["content"]] <- "Rosette Api"
  expect_equal(error_check(response), response)
})

# mock 409 error return
test_that("409 error is handled correctly", {
  value <- "{ \"code\": \"incompatibleClientVersion\" }"
  expect_equal(error_check(value), value)
})

test_that("The parameters fulfill the name-translation requirements", {
  parameters <- list()
  parameters[[ "name" ]] <- "fake name"
  parameters[[ "targetLanguage" ]] <- "eng"
  expect_equal(check_names(parameters, "name-translation"), parameters)
})

test_that("The parameters fulfill the name-similarity requirements", {
  parameters <- list()
  parameters[[ "name1" ]] <- "first name"
  parameters[[ "name2" ]] <- "second name"
  expect_equal(check_names(parameters, "name-similarity"), parameters)
})

test_that("A morphology endpoint is present", {
  parameters <- list()
  parameters[[ "content" ]] <- "Rosette Api"
  parameters[[ "morphology" ]] <- "complete"
  expect_equal(check_morphology(parameters), "morphology/complete")
})

test_that("The parameters object is valid", {
  parameters <- list()
  parameters[[ "content" ]] <- "Rosette Api"
  expect_equal(check_content_parameters(parameters), parameters)
})

