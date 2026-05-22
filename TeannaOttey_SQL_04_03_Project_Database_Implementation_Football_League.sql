-- DDL (Database Definition Language) 
-- 1. Create tables, set data types, constraints, and relationships 
--1a. Create referenced tables first - pre-define primary keys referenced by foreign keys 

-- Create groups table 
CREATE TABLE "groups" (
	group_id integer PRIMARY KEY, 
	-- every group must have a name 
	group_name VARCHAR(100) NOT NULL
); 

-- Create teams table 
CREATE TABLE teams (
	team_id integer PRIMARY KEY,
	-- every team must have a name 
	team_name VARCHAR(100) NOT NULL
); 	

-- Create matches table 
CREATE TABLE matches (
	match_id integer PRIMARY KEY,
	-- every match type must have a name 
	match_type VARCHAR(100) NOT NULL
); 

-- Create venues table 
CREATE TABLE venues (
	venue_id integer PRIMARY KEY,
	-- every venue must have a name 
	venue_name VARCHAR(100) NOT NULL
); 

-- Create events table
CREATE TABLE events (
	event_id integer PRIMARY KEY,
	-- every event type must have a name 
	event_type VARCHAR(100) NOT NULL
); 


--1b. Create referencing tables - define referential constraint and foreign keys

-- Create fixtures table 
CREATE TABLE fixtures (
	fixture_id integer PRIMARY KEY, 
	--foreign key referencing fixture_id in fixtures table 
	venue_id integer REFERENCES venues (venue_id),
	-- foreign key references match_id in matches table 
	match_id integer REFERENCES matches (match_id)	
); 

-- Create fixture_teams table 
CREATE TABLE fixture_teams (
	fixture_id integer, 
	team_id integer, 
	-- only 2 options - 'Home' or 'Away' (4 characters)
	-- home or away status may be undecided, can be NULL 
	home_away CHAR(4),
	-- composite key as home/away status is dependent on both the team and fixture 
	PRIMARY KEY (fixture_id, team_id)
);

-- Create schedule table 
CREATE TABLE schedule (
	schedule_id integer PRIMARY KEY, 
	--foreign key referencing fixture_id in fixtures table 
	-- fixture may not be scheduled yet, can be NULL
	fixture_id integer REFERENCES fixtures (fixture_id),
	-- date of fixture may not be assigned yet, can be NULL
	-- YYYY-MM-DD
	scheduled_date date, 
	-- time of fixture may not be assigned yet, can be NULL
	-- HH:MM
	scheduled_time time, 
	-- week of fixture may not be assigned yet, can be NULL
	scheduled_week integer 
); 

-- Create players table 
CREATE TABLE players (
	player_id integer PRIMARY KEY, 
	-- all players have a pre-assigned consultant id, cannot be NULL 
	consultant_id integer NOT NULL, 
	-- each player must have a name 
	player_name VARCHAR(100) NOT NULL, 
	-- all players are members of Rockborne so must be a part of a group, cannot be NULL
	group_id integer REFERENCES "groups" (group_id) NOT NULL,
	-- a player may not be assigned a team yet, can be NULL
	team_id integer REFERENCES teams (team_id)
); 

-- Create fixture_events table 
CREATE TABLE fixture_events (
	fixture_event_id integer PRIMARY KEY, 
	-- each event should reference a given fixture, can be NULL - update later if missing 
	fixture_id integer REFERENCES fixtures (fixture_id), 
	-- each event should reference a given player, can be NULL - update later if missing
	player_id integer REFERENCES players (player_id), 
	-- each event must be identified, cannot be NULL
	event_id integer REFERENCES events (event_id) NOT NULL, 
	-- the time of an event may not have been recorded, can be NULL 
	-- HH:MM:SS 
	time_of_event time 
); 

--DML (Database Manipulation Language)
-- 2. Populate tables with data 
--2a. use INSERT INTO to populate tables with mimimal records/fields 

-- Populate groups table 
INSERT INTO "groups"
	(group_id, group_name)
VALUES
	(1, 'Bench'),
	(2, 'Cohort 4'),
	(3, 'Cohort 5'),
	(4, 'Cohort 6'),
	(5, 'Cohort 7'),
	(6, 'Consultants'),
	(7, 'HR'),
	(8, 'Training Team'); 
	
-- review columns and data type / completed population  
SELECT *
FROM "groups"; 


-- Populate teams table 
INSERT INTO teams 
	(team_id, team_name)
VALUES 
	(1, 'BI Gods'), 
	(2, 'Data Cleaners'), 
	(3, 'Data Masters'), 
	(4, 'Vis Wizards'); 

-- review columns and data type / completed population  
SELECT *
FROM teams; 


-- Populate matches table
INSERT INTO matches 
	(match_id, match_type)
VALUES 
	(1, 'Competitive'), 
	(2, 'Friendly'); 

-- review columns and data type / completed population  
SELECT *
FROM matches; 

-- Populate venues table 
INSERT INTO venues 
	(venue_id, venue_name)
VALUES 
	(1, 'Wimbledon 1'), 
	(2, 'Wimbledon 2'),
	(3, 'Wimbledon 3'); 

