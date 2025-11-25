# Customer Segment Analysis

## 📌 Project Overview
This project analyzes a retail food company's customer base to uncover behavioural patterns and segment customers using the RFM framework. The goal is to help marketing and strategy teams improve business decisions, better understand customer value, improve retention, and guide targeted outreach.

The analysis includes end-to-end data work: cleaning, transforming, SQL queries, customer clustering logic, and a Power BI dashboard for interactive insight exploration.

<img width="1510" height="852" alt="Screenshot 2025-11-22 083209" src="https://github.com/user-attachments/assets/29b621b9-eddc-4e67-946a-1d3904c3f066" />

## 🧠 Business Problem

The company had uniform treatment of the customer base leading to:
- Poor retention among high value segment
- Low personalization of marketing campaigns
- No understanding of purchasing patterns

The projects solves this through identification of customer segments and further recommended actions for each group

## 🔧 Tools & Technologies
- SQL (PostgreSQL)
- Power BI (Interactive dashboard)
- Excel

## 🧼 Data Cleaning & Preparation
- Creating database tables from raw data
- Standardizing date formats and categorical values
- Handling missing values
- Creating key variables

## 📊 Methodology
### 1. Exploratory Data Analysis (EDA)
Examined patterns in customer behaviour, generated core summary statistics and analyzed behaviour at a customer level

### 2. RFM Segmentation
Calculated:
- Recency score
- Frequency score
- Monetary score

Generated 10 customer segments:
- Loyalist
- Potential Loyal
- New Customer
- Growing
- Promising
- Est. Spender
- Big Spender
- Loyal (At Risk)
- Customer At Ridk
- Lost

Created view for export
### 3. Dashboard
Built a modern, proefessional dashboard including:
- KPI summary
- Distribution visuals
- RFM bubble analysis
- Customer details
- Suggested action
- Key variable slicer

Created conditional columns for income segment and suggested action

## 💡 Key Insights
- Loyalists and Est. Spenders make up only 28% of customers but generate 55.7% of total revenue
- At Risk customers generate 15.3% of total revenue
- Big Spenders Est. Spenders average 1.6k monetary per customer
- R scores of 1 total 19.8% of revenue
- Lost segment group has $173k total revenue
- Low-income group (20k-50k) average frequency of 7.12
- Hight-income groups (50k+) bring in 87% of revenue at only 51% of customers

## 🎯 Recommendations
Each segment includes tailored strategies such as:
- Reward loyalists to increase retention
- Re-engage customers at risk with win back campaigns
- Upsell big spenders with premium bundles
- Nurture promising and new customers with incentives

## 📁 How to Use This Repo
Open the Jupyter Notebook for EDA, SQL execution, and RFM logic
Review SQL files for all transformations
Open the Power BI dashboard (PBIX file) for interactive exploration


  
