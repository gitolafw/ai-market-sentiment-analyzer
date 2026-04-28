# 📈 FinBERT Market Sentiment: Can AI Trade Stocks?

**From raw news headlines to an interactive Power BI trading dashboard.**

This project is a full end-to-end data journey. I wanted to see what happens when you feed thousands of financial news headlines to an AI, map its sentiment to historical stock prices, and backtest a trading strategy.

## 🎯 The Big Question
Can an AI accurately read the daily news, predict tech stock movements, and actually serve as a profitable trading signal?

---

## 🛠️ How It Was Built (The Tech Stack)

Here is how the data flows from raw text to the final dashboard:

* **Python (Data Prep & AI):** Chewed through a massive 6GB Kaggle dataset to filter out news for 7 big tech stocks. Then, I unleashed Hugging Face's **FinBERT** model to read the headlines and score their vibe (positive, negative, or neutral).
* **SQLite (Storage):** Combined the AI sentiment scores with real stock market data (pulled via Yahoo Finance API) into a clean, easy-to-query local database.
* **R / RStudio (Math & Proof):** Hooked R directly to the database to run the actual math (Pearson Correlation, T-Tests). I needed to prove the connection between news sentiment and price action wasn't just a coincidence.
* **Power BI (Visuals & Backtesting):** Built a 3-page interactive dashboard using DAX to visualize the findings and simulate how the trading strategy would have performed in the real world.

---

## 📊 What I Found (The Insights)

1. **The AI Actually Gets It:** FinBERT did a surprisingly good job telling hype from panic. The statistical tests proved that days with positive news had significantly higher average returns than days with negative news.
2. **The Strategy Made Money (On Paper):** When backtesting in Power BI, a simple strategy—only buying stocks on days when the AI sentiment was positive—resulted in a solid, compounding return with a **68.38% Win Rate** across 2018-2020.
3. **The Market Does Not Wait:** Testing confirmed the Efficient Market Hypothesis. Yesterday's news is already old news. The market reacts to the sentiment on the *exact same day*, meaning a real-world trading bot would need to act lightning-fast.

---

## 📸 Dashboard Previews

### 1. Executive Market Overview
*The big picture: KPIs, quarterly trends, and media hype share.*
![Executive Overview](/images/executive_market_overview.png)

### 2. AI Sentiment Deep Dive
*Proving the concept: FinBERT's mood swings and a scatter plot showing how sentiment correlates with returns.*
![Sentiment Deep Dive](/images/ai_sentiment_deep_dive.png)

### 3. Strategy Backtesting
*The money shot: A dynamic simulation of cumulative profits if we actually followed the AI's advice.*
![Strategy Backtesting](/images/strategy_backtesting.png)

---

## ⚙️ Want to Run It Yourself?

1. **Get the Data:** Run `01_stock_data_ingestion.ipynb` to pull the financial numbers.
2. **Extract News:** Run `02a_kaggle_extraction.ipynb` to parse the massive raw CSV file in manageable chunks.
3. **Let the AI Read:** Execute `02b_sentiment_analysis.ipynb` so FinBERT can score the extracted headlines.
4. **Merge It All:** Use `03_stock_data_merger.ipynb` to marry the stock prices with the AI sentiment and build the SQLite database.
5. **Play with the Dashboard:** Open the `.pbix` file in Power BI Desktop to check out the visuals and the backtesting engine.
