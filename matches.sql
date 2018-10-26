with initial_table as (select Country.id,
		Country.name AS country,
		League.name AS league,
		match.season AS match_season,
		match.stage,
		HT.team_long_name AS  home_team,
		AT.team_long_name AS away_team,
		match.home_team_goal,
		match.away_team_goal
	from Country
	join League
	on Country.id = League.id
	join match
	on Country.id = match.country_id
	LEFT JOIN Team AS HT on HT.team_api_id = Match.home_team_api_id
	LEFT JOIN Team AS AT on AT.team_api_id = Match.away_team_api_id
	/*WHERE match_season = '2015/2016' AND league='Belgium Jupiler League'*/),	
team_home as (select initial_table.id as id,
		initial_table.country as country,
		initial_table.league as league,
		initial_table.match_season as match_season,
		initial_table.stage as stage,
		initial_table.home_team as home_team,
		initial_table.home_team_goal AS goals_scored,
		initial_table.away_team_goal AS goals_conceded,
		CASE WHEN initial_table.home_team_goal > initial_table.away_team_goal THEN 1 
			ELSE 0
			END AS won,
		CASE WHEN initial_table.home_team_goal = initial_table.away_team_goal THEN 1 
			ELSE 0
			END AS draw,
		CASE WHEN initial_table.home_team_goal < initial_table.away_team_goal THEN 1 
			ELSE 0
			END AS lost
from initial_table	
),
team_away as (select initial_table.id,
		initial_table.country AS country,
		initial_table.league AS league,
		initial_table.match_season AS match_season,
		initial_table.stage as stage,
		initial_table.away_team AS away_team,
		initial_table.away_team_goal AS goals_scored,
		initial_table.home_team_goal AS goals_conceded,
		CASE WHEN initial_table.away_team_goal > initial_table.home_team_goal THEN 1 
			ELSE 0
			END AS won,
		CASE WHEN initial_table.home_team_goal = initial_table.away_team_goal THEN 1 
			ELSE 0
			END AS draw,
		CASE WHEN  initial_table.away_team_goal < initial_table.home_team_goal THEN 1 
			ELSE 0
			END AS lost
from initial_table)	,
matches_home as (
	SELECT team,
		   country,
		   league,
		   match_season,
		   won,
		   draw,
		   lost,
	       goals_scored,
		   goals_conceded,
		   won*3 + draw AS points
		FROM (SELECT team_home.home_team as team,
			team_home.country as country,
			team_home.league as league,
			team_home.match_season as match_season,
			SUM(team_home.won) as won,
			SUM(team_home.draw) as draw,
			SUM(team_home.lost) as lost,
			SUM(team_home.goals_scored) as goals_scored,
			SUM(team_home.goals_conceded) as goals_conceded
				FROM team_home
				GROUP BY 1,2,3,4)
		),
matches_away as (
	SELECT team,
		   country,
		   league,
		   match_season,
		   won,
		   draw,
		   lost,
	       goals_scored,
		   goals_conceded,
		   won*3 + draw AS points
		FROM (SELECT team_away.away_team as team,
			team_away.country as country,
			team_away.league as league,
			team_away.match_season as match_season,
			SUM(team_away.won) as won,
			SUM(team_away.draw) as draw,
			SUM(team_away.lost) as lost,
			SUM(team_away.goals_scored) as goals_scored,
			SUM(team_away.goals_conceded) as goals_conceded
				FROM team_away
				GROUP BY 1,2,3,4)	
		),
matches as (
	select matches_home.country,
	   matches_home.league, 
	   matches_home.match_season,
	   matches_home.team, 
	   matches_home.won + matches_away.won + matches_home.draw + matches_away.draw + matches_home.lost + matches_away.lost as game_played,
	   matches_home.points + matches_away.points as points,
	   matches_home.won + matches_away.won as won,
	   matches_home.draw + matches_away.draw as draw,
	   matches_home.lost + matches_away.lost as lost,
	   matches_home.goals_scored + matches_away.goals_scored as goals_scored,
	   matches_home.goals_conceded + matches_away.goals_conceded as goals_conceded,
	   (matches_home.goals_scored + matches_away.goals_scored) - (matches_home.goals_conceded + matches_away.goals_conceded) as goals_difference
	from matches_home
	join matches_away
	on matches_home.team = matches_away.team and matches_home.match_season = matches_away.match_season
		and matches_home.country = matches_away.country
		and matches_home.league = matches_away.league
	order by points desc
)
SELECT country,
	league,
	match_season,
	team,
	game_played,
	points,
	won,
	draw,
	lost,
	goals_scored,
	goals_conceded,
	goals_difference
from matches
/*where country = 'Belgium'*/
order by country, match_season desc, points desc, goals_difference desc





