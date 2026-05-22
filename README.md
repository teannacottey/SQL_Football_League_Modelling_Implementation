# READMe - Football League Implementation

### Project Overview

This project is the design and implementation of a football league relational database using PostgreSQL. It covers the full development process, from data modelling through to physical implementation, including schema creation, data population, and query-based testing. The database is designed to accurately represent entities such as teams, players, fixtures, and events, while enforcing relationships and maintaining data integrity.

### Database Summary

Key Database Elements: 

- 10 Tables
- 40 Players
- 4 Teams
- 14 Fixtures
- 45 Fixture Events

### Technologies Used

- **PostgreSQL** (pgAdmin 4)
    - Database Implementation & Testing
    - ER Diagram
- **Lucid Charts**
    - ER Diagram
- **Excel**
    - Data Preparation
    - CSV file conversion

### Database Structure

Tables included in the database: 

- **Groups** → Stores information about the groups players belong to
- **Teams** → Stores information about the teams players are assigned to
- **Matches** → Defines and stores information about different match types (i.e. Competitive or Friendly)
- **Venues** → Stores information about fixture locations
- **Events** → Defines and stores information about different fixture event types (i.e. Goal, Yellow Card, Red Card)
- **Fixtures** → Stores information about each fixture
- **Fixture_Teams** → Stores information about the home or away status of a team in a given fixture
- **Schedule** → Stores fixture date and time information
- **Players** → Stores information about each player
- **Fixture_Events** → Stores information about the events occurred in a fixture

Entity relationships were enforced using primary and foreign keys. 

### Design Decisions

Prior to implementation, the following improvements were made: 

- Renamed ‘Results’ entity → ‘Fixture_Events’
- Altered naming conventions → snake_case
- Introduced new ‘Schedule’ entity
- Renamed ‘Date’, ‘Time’ and ‘Week’ attributes → ‘scheduled_date’, ‘scheduled_time’, scheduled_week’

### Database Implementation

#### 1. Create and Connect to Database

Process: 

1. Connect to the desired server 
2. Right-click databases → Create → Database 
3. Name database ‘football_league’ → Save 
4. Right-click ‘football_league’ → Query Tool 

#### 2. Create Tables

Tables stored in the public schema under ‘football_league’

Process: 

1. Run table creation script using the following script syntax 

CREATE TABLE table_name ( 

column_name data type CONSTRAINT, 

column_name data type CONSTRAINT,

); 

#### 3. Populate Tables

Using the provided CSV files, import data into the created tables 

Process: 

1. Right-click on a table under the schema tab → Import/Export Data
2. Import → locate CSV file 
3. Options → check headers → set delimiter as “,” → OK 
4. Check if data population was completed successfully using the following script syntax 

SELECT *

FROM table_name; 

### Testing

Verifying the functionality of the defined schema, the following SQL queries were run: 

- List all players who belong to Cohort 7 and their respective teams
- List all fixtures that take place on August 10th, 2022, including team name and venue
- For each team, present the distribution of goals scored in each half of the match

Each test includes in-SQL documentation, SQL queries, and output results. 

### Future Work

This database can be expanded by:

- Adding further player information, e.g. age or height
- Adding further fixture information, e.g. status (scheduled, postponed, cancelled, etc.)
- Adding further venue information, e.g. (capacity, surface type)
- Adding a new ‘Manager’ entity with relation to ‘Teams’
- Adding a new ‘Referee’ entity with relation to ‘Fixtures’
- Adding a new ‘Seasons’ entity with relation to ‘Schedule’
