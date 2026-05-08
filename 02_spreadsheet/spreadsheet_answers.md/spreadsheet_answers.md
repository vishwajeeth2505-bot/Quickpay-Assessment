Spreadsheet Cleaning and Business Logic Summary

1. Data Cleaning

The raw transaction data was cleaned by removing duplicates, handling missing values, and ensuring consistency across all fields.

⸻

2. Merchant Name Standardization

Merchant names were standardized by correcting variations in spelling and formatting. A new column cleaned_merchant_name was created for consistent analysis.

⸻

3. Date Standardization

All transaction dates were converted into a uniform format: YYYY-MM-DD.

⸻

4. Status Standardization

Transaction status values were standardized into three categories:

* CAPTURED
* FAILED
* CHARGEBACK

Invalid entries such as e05 and time out were mapped to FAILED.

⸻

5. Risk Score Standardization

Risk scores were cleaned by removing text labels and converting all values into numeric format for accurate calculations.

⸻

6. Gateway Region Standardization

Gateway regions were standardized into:

* US
* EU
* APAC

⸻

7. Currency Conversion

All transaction amounts were converted into USD using exchange rates from exchange_rates.csv, creating a new column amount_usd.

⸻

8. Merchant Data Enrichment

Merchant details were enriched using merchant_master.csv to include:

* merchant category
* account manager
* default region

⸻

9. Business Flags

Two key flags were created:

* high_value_flag based on region-specific thresholds
* high_risk_flag where risk_score > 70 or status is CHARGEBACK

⸻

10. Final Output

A cleaned dataset was prepared along with a merchant risk summary using Pivot Table for business insights.