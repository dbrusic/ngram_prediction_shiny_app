library(data.table)

query_table <- readRDS("query_table.rds")
setkey(query_table, base)