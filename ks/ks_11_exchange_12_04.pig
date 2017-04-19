data = LOAD 'game/ge/gamelogs/ks/20170412/185/exchange_2017-04-12-0.1155046901.log' USING PigStorage(',','-tagPath');
A = FILTER data BY ($1 MATCHES 'EXCHANGE:\\d*');
A = FOREACH A GENERATE 
  REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/exchange.*', 1) as server_id,
  $3 as item_id,
  $7 as item_name,
  $8 as quantity,
  $9 as account_name_1,
  $10 as role_name_1,
  $11 as role_id_1,
  $12 as client_ip_1,
  $13 as account_name_2,
  $14 as role_name_2,
  $15 as role_id_2,
  $16 as client_ip_2,
  $17 as item_value,
  REGEX_EXTRACT($39, '.*T0=(.*) T1.*', 1) as log_date;

A = FOREACH A GENERATE 
  ToString(ToDate(log_date,'yyyy-MM-dd_HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'), 
  server_id, account_name_1 , role_name_1 , role_id_1 , client_ip_1 , 
  account_name_2 , role_name_2 , role_id_2 , client_ip_2 , item_id , item_name , 
  quantity, item_value;
DUMP A;