data = LOAD 'game/ge/gamelogs/ks/20170412/dbdata/store_20170412.log' USING PigStorage(',','-tagPath');
A = FOREACH data GENERATE COUNT(TOBAG(*)),$0..$11;
A = FILTER A BY $0 == 12;
A = FOREACH A GENERATE 
  REGEX_EXTRACT((chararray)$1, '/ge/gamelogs/ks/(\\d{8})/dbdata/store.*', 1) as t_folder_name,
  FLATTEN(REGEX_EXTRACT_ALL($2, '\\[(.*)\\] (\\w*)')) as (action_time,buy_id),
  $3 as store_id,
  $4 as account_name,
  $5 as client_ip,
  $6 as server_id,
  $7 as silver_operation,
  $8 as silver_remain,
  FLATTEN(STRSPLIT($9, '=', 2)) as (z1,action_type),
  $10 as yuanbao_remain,
  $11 as position,
  REPLACE($12, ';', '') as silver_consumption;
A = FOREACH A GENERATE 
  ToString(ToDate(CONCAT(t_folder_name,' ', action_time),'yyyyMMdd HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'), 
  buy_id, store_id, account_name ,client_ip, server_id, 
  silver_consumption, silver_remain, action_type, yuanbao_remain, position;

dump A;