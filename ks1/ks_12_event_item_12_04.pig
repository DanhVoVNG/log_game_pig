data = LOAD 'game/ge/gamelogs/ks/20170412/185/item_2017-04-12-0.1154130324.log' USING PigStorage('\n','-tagPath');
A = FOREACH data GENERATE 
  REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/item.*', 1) as server_id,
  FLATTEN(STRSPLIT($1, ',', 17));
A = FOREACH A GENERATE
  $0,$1..$16,
  FLATTEN(REGEX_EXTRACT_ALL($17, '(.*) \\(.*\\)\\(T0=(.*) T1.*'))
  ;
A = FOREACH A GENERATE 
  $0 as server_id,
  FLATTEN(STRSPLIT($1, ':',2)) as (z1,server_id_1),
  $2 as chanel_id,
  $4 as item_id,
  $6 as role_id_1,
  $7 as role_id_2,
  $8 as action_id,
  $11 as scence_id,
  $12 as shop_id,
  $13 as x_pos,
  $14 as z_pos,
  $15 as do_ben,
  $16 as so_lo_kham,
  $17 as description,
  $18 as log_date;
A = FOREACH A GENERATE 
  ToString(ToDate(log_date,'yyyy-MM-dd_HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'), 
  server_id, role_id_1, role_id_2, action_id, item_id, scence_id, shop_id, 
  x_pos, z_pos, do_ben, so_lo_kham, description;
DUMP A;