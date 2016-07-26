# Rosette API R binding
# Author: Sam Hausmann

library(httr)
library(rjson)

#' api wrapper function that checks for a user_key and determines the Rosette API endpoint to be utilized
#' @param user_key - Rosette API authentication key
#' @param endpoint - Rosette API endpoint to be utilized
#' @param parameters - parameters list to be passed to specified Rosette API endpoint
#' @param customHeaders - custom headers for Rosette Api
#' @param url - url for Rosette Api
#' @return Returns json of the specified Rosette API endpoint response
#' @examples
#' \dontrun{
#' key <- "content"
#' value <- "Bill Murray will appear in new Ghostbusters film."
#' parameters <- list()
#' parameters[[ key ]] <- value
#' parameters <- toJSON(parameters)
#' api(01234567890, "entities", parameters)
#' }
#' @export
api <- function(user_key, endpoint, parameters=FALSE, customHeaders=NULL, url="https://api.rosette.com/rest/v1/") {
  if(is.null(user_key)) {
    stop("API key param empty")
  } else {

    if(endpoint == "info") {
      return(to_json(get_endpoint(user_key, "info", customHeaders, url)))
    } else if (endpoint == "ping") {
      return(to_json(get_endpoint(user_key, "ping", customHeaders, url)))
    } else if (endpoint == "language") {
      return(to_json(error_check(check_for_multipart(user_key, check_content_parameters(parameters), "language", customHeaders, url))))
    } else if (endpoint == "categories") {
      return(to_json(error_check(check_for_multipart(user_key, check_content_parameters(parameters), "categories", customHeaders, url))))
    } else if (endpoint == "entities") {
      return(to_json(error_check(check_for_multipart(user_key, check_content_parameters(parameters), "entities", customHeaders, url))))
    } else if (endpoint == "name-translation") {
      return(to_json(error_check(check_for_multipart(user_key, check_names(parameters, "name-translation"), "name-translation", customHeaders, url))))
    } else if (endpoint == "name-similarity") {
      return(to_json(error_check(check_for_multipart(user_key, check_names(parameters, "name-similarity"), "name-similarity", customHeaders, url))))
    } else if (endpoint  == "relationships") {
      return(to_json(error_check(check_for_multipart(user_key, check_content_parameters(parameters), "relationships", customHeaders, url))))
    } else if (endpoint == "tokens") {
      return(to_json(error_check(check_for_multipart(user_key, check_content_parameters(parameters), "tokens", customHeaders, url))))
    } else if (endpoint == "morphology") {
      return(to_json(error_check(check_for_multipart(user_key, check_content_parameters(parameters), check_morphology(parameters, "morphology"), customHeaders, url))))
    } else if (endpoint == "sentiment") {
      return(to_json(error_check(check_for_multipart(user_key, check_content_parameters(parameters), "sentiment", customHeaders, url))))
    } else if (endpoint == "sentences") {
      return(to_json(error_check(check_for_multipart(user_key, check_content_parameters(parameters), "sentences", customHeaders, url))))
    } else  if (endpoint == "entities/linked"){
      return(to_json(error_check(check_for_multipart(user_key, check_content_parameters(parameters), "entities/linked", customHeaders, url))))
    } else {
      stop("Specify a valid Rosette API endpoint")
    }

  }

}

#' preemptive check for content/contentUri request parameter errors
#' @param parameters - parameters list to be passed to specified Rosette API endpoint
#' @return Returns list of verified parameters to be sent to Rosette API
check_content_parameters <- function(parameters) {
  if("content" %in% names(fromJSON(parameters))  && "contentUri" %in% names(fromJSON(parameters))){
    stop("Cannot specify both content and contentUri parameters")
  } else if(!("content" %in% names(fromJSON(parameters)))  && !("contentUri" %in% names(fromJSON(parameters)))) {
    stop("Must specify either content or contentUri parameters")
  } else {
    return(parameters)
  }
}

#' determine which morphology endpoint to use
#' @param parameters - parameters list to be passed to specified Rosette API endpoint
#' @param endpoint - Rosette API endpoint to be utilized
#' @return Returns the specified morphology function
check_morphology <- function(parameters, endpoint) {
  if("morphology" %in% names(fromJSON(parameters))) {
    endpoint <- paste("morphology/", fromJSON(parameters)["morphology"], sep="")
    return(endpoint)
  } else {
    return(endpoint)
  }
}

