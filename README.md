# **Predicting Manufacturing Defects Dataset**

### <u>Domain</u>
This operates in the Domain of Manufacturing Quality Control and Predictive Analytics. 
Aiming to recognize what causes defects, track it, and predict it before it can occur.
Thus enabling higher quality management in manufacturing.

### <u>High-Level Goals</u>
#### <u>Primary</u>
- Track production metrics
- Track defect
- Monitor for what causes defects
- Quality trend windows

### <u>Users</u>
- Quality-control managers
- Executives

### <u>Data Source(s)</u>
- https://www.kaggle.com/datasets/rabieelkharoua/predicting-manufacturing-defects-dataset

## **Scope**

### <u>A - Project Selection and Workspace Setup</b>
- Define the application domain and high-level goals.

### <u>B - Conceptual Design (E/R Diagram)</b>
- Identify entities, relationships, and constraints.
- Model non-trivial relationships including many-to-many. You should certainly include different kinds of
relationships (e.g., many-one, many-many) and different kinds of data (strings, integers, etc.)

### <u>C -  Relational Schema and Normalization</b>
- Identify functional dependencies.
- Normalize relations to BCNF. Check if each relation in your schema is in Boyce-Codd Normal Form (BCNF)
with respect to the functional dependencies you specified. If not, decompose the relation into smaller
relations so that each relation is in BCNF

### <u>D - SQL Implementation and Data Population</b>
- Implement schema using SQL DDL.
- High-level programing script (eg. Python) to preprocess your data.
- Populate data using real or fabricated datasets.

### <u>E - User Interface Development</b>
- Implement at least five meaningful user operations.
- Support queries and modifications. Your application should demostrates
  - At least one JOIN query involving two or more relations
  - At least one WINDOW function query (e.g., ROW_NUMBER, RANK, LAG, LEAD, running totals, or
moving averages)
  - At least one aggregate query using functions such as COUNT, SUM, AVG, MIN, or MAX
