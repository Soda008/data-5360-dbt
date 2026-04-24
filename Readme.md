# Eco Essentials Data Warehouse Project
 
**Course:** DATA 5360 — Data Warehousing | Utah State University
**Team:** Pierce Hendrickson & Zach Speck
**Tools:** Fivetran · Snowflake · dbt Cloud · Tableau
**GitHub (Pierce):** [data-5360-dbt](https://github.com/Pierce2354/data-5360-dbt/tree/main)
**GitHub (Zach):** [data-5360-dbt](https://github.com/Soda008/data-5360-dbt)
 
---
 
## Project Overview
 
Eco Essentials is an eco-friendly cookware company seeking deeper insights into its sales performance and marketing effectiveness. As data management consultants, we designed and built a full end-to-end data warehouse solution — from dimensional modeling through ELT pipeline development, automated scheduling, and an executive-facing Tableau dashboard.
 
The two core business processes we focused on:
- **Online Sales** — Analyze revenue trends, product performance, and customer purchasing behavior
- **Marketing Email Conversions** — Track Salesforce Marketing Cloud email events (SENT, OPEN, CLICK) and connect them back to purchases
---
 
## Deliverable 1: Enterprise Data Warehouse Design
 
We began by analyzing Eco Essentials' two data sources — a transactional PostgreSQL database hosted on Amazon RDS and a Salesforce Marketing Cloud email events dataset stored in an AWS S3 bucket — and translating them into a dimensional model.
 
Using the Data Warehousing Toolkit methodology, we drafted a bus matrix identifying the two business processes and their shared dimensions. We then designed star schemas for each process, declaring the grain, identifying dimensions, and identifying facts. The two schemas were combined into an enterprise data warehouse using conformed dimensions — specifically dim_customer and dim_time — to ensure consistency across both fact tables.
 
The dimensional model was documented in LucidChart and included the following objects: dim_customer, dim_product, dim_promotional_campaign, dim_event, dim_campaign, dim_email, dim_time, fact_sales_eco, and fact_email_event_eco.
 
---
 
## Deliverable 2: Extract, Load, and Transform
 
### Extract and Load
We used Fivetran to extract data from both source systems and land it into raw staging tables within our personal Snowflake databases under the schema dw_ecoessentials. One Fivetran connector was configured for the PostgreSQL RDS transactional database, and a second was configured for the S3 bucket containing the marketing email events CSV. Both connectors were disabled after the initial sync completed successfully.
 
### Dimensional Model Revisions
After receiving professor feedback on Deliverable 1, we made several improvements to the dimensional model before transforming the data:
 
- Removed price from dim_product — metrics belong in fact tables, not dimensions
- Expanded dim_customer to include all relevant fields from both the customer table and subscriber info
- Removed a redundant dim_time reference from fact_sales
- Created a dedicated dim_event table — event_type had been incorrectly modeled as a fact
- Split the campaign dimension into dim_campaign and dim_email for better granularity
- Restructured fact_email_event to use foreign keys to dimensions rather than a standalone primary key
- Removed order_line_id from fact_sales as it had no analytical value
### Transform
We used dbt to build and populate all dimension and fact tables in Snowflake. Surrogate keys were generated using the dbt_utils.generate_surrogate_key() macro to ensure consistent, reliable joins between fact and dimension tables. All models were version-controlled in GitHub.
 
We validated the data warehouse by writing three business queries against it, covering revenue by product type, customers who both received marketing emails and made a purchase, and email event counts by event type and campaign.
 
---
 
## Deliverable 3: Testing and Scheduling
 
### dbt Testing
We added at least one dbt test to each model in the project, utilizing all four of dbt's built-in test types: unique, not_null, accepted_values, and relationships. These tests enforce data integrity across the warehouse and run automatically as part of the deploy job.
 
### Fivetran Scheduling
Both Fivetran connectors were configured to sync on a 24-hour cadence, keeping the raw landing tables refreshed with any new data from the source systems on a daily basis.
 
### dbt Cloud Job
A dbt Cloud deploy job was created to build all dimension and fact models and execute all tests. The job was scheduled to run daily, creating a fully automated pipeline from source to warehouse with no manual intervention required.
 
---
 
## Deliverable 4: Data Visualization
 
The final dashboard was built in Tableau with a live connection to the Eco Essentials data warehouse in Snowflake. The dashboard was designed for Eco Essentials leadership and focused on sales trends over time, revenue by product type, and marketing campaign performance — specifically which campaigns drove the most conversions from email engagement to purchase.
 
A video presentation of the dashboard was recorded to simulate delivery to an executive stakeholder audience.
 
---
 
## Key Takeaways
 
- Translating business requirements into a clean dimensional model takes iteration. Professor feedback on our initial design led to meaningful structural improvements that made the warehouse more analytically sound.
- Surrogate key generation in dbt ensures consistent, reliable joins across fact and dimension tables regardless of changes in source system keys.
- Combining Fivetran scheduling with dbt Cloud jobs creates a fully automated, end-to-end pipeline that keeps the warehouse current without manual effort.
- A live Tableau connection to Snowflake enables real-time reporting as new data flows through the pipeline, making the dashboard immediately useful for ongoing business decisions.
---
 
*Built as part of DATA 5360 — Data Warehousing at Utah State University, Jon M. Huntsman School of Business*