#' check if the required request parameters for either names endpoint are correct
#' @param parameters - parameters list to be passed to specified Rosette API endpoint
#' @param endpoint - Rosette API endpoint to be utilized
#' @return Returns list of verified parameters to be sent to Rosette API
check_names <- function(parameters, endpoint) {
  if(endpoint == "name-translation") {
    if(!("name" %in% names(fromJSON(parameters))) || !("targetLanguage" %in% names(fromJSON(parameters)))) {
      stop("Must supply name and targetLanguage parameters for name-translation endpoint")
    } else {
      return(parameters)
    }
  } else if(endpoint == "name-similarity") {
    if(!("name1" %in% names(fromJSON(parameters))) || !("name2" %in% names(fromJSON(parameters)))) {
      stop("Must supply both name1 and name2 parameters for name-similarity endpoint")
    } else {
      return(parameters)
    }
  }
}

#' check if the request parameters contain multipart
#' @param user_key - Rosette API authentication key
#' @param endpoint - Rosette API endpoint to be utilized
#' @param parameters - parameters list to be passed to specified Rosette API endpoint
#' @param customHeaders - custom headers for Rosette Api
#' @param url - url for Rosette Api
#' @return Returns json of the specified Rosette API endpoint response from either a multipart or non-multipart request
check_for_multipart <- function(user_key, parameters, endpoint, customHeaders, url) {
  if("documentFile" %in% names(fromJSON(parameters))) {
    create_multipart(parameters)
    return(mutipart_call(user_key, create_multipart(parameters), endpoint, customHeaders, url))
  } else {
    return(post_endpoint(user_key, parameters, endpoint, customHeaders, url))
  }
}

#' create a multipart
#' @param parameters - parameters list to be passed to specified Rosette API endpoint
#' @return Returns a multipart
create_multipart <- function(parameters) {
  content <- fromJSON(parameters)['content']
  parameters <- fromJSON(parameters)
  parameters['content'] <- NULL
  parameters <- serialize_parameters(toJSON(parameters))

  boundary <- "--89dszpjalrbmlsor"
  crlf <- "\r\n"
  multi <- paste(boundary, crlf, sep='')
  multi <- paste(multi, 'Content-Type: application/json', sep='')
  multi <- paste(multi, crlf, sep='')
  multi <- paste(multi, 'Content-Disposition: mixed; name="request"', sep='')
  multi <- paste(multi, crlf, sep='')
  multi <- paste(multi, crlf, sep='')
  if(length(fromJSON(parameters)) != 0){
    multi <- paste(multi, parameters, sep='')
  } else {
    multi <- paste(multi, "{}", sep='')
  }
  multi <- paste(multi, crlf, sep='')
  multi <- paste(multi, crlf, sep='')
  multi <- paste(multi, boundary, sep='')
  multi <- paste(multi, crlf, sep='')
  multi <- paste(multi, 'Content-Type: text/plain', sep='')
  multi <- paste(multi, crlf, sep='')
  multi <- paste(multi, 'Content-Disposition: mixed; name="content";', sep='')
  multi <- paste(multi, crlf, sep='')
  multi <- paste(multi, crlf, sep='')
  multi <- paste(multi, content, sep='')
  multi <- paste(multi, crlf, sep='')
  multi <- paste(multi, boundary, sep='')
  multi <- paste(multi, "--", sep='')
  return(multi)
}

#' make a multipart POST request
#' @param user_key - Rosette API authentication key
#' @param endpoint - Rosette API endpoint to be utilized
#' @param parameters - parameters list to be passed to specified Rosette API endpoint
#' @param customHeaders - custom headers for Rosette Api
#' @param url - url for Rosette Api
#' @return Returns the response from the Rosette API
mutipart_call <- function(user_key, parameters, endpoint, customHeaders,url) {
  BINDING_VERSION <- "1.1.0"
  if(is.null(customHeaders)) {
    response <- POST(paste(url, endpoint, sep=""), encode = "multipart", add_headers("X-RosetteAPI-Key" = user_key, "Content-Type" = "multipart/mixed", "X-RosetteAPI-Binding" = "R", "X-RosetteAPI-Binding-Version" = BINDING_VERSION, "user-agent" = "ruseragent"), body = parameters)
    } else {
        defaultHeaders <- c("X-RosetteAPI-Key" = user_key, "Content-Type" = "multipart/mixed", "X-RosetteAPI-Binding" = "R", "X-RosetteAPI-Binding-Version" = BINDING_VERSION, "user-agent" = "ruseragent")
        .headers <- c(defaultHeaders, customHeaders)
        response <- POST(paste(url, endpoint, sep=""), encode = "multipart", add_headers(.headers), body = parameters)
    }
  return(response)
}

#' convert Rosette API response content and headers to json
#' @param response - response from Rosette API
#' @return Returns a vector containing json of Rosette API response and response headers
to_json <- function(response) {
  resultVector = vector()
  json <- toJSON(content(response))
  headers <- toJSON(headers(response))
  resultVector[1] <- json
  resultVector[2] <- headers
  return(resultVector)
}

