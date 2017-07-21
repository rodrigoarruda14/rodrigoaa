
# Loading packages

library(rvest)
library(rjson)

# Importação da tabela com códigos fipe

codigos_fipe <- as.data.frame(read_excel("codigos_fipe.xlsx", sheet = 3))

# Declaração das variáveis

   p1 <- "http://fipeapi.appspot.com/api/1/carros/veiculo/"
   p2 <- ".json"
    i <- 1
    l <- 1
dados <- data.frame(marca=character(),
                    codigo_fipe=character(), 
                    id=character(), 
                    name_resumido=character(),
                    name_completo=character(),
                    combustivel=character(),
                    preco=character(),
                    stringsAsFactors=FALSE) 

# Rotina para raspagem dos dados

for( i in 1: 2)
{
     url <- paste0(p1,codigos_fipe[i,1],"/",codigos_fipe[i,2],p2)
    json <- fromJSON(file = url, method = "C")
       j <- 1    
    
    for(j in 1:length(json))
    {
         url2 <- paste0(p1,codigos_fipe[i,1],"/",codigos_fipe[i,2],"/",json[[j]]$id,p2) 
        json2 <- fromJSON(file = url2, method = "C")
        
        dados[l,1] <- codigos_fipe[i,1]
        dados[l,2] <- codigos_fipe[i,2]
        dados[l,3] <- json[[j]]$id
        dados[l,4] <- json[[j]]$name
        dados[l,5] <- json2$name
        dados[l,6] <- json2$combustivel
        dados[l,7] <- json2$preco
        l <- l+1
    }
}







