UPDATE pitch_arsenal_stats.`sinkers_2025`
SET Last_Name = 'Rodríguez' 
WHERE ID = '677594';

CREATE TABLE Master_Table
(
SELECT 
	First_Name, 
    Last_Name,
    ID,
    Team_Name,
    Pitch_Type,
    Run_Value,
    xBA,
    xSLG,
    wOBA,
    xwOBA,
    Hard_Hit_Percent AS "Hard_Hit_Percentage",
    Whiff_Percent AS "Whiff_Percentage",
    K_Percent AS "K_Percentage",
    Pitches AS "Total_Pitches",
    Pitch_Usage AS "Percentage_Use"
FROM pitch_arsenal_stats.`fastballs_2025`
UNION ALL
SELECT 
	First_Name, 
    Last_Name,
    ID,
    Team_Name,
    Pitch_Type,
    Run_Value,
    xBA,
    xSLG,
    wOBA,
    xwOBA,
    Hard_Hit_Percent AS "Hard_Hit_Percentage",
    Whiff_Percent AS "Whiff_Percentage",
    K_Percent AS "K_Percentage",
    Pitches AS "Total_Pitches",
    Pitch_Usage AS "Percentage_Use"
FROM pitch_arsenal_stats.`sinkers_2025`
ORDER BY Last_Name ASC
);

CREATE TABLE Master_Table_Updated (
SELECT 
	MT.First_Name,
    MT.Last_Name,
    MT.ID,
    MT.Team_Name,
    MT.Pitch_Type,
    MT.Run_Value,
    MT.Total_Pitches,
    MT.Percentage_Use,
    MT.xBA,
    MT.xSLG,
    MT.wOBA,
    MT.xwOBA,
    MT.Hard_Hit_Percentage,
    MT.Whiff_Percentage,
    MT.K_Percentage,
    BT.Avg_Bat_Speed,
    BT.Hard_Swing_Rate AS "Hard_Swing_Percentage",
    BT.Swing_Length,
    ROUND(IP.swing_tilt, 1) AS "Swing_Tilt",
    ROUND(IP.attack_angle, 1) AS "Attack_Angle",
    ROUND(IP.attack_direction, 1) AS "Attack_Direction",
    ROUND(IP.avg_intercept_y_vs_batter, 1) AS "Contact_Point_vs_Batter",
    ROUND((AAP.ideal_attack_angle_rate*100), 1) AS "Ideal_Attack_Angle_Percentage"
FROM Master_Table AS MT
INNER JOIN bat_tracking.`bat_tracking_metrics_2025` AS BT
ON MT.ID = BT.ID
INNER JOIN bat_tracking.`intercept_point_2025` AS IP
ON MT.ID = IP.id
INNER JOIN bat_tracking.`attack_angle_percentage` AS AAP
ON MT.ID = AAP.id
);

SELECT *
FROM Master_Table_Updated;

CREATE TABLE Master_Table_2026
(
SELECT 
	First_Name, 
    Last_Name,
    player_id AS "ID",
    team_name_alt AS "Team_Name",
    Pitch_Type,
    Run_Value,
    est_ba AS "xBA",
    est_slg AS "xSLG",
    wOBA,
    est_woba AS "xWOBA",
    Hard_Hit_Percent AS "Hard_Hit_Percentage",
    Whiff_Percent AS "Whiff_Percentage",
    K_Percent AS "K_Percentage",
    Pitches AS "Total_Pitches",
    Pitch_Usage AS "Percentage_Use"
FROM pitch_arsenal_stats.`fastballs_2026`
UNION ALL
SELECT 
	First_Name, 
    Last_Name,
    player_id AS "ID",
    team_name_alt AS "Team_Name",
    Pitch_Type,
    Run_Value,
    est_ba AS "xBA",
    est_slg AS "xSLG",
    wOBA,
    est_woba AS "xWOBA",
    Hard_Hit_Percent AS "Hard_Hit_Percentage",
    Whiff_Percent AS "Whiff_Percentage",
    K_Percent AS "K_Percentage",
    Pitches AS "Total_Pitches",
    Pitch_Usage AS "Percentage_Use"
FROM pitch_arsenal_stats.`sinkers_2026`
ORDER BY Last_Name ASC
);

SELECT *
FROM Master_Table_2026;

CREATE TABLE Master_Table_Updated_2026 (
SELECT 
	MT.First_Name,
    MT.Last_Name,
    MT.ID,
    MT.Team_Name,
    MT.Pitch_Type,
    MT.Run_Value,
    MT.Total_Pitches,
    MT.Percentage_Use,
    MT.xBA,
    MT.xSLG,
    MT.wOBA,
    MT.xwOBA,
    MT.Hard_Hit_Percentage,
    MT.Whiff_Percentage,
    MT.K_Percentage,
    BT.Avg_Bat_Speed,
    BT.Hard_Swing_Rate AS "Hard_Swing_Percentage",
    BT.Swing_Length,
    ROUND(IP.swing_tilt, 1) AS "Swing_Tilt",
    ROUND(IP.attack_angle, 1) AS "Attack_Angle",
    ROUND(IP.attack_direction, 1) AS "Attack_Direction",
    ROUND(IP.avg_intercept_y_vs_batter, 1) AS "Contact_Point_vs_Batter",
    ROUND((IP.ideal_attack_angle_rate*100), 1) AS "Ideal_Attack_Angle_Percentage"
FROM Master_Table AS MT
INNER JOIN bat_tracking.`bat_tracking_2026` AS BT
ON MT.ID = BT.ID
INNER JOIN bat_tracking.`intercept_point_2026` AS IP
ON MT.ID = IP.id
);

SELECT *
FROM Master_Table_Updated_2026;

SELECT *
FROM Master_Table_Updated_2026
WHERE Attack_Angle > 15 AND Swing_Length > 7.5 AND wOBA < 0.350;