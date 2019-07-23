## RegEx

library(...)
library(...)

docs <- ...

library(stringr)

txt <- ...
str_match(txt, '...')

## Extract structured data

for (...) {
  txt <- content(docs[[i]])
  match <- str_match(txt, '^From: (.*)')
  ...
  ...
  meta(docs[[i]], "author") <- ...
}

## Extract relational data

match <- str_match(..., ...)
subject <- ...
to <- paste(content(doc)[4:(subject[1] - 1)], collapse='')
to_list <- ...

library(...)

g <- ...
plot(...)

## Isolate unstructured information

for (i in seq(docs)) {
  lines <- content(docs[[i]])
  ...
  ...
  ...
  repeat_first <- str_match(lines, '--Original Message--')
  repeat_first <- which(!is.na(repeat_first))
  message_end <- c(repeat_first - 1, length(lines))[[1]]
  content(docs[[i]]) <- lines[message_begin:message_end]
...


## Functions for cleaning strings

clean_docs <- docs
clean_docs <- tm_map(clean_docs, ...)
clean_docs <- tm_map(clean_docs, ...)
clean_docs <- tm_map(clean_docs, ...)

clean_docs <- tm_map(clean_docs, ...)

collapse <- function(x) {
  paste(x, collapse = '')
}
clean_docs <- tm_map(clean_docs, ...)  

## Stopwords and stems

clean_docs <- tm_map(clean_docs, ...)
clean_docs <- tm_map(clean_docs, ...)

## Bag-of-Words

dtm <- ...(clean_docs)

char <- ...(clean_docs, ...)
...

inlier <- function(x) {
  n <- ...(content(x))
  ...
}
clean_docs <- tm_filter(clean_docs, ...)
dtm <- DocumentTermMatrix(clean_docs)
...
...

## Term correlations

assoc <- findAssocs(dense_dtm, ..., 0.2)


## Latent Dirichlet allocation

library(...)

k = 4
...

topics <- posterior(...)...
topics <- ...(topics)
colnames(topics) <- ...
