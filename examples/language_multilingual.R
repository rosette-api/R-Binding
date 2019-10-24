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

language_multilingual_data <- "On Thursday, as protesters gathered in Washington D.C., the United States Federal Communications Commission under Chairman Ajit Pai voted 3-2 to overturn a 2015 decision, commonly called Net Neutrality, that forbade Internet service providers (ISPs) such as Verizon, Comcast, and AT&T from blocking individual websites or charging websites or customers more for faster load times.  Quatre femmes ont été nommées au Conseil de rédaction de la loi du Qatar. Jeudi, le décret royal du Qatar a annoncé que 28 nouveaux membres ont été nommés pour le Conseil de la Choura du pays.  ذكرت مصادر أمنية يونانية، أن 9 موقوفين من منظمة \"د هـ ك ب ج\" الذين كانت قد أوقفتهم الشرطة اليونانية في وقت سابق كانوا يخططون لاغتيال الرئيس التركي رجب طيب أردوغان."

options <- list()
options[["multilingual"]] <- "true"

parameters <- list()
parameters[["content"]] <- language_multilingual_data
parameters[["options"]] <- options
custom_headers <- c("X-RosetteAPI-App" = "r-application-test")

if (is.na(opt$url)) {
  result <- api(opt$key, "language", parameters = parameters, custom_headers = custom_headers)
} else {
  result <- api(opt$key, "language", parameters = parameters, custom_headers = custom_headers, NULL, url = opt$url)
}
print(jsonlite::toJSON(result$header, pretty = TRUE))
print(jsonlite::toJSON(result$content, pretty = TRUE))
