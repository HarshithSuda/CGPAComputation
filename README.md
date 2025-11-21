# Automated Student CGPA Computation System

A robust **PostgreSQL** based system designed to automate the calculation of Semester Grade Point Average (SGPA) and Cumulative Grade Point Average (CGPA) for academic batches. This project streamlines the processing of raw student data, handling everything from bulk data ingestion to final rank generation.

![Output Preview](image_b798c0.png)
*Preview of the final CGPA computation output.*

## 🚀 Features

* **Bulk Data Ingestion:** Utilizes the PostgreSQL `COPY` command to rapidly import large datasets (CSV) containing student course registrations and grades.
* **Dynamic Grade Mapping:** Implements a normalized relational schema to map letter grades (EX, A, B, etc.) to numeric points dynamically.
* **Weighted Calculation:** Computes SGPA and CGPA based on credit weights using complex SQL aggregation logic.
* **Advanced Reporting:** Includes `crosstab` queries (via the `tablefunc` extension) to pivot data and generate semester-wise performance reports.
* **Temporary Processing:** Uses temporary tables for intermediate calculations to ensure data integrity and query performance.

## 🛠️ Tech Stack

* **Database:** PostgreSQL
* **Query Language:** PL/pgSQL
* **Extensions:** `tablefunc` (for pivoting tables)
* **Tools:** pgAdmin 4 / psql CLI

## 📂 Database Schema

The system uses two primary tables:

### 1. `gradepoints`
Maps letter grades to their numeric equivalent.
| Column | Type | Description |
| :--- | :--- | :--- |
| `grade` | VARCHAR(2) | The letter grade (e.g., 'A', 'B', 'EX') |
| `points` | NUMERIC(2,0) | The grade point (e.g., 9, 8, 10) |

### 2. `student`
Stores the raw academic data.
| Column | Type | Description |
| :--- | :--- | :--- |
| `RegID` | NUMERIC | Unique Registration ID |
| `Ayear` | NUMERIC | Academic Year |
| `Asem` | NUMERIC | Academic Semester |
| `CourseCode` | VARCHAR | Course Identifier |
| `Credits` | NUMERIC | Credit weight of the course |
| `RegNo` | NUMERIC | Student Roll Number |
| `Grade` | VARCHAR | Grade obtained |

## 📝 Usage Instructions

### Prerequisites
Ensure you have PostgreSQL installed. You will need to enable the `tablefunc` extension for the advanced reporting features.

```sql
CREATE EXTENSION IF NOT EXISTS tablefunc;