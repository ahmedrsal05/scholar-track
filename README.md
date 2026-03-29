# 🎓 scholar-track
### End-to-end student performance data pipeline for Data Engineering Zoomcamp

---

## 🎯 The Problem: The "Context Gap" in Education

### The Current Reality
Educational leadership often lacks a unified view of student success. While **academic outcomes** (grades) are tracked, the **contextual drivers**—socio-economic factors, behavioral habits (sleep, internet access), and parental engagement—are typically siloed in disconnected spreadsheets or manual surveys. 

Because these datasets live in different formats and locations, it is nearly impossible to see how a student's life outside the classroom is impacting their performance inside it.

### The Problem This Project Solves
This project builds the **"Data Bridge"** between these disconnected silos. By creating a centralized, cloud-native pipeline, it eliminates the need for manual data stitching and provides a single source of truth.

**This infrastructure enables a Headteacher or Administrator to:**
* **Identify Root Causes:** Correlate non-academic factors directly with performance trends.
* **Replace Manual Overload:** Move away from error-prone VLOOKUPs toward a high-performance Data Warehouse.
* **Scale for Growth:** Establish a foundation where future data can be ingested and optimized without rebuilding the system.

---

## 🏗️ Project Architecture (The "Speed Secrets")

| Phase | Task | Speed Secret (The "How") |
| :--- | :--- | :--- |
| **Step 1** | **Git Setup**  | Secured environment using `.gitignore` to protect GCP service keys. |
| **Step 2** | **Infrastructure**  | **Terraform** used to provision GCS and BigQuery via a single `main.tf`. |
| **Step 3** | **Ingestion**  | **Kestra & Python** orchestrated the flow of raw behavioral data into a GCP Bucket. |
| **Step 4** | **DW Load**  | Data moved from GCS into **BigQuery** via External Tables/Load Jobs. |
| **Step 5** | **Optimisation**  | Implemented `PARTITION BY` and `CLUSTER BY` in SQL DDL for high-speed querying. |
| **Step 6** | **Visualization** | Linked **Looker Studio** to BigQuery for comprehensive, real-time reporting. |

---

> **Note on Automation:** While the current pipeline is triggered as needed, the architecture is designed for "future automation," allowing for seamless integration with live School Management Systems (SMS) in later iterations.
