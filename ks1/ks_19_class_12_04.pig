data = LOAD 'game/ge/gamelogs/ks/20170412/185/Audit_2017-04-12-0.1154130324.log' USING PigStorage(',','-tagPath');
A = FILTER data by $1 MATCHES 'NEWACTIVEPOINT_ATTACH';
A = FOREACH A GENERATE 
  REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/Audit.*', 1) as server_id,
  $2 as role_id,
  FLATTEN(STRSPLIT($3, ':', 2)) as (z1,role_level),
  FLATTEN(STRSPLIT($4, ':', 2)) as (z2,class_id),
  FLATTEN(STRSPLIT($5, ':', 2)) as (z3,active_point),
  FLATTEN(STRSPLIT($6, ':', 2)) as (z4,index),
  FLATTEN(STRSPLIT($7, ':', 2)) as (z5,flag),
  REGEX_EXTRACT($8, '.*T0=(.*) T1.*',1) as log_date;
A = FOREACH A GENERATE 
  ToString(ToDate(log_date,'yyyy-MM-dd_HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'), 
  role_id, role_level, class_id, active_point, index, flag, server_id;
DUMP A;
