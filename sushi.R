get_relation = function() {
  d = df[, c("name", "relation")]
  # remove duplicated (name, relation)
  d1 = d[!duplicated(d),]
  # people with relation
  d11 = d1[!d1$relation == "",]
  # people without relation
  d12 = d1[d1$relation == "",]
  res = d11
  for (n in d12$name) {
    if (!(n %in% d11$name) && n != "") {
      res = rbind(res, c(n, ""))
    }
  }
  res
}


get_relation2 = function() {
  df = read.csv("Su-shi.csv", stringsAsFactors = FALSE)
  d = df[, c("name", "relation", "career")]
  # remove duplicated (name, relation)
  d1 = d[!duplicated(d[,1:2]),]
  # people with relation
  d11 = d1[!d1$relation == "",]
  # people without relation
  d12 = d1[d1$relation == "",]
  res = d11
  for (n in d12$name) {
    if (!(n %in% d11$name) && n != "") {
      res = rbind(res, c(n, "", ""))
    }
  }
  idx = grep("太守", res$career)
  res[idx, "career"] = "太守"
  idx = grep("县", res$career)
  res[idx, "career"] = "县官"
  res
}


df2 = get_relation2()
write.csv(df2, "/media/weiya/PSSD/Programs/neo4j-community-4.3.1/import/sushi-relation2.csv", row.names = FALSE)
