source("../R/Api.R")
library(jsonlite)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

topics_data <- "Lily Collins is in talks to join Nicholas Hoult in Chernin Entertainment and Fox Searchlight's J.R.R. Tolkien biopic Tolkien. Anthony Boyle, known for playing Scorpius Malfoy in the British play Harry Potter and the Cursed Child, also has signed on for the film centered on the famed author. In Tolkien, Hoult will play the author of the Hobbit and Lord of the Rings book series that were later adapted into two Hollywood trilogies from Peter Jackson. Dome Karukoski is directing the project."

parameters <- list()
parameters[[ "content" ]] <- topics_data

if (is.na(opt$url)){
   result <- api(opt$key, "topics", parameters)
} else {
   result <- api(opt$key, "topics", parameters, NULL, NULL, opt$url)
}
print(jsonlite::toJSON(result$header, pretty = TRUE))
print(jsonlite::toJSON(result$content, pretty = TRUE))