data <- read.csv("D:/Documents/RStudio Files/Research/elonmusk.csv")
library(sentimentr)
library(ggplot2)

# Cleaning up data set by extracting only text, removing number of likes and re-tweets
text <- data$text
alphanum_text <- gsub("[^[:alnum:] ]+", " ", text)
clean_text <- gsub("\\s[0-9,]+[Kk]?\\s[0-9,]+[Kk]?\\s[0-9,]+[Kk]?\\s*$", "", alphanum_text)
clean_text <- gsub("\\s[0-9]+\\s*$", "", clean_text)


# Number of tweets that are replies
reply_tweets <- sum(grepl("^Replying to", clean_text, ignore.case = TRUE))

# Total number of tweets
total_tweets <- length(clean_text)

# Percentage of tweets that are replies
percentage_replies <- (reply_tweets / total_tweets) * 100

# Display the results
cat("Number of reply tweets:", reply_tweets, "\n", "Total number of tweets:", total_tweets, "\n", "Percentage of reply tweets:", percentage_replies, "%\n")


# Separate variables for replies and own tweets
replies_text <- clean_text[grepl("^Replying to", clean_text, ignore.case = TRUE)]
own_tweet_text <- clean_text[!grepl("^Replying to", clean_text, ignore.case = TRUE)]

# Sentiment for each tweet, own tweet and reply
sentiment_scores <- sentiment(clean_text)
sentiment_own <- sentiment(own_tweet_text)
sentiment_replies <- sentiment(replies_text)

# Normalizing time stamps 
timestamp <- as.POSIXct(data$Timestamp, format = "%Y-%m-%dT%H:%M:%S")
data$Timestamp <- as.POSIXct(data$Timestamp, format = "%Y-%m-%dT%H:%M:%S")
replies_timestamp <- data$Timestamp[grepl("^Replying to", data$text, ignore.case = TRUE)]
own_tweet_timestamp <- data$Timestamp[!grepl("^Replying to", data$text, ignore.case = TRUE)]

# Extracting only sentiment scores
sentiment <- sentiment_scores[, 4]
sentiment_data <- data.frame(Timestamp = timestamp, Sentiment = sentiment)
sentiment_own_tweets <- sentiment_own[, 4]
sentiment_data2 <- data.frame(Timestamp = own_tweet_timestamp, Sentiment = sentiment_own_tweets)
head(sentiment_data2)
sentiment_reply <- sentiment_replies[, 4]
sentiment_data3 <- data.frame(Timestamp = replies_timestamp, Sentiment = sentiment_reply)


ggplot(sentiment_data, aes(x = Timestamp, y = sentiment)) +
  geom_point(size = 0.1, color = "darkorchid") +
  geom_smooth(method = "loess", se = FALSE, color = "green") +
  labs(title = "Tweet Sentiment Over Time Scatterplot", x = "Timestamp", y = "Sentiment")


ggplot(sentiment_data2, aes(x = Timestamp, y = sentiment)) +
  geom_smooth(method = "loess", se = FALSE, color = "green") +
  labs(title = "Sentiment Over Time - Locally Weighted Scatterplot Smoothing", x = "Timestamp", y = "Sentiment")

ggplot(sentiment_data2, aes(x = Timestamp, y = sentiment)) +
  geom_smooth(method = "loess", se = FALSE, color = "lightseagreen") +
  labs(title = "Sentiment Over Time - Own Tweets", x = "Timestamp", y = "Sentiment")

ggplot(sentiment_data3, aes(x = Timestamp, y = sentiment)) +
  geom_smooth(method = "loess", se = FALSE, color = "tomato2") +
  labs(title = "Sentiment Over Time - Replies", x = "Timestamp", y = "Sentiment")


# Single data frame that combines sentiment_data2 and sentiment_data3
combined_data <- rbind(
  transform(sentiment_data2, Type = "Own Tweets"),
  transform(sentiment_data3, Type = "Replies")
)

# Plotting both lines
ggplot(combined_data, aes(x = Timestamp, y = sentiment, color = Type)) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(title = "Sentiment Over Time - Locally Weighted Scatterplot Smoothing", x = "Timestamp", y = "Sentiment") +
  scale_color_manual(values = c("Own Tweets" = "lightseagreen", "Replies" = "tomato2"))



# Chi-square test on contingency table
contingency_table <- table(combined_data$Type, cut(combined_data$sentiment, breaks = c(-Inf, 0, 0, Inf), labels = c("Negative", "Neutral", "Positive")))
chi_squared_result <- chisq.test(contingency_table)
print(chi_squared_result)

