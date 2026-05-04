CREATE DATABASE ipl_db;
USE ipl_db;
SELECT * FROM matches LIMIT 5;
SELECT * FROM deliveries LIMIT 5;

#Q1 — Total matches played per season
SELECT
    season,
    COUNT(*) AS total_matches
FROM matches
GROUP BY season
ORDER BY season;

#Q2 — Most IPL titles won by team (1 title = 1 match)
SELECT
    winner,
    COUNT(*) AS titles
FROM matches
WHERE match_type = 'Final'
   OR result IS NOT NULL
GROUP BY winner
ORDER BY titles DESC
LIMIT 10;

#Q3 — Top 10 run scorers all time
SELECT
    batter,
    SUM(batsman_runs) AS total_runs,
    COUNT(DISTINCT match_id) AS matches_played,
    ROUND(SUM(batsman_runs) / COUNT(DISTINCT match_id), 2) AS avg_runs_per_match
FROM deliveries
GROUP BY batter
ORDER BY total_runs DESC
LIMIT 10;

#Q4 — Top 10 wicket takers all time
SELECT
    bowler,
    COUNT(*) AS total_wickets
FROM deliveries
WHERE dismissal_kind IS NOT NULL
  AND dismissal_kind NOT IN ('run out', 'retired hurt', 'obstructing the field')
GROUP BY bowler
ORDER BY total_wickets DESC
LIMIT 10;

#Q5 — Toss win vs match win analysis
SELECT
    toss_decision,
    COUNT(*) AS total,
    SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) AS won_after_toss,
    ROUND(
        SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
    2) AS win_percentage
FROM matches
WHERE winner IS NOT NULL
GROUP BY toss_decision;

#Q6 — Best bowling economy rate (min 50 overs bowled)
SELECT
    bowler,
    COUNT(*) AS balls_bowled,
    SUM(total_runs) AS runs_given,
    ROUND(SUM(total_runs) * 6.0 / COUNT(*), 2) AS economy_rate
FROM deliveries
GROUP BY bowler
HAVING balls_bowled >= 300   -- at least 50 overs
ORDER BY economy_rate ASC
LIMIT 10;

# Q7 — Most sixes hit by batsman
SELECT
    batter,
    COUNT(*) AS total_sixes
FROM deliveries
WHERE batsman_runs = 6
GROUP BY batter
ORDER BY total_sixes DESC
LIMIT 10;

#Q8 — Average first innings score by venue (JOIN)
SELECT
    m.venue,
    ROUND(AVG(innings_total), 0) AS avg_first_innings_score
FROM matches m
JOIN (
    SELECT
        match_id,
        SUM(total_runs) AS innings_total
    FROM deliveries
    WHERE inning = 1
    GROUP BY match_id
) inn ON m.id = inn.match_id
GROUP BY m.venue
HAVING COUNT(*) >= 5
ORDER BY avg_first_innings_score DESC
LIMIT 10;

#Q9 — Season-wise runs scored trend
SELECT
    m.season,
    SUM(d.total_runs) AS total_runs,
    ROUND(AVG(d.total_runs), 2) AS avg_runs_per_ball
FROM deliveries d
JOIN matches m ON d.match_id = m.id
GROUP BY m.season
ORDER BY m.season;

#Q10 — Win % batting first vs chasing
SELECT
    CASE WHEN toss_decision = 'bat' THEN 'Batted First'
         ELSE 'Chased' END AS strategy,
    COUNT(*) AS total_matches,
    SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) AS wins,
    ROUND(
        SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
    1) AS win_pct
FROM matches
WHERE winner IS NOT NULL
GROUP BY toss_decision;

#Q11 — Rank batsmen by runs per season
WITH season_runs AS (
    SELECT
        m.season,
        d.batter,
        SUM(d.batsman_runs) AS runs
    FROM deliveries d
    JOIN matches m ON d.match_id = m.id
    GROUP BY m.season, d.batter
),
ranked AS (
    SELECT
        season,
        batter,
        runs,
        RANK() OVER (PARTITION BY season ORDER BY runs DESC) AS season_rank
    FROM season_runs
)
SELECT * FROM ranked
WHERE season_rank = 1
ORDER BY season;

#Q12 — Running total of matches played
SELECT
    season,
    COUNT(*) AS matches_this_season,
    SUM(COUNT(*)) OVER (ORDER BY season) AS running_total_matches
FROM matches
GROUP BY season
ORDER BY season;

#Q13 — Most consistent batsman 
WITH match_scores AS (
    SELECT
        batter,
        match_id,
        SUM(batsman_runs) AS match_score
    FROM deliveries
    GROUP BY batter, match_id
)
SELECT
    batter,
    COUNT(*) AS innings,
    ROUND(AVG(match_score), 1) AS avg_score,
    ROUND(STD(match_score), 1) AS std_deviation
FROM match_scores
GROUP BY batter
HAVING innings >= 30
ORDER BY std_deviation ASC
LIMIT 10;

#Q14 — Best powerplay bowlers
SELECT
    bowler,
    COUNT(*) AS balls,
    SUM(total_runs) AS runs_conceded,
    SUM(CASE WHEN dismissal_kind IS NOT NULL
             AND dismissal_kind != 'run out'
             THEN 1 ELSE 0 END) AS wickets,
    ROUND(SUM(total_runs) * 6.0 / COUNT(*), 2) AS economy
FROM deliveries
WHERE `over` BETWEEN 0 AND 5
GROUP BY bowler
HAVING balls >= 60
ORDER BY economy ASC
LIMIT 10;

#Q15 — Death over specialists
SELECT
    bowler,
    COUNT(*) AS balls,
    SUM(total_runs) AS runs,
    ROUND(SUM(total_runs) * 6.0 / COUNT(*), 2) AS death_economy
FROM deliveries
WHERE `over` BETWEEN 15 AND 19
GROUP BY bowler
HAVING balls >= 60
ORDER BY death_economy ASC
LIMIT 10;