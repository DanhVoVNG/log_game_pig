data = LOAD 'game/ge/gamelogs/ks/20170412/ServerList.csv' USING PigStorage(',','-tagPath');
A = FOREACH data GENERATE 
  REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/(\\d{8})/ServerList\\.csv', 1) as t_folder_name,
  $1 as server_id_1,
  $2 as server_id_2,
  $3 as server_name,
  $4 as game_type,
  $5 as update_date,
  $6 as status,
  $7 as server_ip_1,
  $8 as server_ip_2,
  $9 as server_ip_3,
  $10 as server_id_3;
A = FOREACH A GENERATE 
  ToDate(update_date,'yyyy-MM-dd'),
  server_id_1, server_name, game_type, 
  ToDate(update_date,'yyyy-MM-dd'),
  status,'';

DUMP A;