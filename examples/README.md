## Endpoint Examples

Each example file demonstrates one of the capabilities of the Rosette Platform.

## Example using the Rosette API language detection endpoint
```R
library(rosetteApi)
library(jsonlite)

parameters <- list()
parameters[[ "contentUri" ]] <- "https://onlocationvacations.com/2015/03/05/the-new-ghostbusters-movie-begins-filming-in-boston-in-june/"

result <- api("0123456789", "categories", parameters)
# result is a list containing content and headers in native R.  Use jsonlite::toJSON to convert to JSON format.
print(jsonlite::toJSON(result$content, pretty = TRUE)
```