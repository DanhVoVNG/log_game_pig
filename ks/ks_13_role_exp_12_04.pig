data = LOAD 'game/ge/gamelogs/ks/20170412/185/Exp_2017-04-12-0.1154130324.log' USING PigStorage(',','-tagPath');
A = FILTER data BY ($1 MATCHES 'EOL:\\w*');
A = FOREACH A GENERATE 
  REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/Exp.*', 1) as z_server_id,
  FLATTEN(STRSPLIT($1, ':', 2)) as (z1,role_id),
  $2 as action_type,
  $3 as current_exp,
  $4 as change_exp,
  $5 as scene_id,
  $6 as x_pos,
  $7 as z_pos,
  $8 as n_1,
  FLATTEN(REGEX_EXTRACT_ALL($9, '(\\w*) .*T0=(.*) T1.*')) as (server_id,log_date);

A = FOREACH A GENERATE 
  ToString(ToDate(log_date,'yyyy-MM-dd_HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'), 
  role_id, action_type, current_exp, change_exp, server_id;

  -- $9 as server_id,

  
-- A = FOREACH data GENERATE $1;
DUMP A;