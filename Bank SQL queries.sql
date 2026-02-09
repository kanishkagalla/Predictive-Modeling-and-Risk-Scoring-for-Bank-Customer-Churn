SELECT * FROM "Bank";

-- Customer Lifetime Value (CLV)
--Goal: Estimate how valuable a customer is over time.

SELECT "Tenure", "Balance", "EstimatedSalary",
       ("Tenure" * "Balance") AS Estimated_CLV
FROM "Bank" ORDER BY Estimated_CLV DESC;


--Cross-sell and Upsell Potential
--Goal: Identify customers who might buy more products.


SELECT "NumOfProducts", "IsActiveMember"
FROM "Bank"
WHERE "IsActiveMember" = 1
ORDER BY "NumOfProducts" DESC;


--Early Identification of Likely Churners
--Goal: Spot customers at risk before they leave.

SELECT "Tenure", "IsActiveMember", "Balance", "Exited"
FROM "Bank"
WHERE "Tenure" < 3 AND "IsActiveMember" = 0 AND "Balance" < 76458
ORDER BY "Balance", "Tenure" DESC;


--Identify Key Churn Drivers
--Goal: Compare churned vs. retained customers.

SELECT "Exited",
       ROUND(AVG("CreditScore")::NUMERIC,2) AS avg_score,
       ROUND(AVG("Age")::NUMERIC,2) AS avg_age,
       ROUND(AVG("Balance")::NUMERIC,2) AS avg_balance,
       ROUND(AVG("NumOfProducts")::NUMERIC,2) AS avg_products
FROM "Bank"
GROUP BY "Exited";


--Reduce False Positives in Churn Detection
--Goal: Refine filters to avoid mislabeling loyal customers.

SELECT "Exited", "IsActiveMember", "NumOfProducts"
FROM "Bank"
WHERE "Exited" = 0 AND "IsActiveMember" = 0;


--Scenario-Based Churn Risk Analysis
--Goal: Simulate churn risk under different conditions.

SELECT "Tenure",
	  CASE
           WHEN "Tenure" < 2 AND "IsActiveMember" = 0 THEN 'High Risk'
           WHEN "Tenure" BETWEEN 2 AND 5 THEN 'Medium Risk'
           ELSE 'Low Risk'
       END AS ChurnRiskCategory
FROM "Bank";








