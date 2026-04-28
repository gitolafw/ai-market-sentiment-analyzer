#install.packages(c("DBI", "RSQLite", "dplyr", "ggplot2", "scales"))
#install.packages("rlang")

library(DBI)
library(RSQLite)
library(dplyr)
library(ggplot2)

con <- dbConnect(RSQLite::SQLite(), "market_data.db")

df <- dbGetQuery(con, "SELECT * FROM analytical_view")

dbDisconnect(con)


df_clean <- df %>%
  mutate(Date = as.Date(Date)) %>%
  arrange(Ticker, Date) %>%
  group_by(Ticker) %>%
  mutate(Daily_Return = (Close - lag(Close)) / lag(Close),
         Next_Day_Return = lead(Daily_Return)) %>%
  ungroup() %>%
  filter(!is.na(Daily_Return) & !is.na(Next_Day_Return) & Article_Count > 0)
  

cor_test_result <- cor.test(df_clean$Avg_Sentiment_Score, df_clean$Daily_Return)
print(cor_test_result)


df_ttest <- df_clean %>%
  mutate(News_Type = case_when(
    Avg_Sentiment_Score > 0.2 ~ "Positive",
    Avg_Sentiment_Score < -0.2 ~ "Negative",
    TRUE ~ "Neutral"
  )) %>%
  filter(News_Type %in% c("Positive", "Negative"))

t_test_result <- t.test(Daily_Return ~ News_Type, data = df_ttest)
print(t_test_result)


regression_model <- lm(Next_Day_Return ~ Avg_Sentiment_Score, data = df_clean)
print(summary(regression_model))


p <- ggplot(df_ttest, aes(x = News_Type, y = Daily_Return, fill = News_Type)) +
  geom_boxplot(alpha = 0.7, outlier.colour = "red", outlier.alpha = 0.5) +
  theme_minimal() +
  scale_fill_manual(values = c("Negative" = "#E74C3C", "Positive" = "#2ECC71")) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  labs(title = "The Impact of News Sentiment on Tech Stock Returns",
       subtitle = "Market test analysis (2018-2020) based on FinBERT NLP classification",
       x = "The tone of the news",
       y = "Daily Rate of Return (%)",
       fill = "Typ") +
  theme(legend.position = "none",
        plot.title = element_text(face = "bold", size = 14))

print(p)
