
###- This code is used for displaying features in the SWECO25 github page

library(magrittr)
library(rvest)

# Function to scrape download count from Zenodo webpage
scrapeDownloadCount <- function(url) {
  page <- rvest::read_html(url)
  download_count <- rvest::html_nodes(page, "tr td:nth-child(2)") %>% rvest::html_text() %>% as.integer()
  return(download_count)
}

# list of zenodo urls from SWECO25 database

sweco25<- data.frame(
  name = c("vege", "pop", "bioclim", "edaph", "geol", "hydro", "lulc", "topo", "trans", "rs"),
  url = c(
    "https://zenodo.org/record/7973922",
    "https://zenodo.org/record/7981095",
    "https://zenodo.org/record/7978760",
    "https://zenodo.org/record/7981143",
    "https://zenodo.org/record/7981134",
    "https://zenodo.org/record/7981127",
    "https://zenodo.org/record/7981110",
    "https://zenodo.org/record/7973960",
    "https://zenodo.org/record/7981069",
    "https://zenodo.org/record/7994481"
  )
)

sweco25$downloads<-NA
sweco25$views<-NA

for(i in 1:nrow(sweco25)){

# Specify the Zenodo webpage URL

zenodo_url<-sweco25$url[i]

# Scrape the download count
download_count <- scrapeDownloadCount(zenodo_url)

download_count<-download_count[-which(is.na(download_count))]

sweco25$downloads[i]<-download_count[2]
sweco25$views[i]<-download_count[1]


}

sw<-rbind(sweco25,c("total","na",sum(sweco25$downloads),sum(sweco25$views)))

totalDW<-sum(sweco25$downloads)
totalView<-sum(sweco25$views)

# Save the download count to a file
writeLines(as.character(totalDW), "data/display_data/download_count.txt")
writeLines(as.character(totalView), "data/display_data/view_count.txt")
