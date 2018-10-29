
# Project Overview

I have received a scholarship offerred by Bertelsmann and Udacity and this project is the third one in the Data Analysis Nanodegree. In this project, I will analyze a dataset and then communicate my findings about it. I will use the Python libraries NumPy, pandas, and Matplotlib to make my analysis easier.

## Dataset: [Soccer Database](https://d17h27t6h515a5.cloudfront.net/topher/2017/November/5a0a4cad_database/database.sqlite) (original source on [Kaggle](https://www.kaggle.com/hugomathien/soccer))

This soccer database comes from Kaggle and is well suited for data analysis and machine learning. It contains data for soccer matches, players, and teams from several European countries from 2008 to 2016. This dataset is quite extensive, and we encourage you to read more about it [here](https://www.kaggle.com/hugomathien/soccer).

## What will you learn?

After completing the project, you will:

  - Know all the steps involved in a typical data analysis process
  - Be comfortable posing questions that can be answered with a given dataset and then answering those questions
  - Know how to investigate problems in a dataset and wrangle the data into a format you can use
  - Have experience communicating the results of your analysis
  - Be able to use vectorized operations in NumPy and pandas to speed up your data analysis code
  - Be familiar with pandas' Series and DataFrame objects, which let you access your data more conveniently
  - Know how to use Matplotlib to produce plots showing your findings

## Introduction

In this project I will be analyzing data associated with matches and teams for European Professional Football from 2008 to 2016. In particular, I am interested in finding the top five and last three teams per country and share their performance. 

The database columns:

    - Name of the country: `country`
    - Name of the league: `league`
    - Years of the season: `match_season`.
    
From the database I had the information about each  match from league and the number of goals each team gave. You can download the SQL script I used for this analysis from the **Resources** link or from <a href="matches.sql">here</a>. Therefore,  I calculated for each team per match season: 

    - the total number of game played: `game_played`;
    - total number of points: `points`;
    - how many games they won: `won`;
    - how many games ended up with a tie: `draw`;
    - how many games they lost: `lost`;
    - the number of goals they scored: `goals_scored`;
    - the number of goals they received: `goals_conceded`;
    - and the difference between the number of goals they scored and they received: `goals difference`.  
    
## Questions

Fist, I have to mention that I also visualised data for the last three teams for later analysis. But for now I will deal only with top five performers. Second, I used case studies for each part: Belgium and Italy.

**Q1:** I have a main question to answer: “What teams improved the most over the time period?”. I am interested in the top five teams for each match season for each country. 
In order to answer this main question I have to first find the top five teams per country per match season and visualize in a bar chart the number of points and goals difference for each team. For that reason, I have to answer another question.

**Q2:** Which are the top five teams or top performers over the years, per country?

In order to answer this question I followed the next steps:

    1. I filtered the data by country.
    2. I got the data for top five teams.
    3. I visualized the data with a bar chart for both number of points and goal difference.

In order to answer my main question I used all the top five teams over and plotted their number of points over the years per country. I followed these steps:

    1. I got the the top five teams per country;
    2. I got the data for the top five teams per country: number of points and match season;
    3. I plotted the line for each team per country;
    4. To be able to compare how they performed I plotted a line chart with all top five teams. 

**Resources:**
1. SQL Query: <a href="matches.sql">Here</a>
1. Dataset: [here](https://www.kaggle.com/hugomathien/soccer)
2. Stats Tables: [here](https://www.fctables.com/belgium/jupiler-league/2008_2009/)
3. Premier League Tables: [here](https://www.premierleague.com/tables?co=1&se=79&ha=-1)
