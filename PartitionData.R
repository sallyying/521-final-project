library(dplyr)
library(RCurl)

paintings = read.csv(text=getURL("https://raw.githubusercontent.com/mine-cetinkaya-rundel/sta112_f15/master/data/paris_paintings.csv")
                   , stringsAsFactors = FALSE,
                   header=TRUE)

dups = duplicated(paintings$name)
dup.names = paintings$name[dups]
length(dup.names)
 for (i in 1:length(dup.names)) {
   print(c(dup.names[i],
           filter(paintings, name == dup.names[i]) %>%
             duplicated.data.frame()
           )
   )
}
paintings = select(paintings, -name) %>% select(-quantity)

plot(logprice ~ year, data=paintings)
# Partition Data
set.seed(18)

indices <- sample(1:nrow(paintings), nrow(paintings), replace = FALSE)
#nsplit = round(nrow(paintings)/3)
nsplit = 1500
paintings_train <- paintings[indices[1:nsplit], ]
paintings_test <- paintings[indices[(nsplit+1):(nsplit + 750)], ]
paintings_validation <- paintings[indices[(nsplit+751):nrow(paintings)], ]

webdir = "~/Dropbox/STA521-F18/website/Data/"

save(paintings_train, file = paste0(webdir,"paintings_train.Rdata"))
save(paintings_test, file = paste0(webdir,"paintings_test.Rdata"))
save(paintings_validation, file = paste0(webdir,"paintings_validation.Rdata"))

paintings_test$logprice = NA
paintings_test$price = NA
paintings_validation$logprice = NA
paintings_validation$price = NA


save(paintings_train, file = "paintings_train.Rdata")
save(paintings_test, file = "paintings_test.Rdata")
save(paintings_validation, file = "paintings_validation.Rdata")

