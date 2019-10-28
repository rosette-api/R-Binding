source("../R/Api.R")
library(jsonlite)
library(optparse)

option_list <- list(
  make_option(c("-k", "--key"),
    action = "store", default = NA, type = "character",
    help = "Rosette API key"),
  make_option(c("-u", "--url"),
    action = "store", default = NA, type = "character",
    help = "Rosette API url"))
opt_parser <- OptionParser(option_list = option_list)
opt <- parse_args(opt_parser)

name_dedupe_data <- "Alice Terry,Alice Thierry,Betty Grable,Betty Gable,Norma Shearer,Norm Shearer,Brigitte Helm,Bridget Helem,Judy Holliday,Julie Halliday"


text <- unlist(strsplit(name_dedupe_data, ","))
target_language <- rep("eng", length(text))
target_script <- rep("Latn", length(text))

names <- data.frame(text, target_language, target_script)
parameters <- list()
parameters[["names"]] <- names
parameters[["threshold"]] <- 0.75

if (is.na(opt$url)) {
   result <- api(opt$key, "name-deduplication", parameters)
} else {
   result <- api(opt$key, "name-deduplication", parameters, NULL, NULL, opt$url)
}
print(jsonlite::toJSON(result$header, pretty = TRUE))
print(jsonlite::toJSON(result$content, pretty = TRUE))
