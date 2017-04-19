data = LOAD 'game/ge/gamelogs/ks/20170412/185/AcitvityStatistics_2017-04-12-0.1154130324.log' USING PigStorage(',','-tagPath');
-- A = FOREACH data GENERATE COUNT(TOBAG(*));
A = FOREACH data GENERATE 
  REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/AcitvityStatistics.*', 1) as server_id,
  $1 as activity_name,
  $2 as n1,
  $3 as server_id_1,
  $4 as role_id,
  $5 as n2,
  $6 as z1,
  $7 as n3,
  REGEX_EXTRACT($8, '.*T0=(.*) T1.*', 1) as log_date;
A = FOREACH A GENERATE 
  ToString(ToDate(log_date,'yyyy-MM-dd_HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'), 
  server_id, activity_name, role_id, n1, n2 , n3;
  
DUMP A;
