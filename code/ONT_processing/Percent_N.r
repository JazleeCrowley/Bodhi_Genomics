# What is this code for?

# CLear workspace
rm(list = ls())


# Script parameters
filename <- "barcode18_FR_cp.fasta.txt"
filepath <- "data/processed/Demultiplexed_data_readable"


# Load data
filename <- file.path(filepath, filename)
df <- read.table(filename, quote = "\"", comment.char = "")


# Convert to a string
seq_vec <- df[[1]]
seq_vec <- seq_vec[!grepl("^>", seq_vec)]  # remove headers
sequence <- paste(seq_vec, collapse = "")


# Calculate percent N
total_chars <- nchar(sequence)
num_N <- sum(strsplit(sequence, "")[[1]] == "N")
percent_N <- (num_N / total_chars) * 100