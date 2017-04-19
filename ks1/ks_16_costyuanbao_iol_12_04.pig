data = LOAD 'game/ge/gamelogs/ks/20170412/185/yuanbao_2017-04-12-0.1154130324.log' USING PigStorage(',','-tagPath');
A = FILTER data BY ($1 MATCHES 'IOL:\\w*');
A = FOREACH A GENERATE 
  REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/yuanbao.*', 1) as server_id,
  FLATTEN(STRSPLIT($1, ':', 2)) as (log_type,server_id_1),
  $2 as channel_id,
  $3 as n1,
  $4 as item_id,
  $5 as n2,
  $6 as role_id,
  $7 as role_id_partner,
  $8 as n3,
  $9 as n4,
  $10 as n5,
  $11 as scene_id,
  $12 as shop_id,
  $13 as x_pos,
  $14 as z_pos,
  $15 as n7,
  $16 as n8,
  $17 as n9,
  $18 as n10,
  $19 as n11,
  $20 as n12,
  $21 as n13,
  $22 as n14,
  $23 as n15,
  $24 as n16,
  FLATTEN(STRSPLIT($25, '=', 2)) as (z1,param0),
  FLATTEN(STRSPLIT($26, '=', 2)) as (z2,param1),
  FLATTEN(STRSPLIT($27, '=', 2)) as (z3,param2),
  FLATTEN(REGEX_EXTRACT_ALL($28, 'Bind=(.*) \\(.*T0=(.*) T1.*')) as (bind,log_date);
A = FOREACH A GENERATE 
  ToString(ToDate(log_date,'yyyy-MM-dd_HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'), 
  log_type, shop_id, server_id, role_id, item_id, 
  n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, param0, param1, param2, bind;

  -- IOL:0,12124417,229072472,30501036,1,0X00B902016E44F904,0X00B902016E44F663,235,0,-1,0,-1,328.14,290.74,-1,0,0,0,0,0,0,0,0,0,Param0=400,Param1=0,Param2=0,Bind=0 (-1200867008)(T0=2017-4-12_8:15:19 T1=598139.7120)
DUMP A;