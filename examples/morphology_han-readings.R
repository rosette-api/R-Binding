source("../R/Api.R")
library(jsonlite)
library("optparse")

option_list = list( make_option(c("-k", "--key"), action="store", default=NA, type='character',
              help="Rosette API key"), make_option(c("-u", "--url"), action="store", default=NA, type='character',
              help="Rosette API url"))
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

morphology_han_readings_data <- "北京大学生物系主任办公室内部会议"

parameters <- list()
parameters[[ "content" ]] <- morphology_han_readings_data
parameters[[ "morphology" ]] <- "han-readings"

if (is.na(opt$url)){
   result <- api(opt$key, "morphology", parameters)
} else {
   result <- api(opt$key, "morphology", parameters, NULL, NULL, opt$url)
}
print(jsonlite::toJSON(result$header, pretty = TRUE))
print(jsonlite::toJSON(result$content, pretty = TRUE))