data = LOAD 'game/ge/gamelogs/ks/20170412/185/AcitvityPrize_2017-04-12-0.1155046901.log' USING PigStorage(',','-tagPath');
A = FOREACH data GENERATE COUNT(TOBAG(*)),$0..$24;
A = FILTER A by $0==25;
A = FOREACH A GENERATE 
  REGEX_EXTRACT((chararray)$1, '/ge/gamelogs/ks/\\d{8}/(\\d*)/AcitvityPrize.*', 1) as server_id,
  $2 as activity_name,
  $3 as item_id_1,
  $4 as quantity_1,
  $5 as item_id_2,
  $6 as quantity_2,
  $7 as item_id_3,
  $8 as quantity_3,
  $9 as item_id_4,
  $10 as quantity_4,
  $11 as item_id_5,
  $12 as quantity_5,
  $13 as item_id_6,
  $14 as quantity_6,
  $15 as item_id_7,
  $16 as quantity_7,
  $17 as item_id_8,
  $18 as quantity_8,
  $19 as item_id_9,
  $20 as quantity_9,
  $21 as role_id,
  $22 as role_level,
  $23 as z1,
  $24 as server_id_1,
  REGEX_EXTRACT($25, '.*T0=(.*) T1.*', 1) as log_date;
A = FOREACH A GENERATE 
  ToString(ToDate(log_date,'yyyy-MM-dd_HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'), 
  server_id, role_id, role_level, activity_name, item_id_1, quantity_1, item_id_2, 
  quantity_2, item_id_3, quantity_3, item_id_4, quantity_4, item_id_5, quantity_5, item_id_6, 
  quantity_6, item_id_7, quantity_7, item_id_8, quantity_8, item_id_9, quantity_9;

DUMP A