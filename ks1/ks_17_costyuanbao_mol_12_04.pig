data = LOAD 'game/ge/gamelogs/ks/20170412/185/yuanbao_2017-04-12-0.1154130324.log' USING PigStorage(',','-tagPath');
A = FILTER data BY ($1 MATCHES 'MOL:\\w*');
A = FOREACH A GENERATE 
  REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/yuanbao.*', 1) as server_id,
  FLATTEN(STRSPLIT($1, ':', 2)) as (log_type,role_id),
  $2 as role_id_partner,
  $3 as action_type,
  $4 as amount,
  $5 as scene_id,
  $6 as x_pos,
  $7 as z_pos,
  $8 as transaction_id,
  $9 as more_info,
  $10 as money_before,
  $11 as money_after,
  $12 as role_level,
  FLATTEN(REGEX_EXTRACT_ALL($13, '(\\w*) .*T0=(.*) T1.*')) as (server_id_1,log_date);

-- be careful with item_id
A = FOREACH A GENERATE 
  ToString(ToDate(log_date,'yyyy-MM-dd_HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'), 
  log_type, transaction_id, server_id, role_id, role_id_partner, 
  action_type,amount, money_before, money_after;

dump A;