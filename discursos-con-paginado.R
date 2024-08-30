# vamos a "scrapear" (recuperar) contenido del sitio web de Casa Rosada

# este ejemplo no considerado el paginado. solo toma las ultimas noticias de https://www.casarosada.gob.ar/informacion/discursos

# si es la primera vez que corren codigo R seguro tengan que instalar librerias
# install.packages(c("tidyverse","foreach","rvest","xml2"))

# cargo las librerias
library(tidyverse)
library(rvest)
library(httr)



url_base <- "https://www.casarosada.gob.ar/informacion/discursos?start="
url_base2 <- "https://www.casarosada.gob.ar/informacion/discursos"

paginado <- seq(from=0, to=1360, by=40)

paginado

discursos_links <- list()

for (i in 1:length(paginado[1:3]) ) {
  pagina_con_links <- paste0(url_base, paginado[i])
  message(pagina_con_links)
  discursos_links[[i]] <- read_html(pagina_con_links) %>%
    # html_nodes("a[href^='/informacion/discursos']") %>%
    html_nodes("a[href^='/informacion/discursos'].panel") %>%
    html_attr("href")
}

discursos_links <- unlist(discursos_links)




read_html(paste0(url_base2, discursos_links[1])) %>%
  html_nodes(".col-md-8.col-md-offset-2 > p") %>%
  html_text() %>%
  paste(., collapse = "")





pagina_con_links <- paste0(url_base,paginado[1])

discursos_links <- read_html(pagina_con_links) %>%
  # html_nodes("a[href^='/informacion/discursos']") %>%
  html_nodes("a[href^='/informacion/discursos'].panel") %>%
  html_attr("href")

read_html(paste0(url_base2, discursos_links[1])) %>%
  html_nodes(".col-md-8.col-md-offset-2 > p") %>%
  html_text() %>%
  paste(., collapse = "")
