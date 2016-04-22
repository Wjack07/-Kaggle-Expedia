setwd(".../Expedia")
filename = "train.csv"
f <- file(filename, open="rb")
nlines <- 0L

## readBin function has its flag, so every calling will start from the flag, which is very convenient
## rawToChar(as.raw(10L)) is equal to '\n'

while (length(chunk <- readBin(f, "raw", 65536)) > 0) {
  nlines <- nlines + sum(chunk == as.raw(10L))
}
print(nlines)
close(f)
