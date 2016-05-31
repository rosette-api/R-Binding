source("../R/Api.R")
library(rjson)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

sentiment_file_data <- "<html><head><title>New Ghostbusters Film</title></head><body><p>Original Ghostbuster Dan Aykroyd, who also co-wrote the 1984 Ghostbusters film, couldn’t be more pleased with the new all-female Ghostbusters cast, telling The Hollywood Reporter, “The Aykroyd family is delighted by this inheritance of the Ghostbusters torch by these most magnificent women in comedy.”</p></body></html>"

key <- "content"
value <- sentiment_file_data
key1 <- "documentFile"
value2 <- "true"

parameters <- list()
parameters[[ key ]] <- value
parameters[[ key1 ]] <- value2
parameters <- toJSON(parameters)

if(is.na(opt$url)){
   result <- api(opt$key, "sentiment", parameters)
} else {
   result <- api(opt$key, "sentiment", parameters, opt$url)
}
print(result)
