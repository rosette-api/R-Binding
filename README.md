[![Build Status](https://travis-ci.org/rosette-api/R-Binding.svg?branch=develop)](https://travis-ci.org/rosette-api/R-Binding) ![](https://img.shields.io/cran/v/rosetteApi.svg?colorB=bright%20green&style=flat)

# rosette-api

This is the Rosette API client binding for R.

## Getting Started
Install the module thru CRAN:
```
install.packages('rosetteAPI')
```

There may be times when the latest version is not yet available on CRAN.  In that case you can install from GitHub:
```
install_github("rosette-api/r-binding")
```

Command line example:

```
$ R -e 'install.packages("devtools")
$ cat > installrosette.R << EOF
> library(devtools)
> install_github("rosette-api/r-binding")
> q()
> EOF
$ R --no-save < installrosettte.R
```

If the version you are using is not [the latest from CRAN](https://cran.r-project.org/package=rosetteApi)
or [GitHub](https://github.com/rosette-api/R-Binding/releases),
you can verify the [**compatibilty with api.rosette.com**](https://developer.rosette.com/features-and-functions?r).
If you have an on-premise version of Rosette API server, please contact support for
binding compatibility with your installation.

To check your installed version:

`> packageVersion("rosetteAPI")`


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
## API Parameters
| Parameter                     | Endpoint                                            | Required
| -------------                 |-------------                                        |-------------
| content                    | categories, entities, language, morphology, relationships, sentences, sentiment, tokens, topics, syntax/dependencies, transliteration (Yes)            | Either content or contentUri required |
| contentUri                      | categories, entities, language, morphology, relationships, sentences, sentiment, tokens, topics, syntax/dependencies       | Either content or contentUri required |
| language                          | categories, entities, language, morphology, relationships, sentences, sentiment, tokens, topics, name similarity                    | No |
| documentFile                      | categories, entities, language, morphology, relationships, sentences, sentiment, tokens, topics | No |
| name1                 | name similarity               | Yes |
| name2               | name similarity| Yes |
| name    | name translation     | Yes |
| targetLanguage           | name translation, transliteration (No)          | Yes |
| entityType                 | name translation         | No |
| sourceLanguageOfOrigin        | name translation | No |
| sourceLanguageOfUse                         | name translation       | No |
| sourceScript                     | name translation, transliteration               | No |
| sourceLanguage | transliteration | Yes |
| targetScript                     | name translation, transliteration                   | No |
| targetScheme                        | name translation          | No |
| options              | relationships        | No |
| accuracyMode              | relationships        | Yes |
| explain              | sentiment        | No |
| morphology             | morphology        | Yes |

## Docker ##
A Docker image for running the examples against the compiled source library is available on Docker Hub.

Command: `docker run -e API_KEY=api-key -v "<binding root directory>:/source" rosetteapi/docker-r`

Additional environment settings:
`-e ALT_URL=<alternative URL>`
`-e FILENAME=<single filename>`

## Documentation
View the latest [documentation](https://cran.r-project.org/package=rosetteApi/rosetteApi.pdf)

## Release Notes
See the [wiki](https://github.com/rosette-api/R-Binding/wiki/Release-Notes)

## Additional Information
See [Rosette API site](https://developer.rosette.com/)
