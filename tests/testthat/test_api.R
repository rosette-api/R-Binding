#R binding unit tests

# mock all HTTP GET requests
test_that("GET function mocks correctly", {
with_mock(
  GET = function(x, y) "mocked response",
  expect_equal(get_endpoint("fakekey", "endpoint", NULL, "https://api.rosette.com/rest/v1/"), "mocked response")
)})

# mock all HTTP POST requests
test_that("POST functions mock correctly", {
with_mock(
  POST = function(x, y, ...) "mocked response",
  expect_equal(post_endpoint("fakekey", "parameter data", "endpoint", NULL, "https://api.rosette.com/rest/v1/"), "mocked response")
)})

test_that("The function detects a multipart", {
  key <- "content"
  value <- "Rosette Api"
  key1 <- "documentFile"
  value2 <- "true"
  
  parameters <- list()
  parameters[[ key ]] <- value
  parameters[[ key1 ]] <- value2
  parameters <- toJSON(parameters)
  with_mock(
  POST = function(x, y, ...) "mocked response",
  expect_equal(check_for_multipart("fake key", parameters, "endpoint", "https://api.rosette.com/rest/v1/"), "mocked response")
)})

test_that("The function creates a multipart", {
  key <- "content"
  value <- "Rosette Api"
  key1 <- "documentFile"
  value2 <- "true"
  
  parameters <- list()
  parameters[[ key ]] <- value
  parameters[[ key1 ]] <- value2
  parameters <- toJSON(parameters)
  expect_equal(create_multipart(parameters), "--89dszpjalrbmlsor\r\nContent-Type: application/json\r\nContent-Disposition: mixed; name=\"request\"\r\n\r\n{}\r\n\r\n--89dszpjalrbmlsor\r\nContent-Type: text/plain\r\nContent-Disposition: mixed; name=\"content\";\r\n\r\nRosette Api\r\n--89dszpjalrbmlsor--")
})

test_that("Check error does not return an error", {
  response <- list()
  content <- "content"
  value <- "Rosette Api"
  response[[content]] <- value
  with_mock(
    content = function(x) "Rosette Api",
    expect_equal(error_check(response), response)
  )
})

# mock 409 error return
test_that("409 error is handled correctly", {
  value <- "{ \"code\": \"incompatibleClientVersion\" }"
  with_mock(
    content = function(x) value,
    expect_equal(error_check(value), value)
  )
})

test_that("The response content and headers are converted to json and stored in a vector", {
  response <- list()
  content <- "content"
  value <- "Rosette Api"
  response[[content]] <- value
  resultVector = vector()
  resultVector[1] = "\"Rosette Api\""
  resultVector[2] = "\"Headers\""
  with_mock(
    content = function(x) "Rosette Api",
    headers = function(x) "Headers",
    expect_equal(to_json(response), resultVector)
  )
})

test_that("The parameters fulfill the name-translation requirements", {
  key <- "name"
  value <- "fake name"
  key1 <- "targetLanguage"
  value1 <- "eng"
  
  parameters <- list()
  parameters[[ key ]] <- value
  parameters[[ key1 ]] <- value1
  parameters <- toJSON(parameters)
  expect_equal(check_names(parameters, "name-translation"), parameters)
})

test_that("The parameters fulfill the name-similarity requirements", {
  key <- "name1"
  value <- "first name"
  key1 <- "name2"
  value1 <- "second name"
  
  parameters <- list()
  parameters[[ key ]] <- value
  parameters[[ key1 ]] <- value1
  parameters <- toJSON(parameters)
  expect_equal(check_names(parameters, "name-similarity"), parameters)
})

test_that("A morphology endpoint is present", {
  key <- "content"
  value <- "Rosette Api"
  key1 <- "morphology"
  value1 <- "complete"
  
  parameters <- list()
  parameters[[ key ]] <- value
  parameters[[ key1 ]] <- value1
  parameters <- toJSON(parameters)
  expect_equal(check_morphology(parameters), "morphology/complete")
})

test_that("The parameters object is valid", {
  key <- "content"
  value <- "Rosette Api"
  
  parameters <- list()
  parameters[[ key ]] <- value
  parameters <- toJSON(parameters)
  expect_equal(check_content_parameters(parameters), parameters)
})

test_that("A call is made to the specified Rosette Api endpoint", {
  resultVector = vector()
  resultVector[1] = "\"Rosette Api\""
  resultVector[2] = "\"Headers\""
  with_mock(
    GET = function(x, y) "Rosette Api",
    content = function(x) "Rosette Api", 
    headers = function(x) "Headers",
    expect_equal(api("fakekey", "ping"), resultVector)
  )
})
