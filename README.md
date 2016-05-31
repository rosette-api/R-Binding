[![Build Status](https://travis-ci.org/rosette-api/R.svg?branch=master)](https://travis-ci.org/rosette-api/nodejs)

# rosette-api

This is the Rosette API client binding for R.

## Getting Started
Install the module with: `install.packages('rosetteAPI')`

OR

Ensure you're in the `current release` folder and run the command `R CMD INSTALL rosetteApi_1.0.1.tar.gz`


## Example using the Rosette API language detection endpoint
```R
library(rosetteApi)
library(rjson)

key <- "contentUri"
value <- "http://www.onlocationvacations.com/2015/03/05/the-new-ghostbusters-movie-begins-filming-in-boston-in-june/"

parameters <- list()
parameters[[ key ]] <- value
parameters <- toJSON(parameters)

result <- api("0123456789", "categories", parameters)
print(result)
```
## API Parameters
| Parameter                     | Endpoint                                            | Required
| -------------                 |-------------                                        |------------- 
| content                    | categories, entities, language, morphology, relationships, sentences, sentiment, tokens            | Either content or contentUri required |
| contentUri                      | categories, entities, language, morphology, relationships, sentences, sentiment, tokens       | Either content or contentUri required |
| language                          | categories, entities, language, morphology, relationships, sentences, sentiment, tokens, name similarity                    | No |
| documentFile                      | categories, entities, language, morphology, relationships, sentences, sentiment, tokens                  | No |
| name1                 | name similarity               | Yes |
| name2               | name similarity| Yes |
| name    | name translation     | Yes |
| targetLanguage           | name translation           | Yes |
| entityType                 | name translation         | No |
| sourceLanguageOfOrigin        | name translation | No |
| sourceLanguageOfUse                         | name translation       | No |
| sourceScript                     | name translation               | No |
| targetScript                     | name translation                    | No |
| targetScheme                        | name translation          | No |
| options              | relationships        | No |
| accuracyMode              | relationships        | Yes |
| linked              | entities        | No |
| explain              | sentiment        | No |
| morphology             | morphology        | Yes |

## Additional Information
See [Rosette API site](https://developer.rosette.com/)