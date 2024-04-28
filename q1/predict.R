library(stringr)
library(dplyr)
library(tibble)
library(readr)

options(scipen = 999)
args <- commandArgs(trailingOnly = TRUE)

# Load data
data <- read.csv(args[1])
colnames(data) <- c("id", "num_games_owned", "num_review", "playtime_review", "text", "votes_up", "voted_funny", "helpfulness")

# Data processing steps
keywords <- c("game", "player", "level", "play", "multiplayer", "graphics", "console", "pc", "CPU", "time", "buy",
              "story", "plot", "price", "art", "worth", "fun", "spent", "dollars", "audio")

contains_keyword <- function(text, keywords) {
  cleaned_text <- tolower(text)
  
  excessive_punct <- str_detect(cleaned_text, pattern = "[[:punct:]]{5,}")
  cleaned_text <- str_replace_all(cleaned_text, "[[:punct:]]", " ")
  cleaned_text <- str_replace_all(cleaned_text, "[^[:alnum:][:space:]]", " ")
  # Check for keywords
  keyword_present <- sapply(cleaned_text, function(x) any(str_detect(x, paste0("\\b", keywords, "\\b"))))
  keyword_present & !excessive_punct
}

data$valid_review <- contains_keyword(data$text, keywords)

# Adding weights to the predicting criteria
weights <- list(
  votes_up = 0.6,     
  playtime_review = 0.25, 
  voted_funny = 0.05,    
  num_review = 0.05,
  num_games_owned = 0.05
)

# re-calculate the helpfulness score
calculate_helpfulness <- function(df, weights) {
  non_linear_votes_up <- function(votes) {
    ifelse(votes > 1000, log(1000), log(votes + 1)) / log(1001) 
  }
  
  df$transformed_votes_up <- ifelse(df$valid_review, non_linear_votes_up(df$votes_up), 0)
  
  # Normalize the other columns that contribute to the score
  max_playtime_review <- max(df$playtime_review, na.rm = TRUE)
  max_voted_funny <- max(df$voted_funny, na.rm = TRUE)
  max_num_review <- max(df$num_review, na.rm = TRUE)
  max_num_games_owned <- max(df$num_games_owned, na.rm = TRUE)
  
  df$predicted_helpfulness <- ifelse(df$valid_review, 
                                     0.3 + 
                                       df$transformed_votes_up * weights$votes_up +
                                       (df$playtime_review / max_playtime_review) * weights$playtime_review +
                                       (df$voted_funny / max_voted_funny) * weights$voted_funny +
                                       (df$num_review / max_num_review) * weights$num_review +
                                       (df$num_games_owned / max_num_games_owned) * weights$num_games_owned,
                                     pmin(0 +
                                            df$transformed_votes_up * weights$votes_up +
                                            (df$playtime_review / max_playtime_review) * weights$playtime_review +
                                            (df$voted_funny / max_voted_funny) * weights$voted_funny +
                                            (df$num_review / max_num_review) * weights$num_review +
                                            (df$num_games_owned / max_num_games_owned) * weights$num_games_owned,
                                          0.29)
  )
  
  df$predicted_helpfulness <- ifelse(df$valid_review, pmin(df$predicted_helpfulness, 1), df$predicted_helpfulness)
  return(df)
}

result = calculate_helpfulness(data, weights)

# Save data
write.csv(result, args[2], row.names = FALSE)
