-- RFM Segmentation
DELETE FROM sales
WHERE total_orders = 0

ALTER TABLE customer
ADD COLUMN days_since_joined numeric

UPDATE customer
SET days_since_joined = '2014-07-01' - date_joined

ALTER TABLE customer
ADD COLUMN dependents numeric

UPDATE customer
SET dependents = kids_in_home + teens_in_home

CREATE VIEW RFM_Segmentation AS

WITH rfm_score AS (
SELECT 
customer_id, recency, total_orders AS frequency, total_price AS monetary,
NTILE(5) OVER (ORDER BY recency desc) as r_score,
NTILE(5) OVER (ORDER BY total_orders asc) as f_score,
NTILE(5) OVER (ORDER BY total_price asc) as m_score
FROM sales
),
rfm_segment AS (
SELECT customer_id, recency, frequency, monetary,
(r_score::char(1) || f_score::char(1) || m_score::char(1)) AS rfm_score,
r_score, f_score, m_score, r_score + f_score + m_score AS total_score,
CASE
    WHEN r_score >= 3 AND f_score >= 4 AND m_score >= 3 THEN 'Loyalist'
    WHEN r_score >= 4 AND f_score BETWEEN 2 AND 3 AND m_score BETWEEN 2 AND 4 THEN 'Potential Loyalist'
	 WHEN r_score >= 4 AND (f_score = 1 or m_score = 1) THEN 'New Customer'
    WHEN r_score = 3 AND f_score BETWEEN 2 AND 3 AND m_score BETWEEN 2 AND 4 THEN 'Growing'
    WHEN r_score = 3 AND f_score <= 2 AND m_score <= 2 THEN 'Promising'
    WHEN f_score = 5 AND m_score = 5 AND r_score <= 3 THEN 'Established Spender'
	WHEN m_score = 5 AND f_score <= 3  THEN 'Big Spender'
    WHEN r_score = 2 AND (f_score >= 4 OR m_score >= 4) THEN 'Loyal Customer At Risk'
    WHEN r_score = 2 AND f_score <= 3 AND m_score <= 3 THEN 'Customer At Risk'
    WHEN r_score = 1 THEN 'Lost'
ELSE 'Misc'
END AS rfm_segmenting
FROM rfm_score
)
SELECT distinct rfm_segmenting
FROM rfm_segment