-- review columns and data type / completed population  
SELECT *
FROM venues; 

-- Populate events table 
INSERT INTO events 
	(event_id, event_type)
VALUES 
	(1, 'Goal'), 
	(2, 'Yellow Card'),
	(3, 'Red Card'); 

-- review columns and data type / completed population  
SELECT *
FROM events; 

/*2b. convert Excel sheets with populated data into cvs file, import into tables 
with several records and fields */ 

-- Populate fixtures table 
-- review columns and data type / completed population 
SELECT *
FROM fixtures; 

-- Populate fixture_teams table 
-- review columns and data type / completed population 
SELECT *
FROM fixture_teams; 

-- Populate schedule table 
-- review columns and data type / completed population 
SELECT *
FROM schedule; 

-- Populate players table 
-- review columns and data type / completed population 
SELECT *
FROM players; 

-- Populate fixture_events table 
-- review columns and data type / completed population 
SELECT *
FROM fixture_events; 

-- DQL (Database Query Language)
-- 3. Test database implementation 

--3a. List all players who belong to Cohort 7 and their respective teams 

-- syntax error 
-- select data starting with players table 
SELECT 
	p.player_id, 
	p.player_name, 
	g.group_name, 
	t.team_name 
FROM players p
-- join the group table based on group_id 
LEFT JOIN "groups" g 
ON p.group_id = g.group_id
AND p.team_id = t.team_id
WHERE group_name = 'Cohort 7'; 

--updated query, join syntax  
-- select data starting with players table 
SELECT 
	p.player_id, 
	p.player_name, 
	g.group_name, 
	t.team_name 
FROM players p
-- join the group table based on group_id 
JOIN "groups" g 
ON p.group_id = g.group_id
-- join the team table based on team_id 
LEFT JOIN teams t -- return all players in Cohort 7, even if not assigned a team 
ON p.team_id = t.team_id
WHERE group_name = 'Cohort 7'; -- filter results, players in Cohort 7


/* 3b. List all fixtures that take place on August 10th, 2022 
including team names and venue */ 

-- query successful but no data output 
SELECT 
	f.fixture_id, 
	s.scheduled_date, 
	v.venue_name, 
	t.team_name
FROM fixtures f 
-- join the schedule table based on fixture_id 
INNER JOIN schedule s -- only return fixtures that have a scheduled date 
ON f.fixture_id = s.fixture_id 
-- join the venue table based on venue_id
LEFT JOIN venue v -- return all fixtures on Aug 10th,2022, even if not assigned a venue 
ON f.venue_id = v.venue_id 
-- join the fixture_teams table based on fixture_id to access team table 
LEFT JOIN fixture_teams ft -- return all fixtures on Aug 10th,2022, even if 
ON f.fixture_id = ft.fixture_id
-- join the teams table based on team_id 
LEFT JOIN teams t -- return all fixtures on Aug 10th,2022, even if no teams assigned 
ON ft.team_id = t.team_id 
WHERE scheduled_date = 2022-10-08; -- filter results, fixtures on Aug 10th, 2022

-- updated query, venues table name & 'date'  
SELECT 
	f.fixture_id, 
	s.scheduled_date, 
	v.venue_name, 
	t.team_name
FROM fixtures f 
-- join the schedule table based on fixture_id 
INNER JOIN schedule s -- only return fixtures that have a scheduled date 
	ON f.fixture_id = s.fixture_id 
-- join the venue table based on venue_id
LEFT JOIN venues v -- return all fixtures on Aug 10th,2022, even if not assigned a venue 
	ON f.venue_id = v.venue_id 
-- join the fixture_teams table based on fixture_id to access team table 
LEFT JOIN fixture_teams ft 
	ON f.fixture_id = ft.fixture_id
-- join the teams table based on team_id 
LEFT JOIN teams t -- return all fixtures on Aug 10th,2022, even if no teams assigned 
	ON ft.team_id = t.team_id 
WHERE s.scheduled_date = '2022-10-08'; -- filter results, fixtures on Aug 10th, 2022

/* 3c. For each team, present the distribution of goals scored
in each half of the match */ 
SELECT 
	fe.fixture_id, 
	t.team_name, 
	-- calculate first half goals 
	SUM(CASE 
			WHEN fe.event_id = 1 -- event_id 1 = goal 
			AND fe.time_of_event < '00:45:00' -- half of 90 min game
			THEN 1 ELSE 0 
		END) as first_half_goals, 
	-- calculate second half goals 
	SUM(CASE
			WHEN fe.event_id = 1
			AND fe.time_of_event >= '00:45:00'
			THEN 1 ELSE 0
		END) as second_half_goals
FROM fixture_events fe 
-- join fixture_teams table based on fixture_id
JOIN fixture_teams ft 
	ON fe.fixture_id = ft.fixture_id
-- join teams table based on team_id
JOIN teams t 
	ON ft.team_id = t.team_id 
GROUP BY
	fe.fixture_id, 
	t.team_name -- goals per fixture and team 
ORDER BY fixture_id ASC; -- view teams playing in the same game 
	