#' check if Rosette API response includes and error message
#' @param response - response from Rosette API
#' @return Returns an error if one exists or the Rosette API response
error_check <- function(response) {
  if("message" %in% names(content(response))) {
    stop(content(response)["message"])
  } else {
    return(response)
  }
}

#' serialize Rosette API parameters
#' @param parameters - parameters list to be passed to specified Rosette API endpoint
#' @return Returns the serialized parameters for the Rosette API
serialize_parameters <- function(parameters) {
  serialized_params <- list()
  for(param in names(fromJSON(parameters))) {
    if(param == "genre" || param == "profileId" || param == "language" || param == "content" || param == "options" || param == "contentUri" || param == "contentType") {
    serialized_params[[param]] <- fromJSON(parameters)[[param]]
    }
  }
  return(toJSON(serialized_params))
}

#' serialize Rosette API parameters
#' @param parameters - parameters list to be passed to either name-translation or name-similarity
#' @return Returns the serialized parameters for the Rosette API
serialize_name_parameters <- function(parameters) {
  serialized_params <- list()
  for(param in names(fromJSON(parameters))) {
    if(param == "name" || param == "targetLanguage" || param == "targetScript" || param == "entityType" || param == "sourceScript" || param == "sourceLanguageOfOrigin" || param == "sourceLanguageOfUse" || param == "targetScheme" || param == "name1" || param == "name2") {
    serialized_params[[param]] <- fromJSON(parameters)[[param]]
    }
  }
  return(toJSON(serialized_params))
}

#' POST request to specified Rosette API endpoint
#' @param user_key - Rosette API authentication key
#' @param endpoint - Rosette API endpoint to be utilized
#' @param parameters - parameters list to be passed to specified Rosette API endpoint
#' @param customHeaders - custom headers for Rosette Api
#' @param url - url for Rosette Api
#' @return Returns the response from the Rosette API
post_endpoint <- function(user_key, parameters, endpoint, customHeaders, url) {
  BINDING_VERSION <- "1.1.0"
  if(is.null(customHeaders)) {
      if(endpoint == "name-translation" || endpoint == "name-similarity"){
        response <- POST(paste(url, endpoint, sep=""), add_headers("X-RosetteAPI-Key" = user_key, "Content-Type" = "application/json", "X-RosetteAPI-Binding" = "R", "X-RosetteAPI-Binding-Version" = BINDING_VERSION), body = serialize_name_parameters(parameters))
      } else {
        response <- POST(paste(url, endpoint, sep=""), add_headers("X-RosetteAPI-Key" = user_key, "Content-Type" = "application/json", "X-RosetteAPI-Binding" = "R", "X-RosetteAPI-Binding-Version" = BINDING_VERSION), body = serialize_parameters(parameters))
      }
    } else {
      if(grepl("^X-RosetteAPI-", names(customHeaders)) == FALSE){
        stop("Custom headers must start with \"X-\"")
        } else {
          defaultHeaders <- c("X-RosetteAPI-Key" = user_key, "Content-Type" = "application/json", "X-RosetteAPI-Binding" = "R", "X-RosetteAPI-Binding-Version" = BINDING_VERSION, "user-agent" = "ruseragent")
          .headers <- c(defaultHeaders, customHeaders)
          if(endpoint == "name-translation" || endpoint == "name-similarity"){
            response <- POST(paste(url, endpoint, sep=""), add_headers(.headers), body = serialize_name_parameters(parameters))
          } else {
            response <- POST(paste(url, endpoint, sep=""), add_headers(.headers), body = serialize_parameters(parameters))
          }
        }
    }
  return(response)
}

#' GET request to specified Rosette API endpoint
#' @param user_key - Rosette API authentication key
#' @param endpoint - Rosette API endpoint to be utilized
#' @param customHeaders - custom headers for Rosette Api
#' @param url - url for Rosette Api
#' @return Returns the response from the Rosette API
get_endpoint <- function(user_key, endpoint, customHeaders, url) {
  BINDING_VERSION <- "1.1.0"
  if(is.null(customHeaders)) {
    response <- GET(paste(url, endpoint, sep=""), add_headers("X-RosetteAPI-Key" = user_key, "X-RosetteAPI-Binding" = "R", "X-RosetteAPI-Binding-Version" = BINDING_VERSION, "user-agent" = "ruseragent"))
    } else {
      if(grepl("^X-RosetteAPI-", names(customHeaders)) == FALSE){
        stop("Custom headers must start with \"X-\"")
        } else {
          defaultHeaders <- c("X-RosetteAPI-Key" = user_key, "Content-Type" = "application/json", "X-RosetteAPI-Binding" = "R", "X-RosetteAPI-Binding-Version" = BINDING_VERSION, "user-agent" = "ruseragent")
          .headers <- c(defaultHeaders, customHeaders)
          response <- GET(paste(url, endpoint, sep=""), add_headers(.headers))
        }
    }
  return(response)
}
