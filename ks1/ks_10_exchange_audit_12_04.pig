data = LOAD 'game/ge/gamelogs/ks/20170412/185/exchange_2017-04-12-0.1155046901.log' USING PigStorage(',','-tagPath');
A = FILTER data BY ($1 MATCHES '<ITEM>.*');
A = FOREACH A GENERATE COUNT(TOBAG(*)),(chararray)$0,(chararray)$1,(chararray)$2,
                      (chararray)$3,(chararray)$4,(chararray)$5,(chararray)$6;

--careful with DestItemGuid
A1 = FILTER A BY $0==7;
A1 = FOREACH A1 GENERATE 
  REGEX_EXTRACT((chararray)$1, 'ge/gamelogs/ks/\\d{8}/(\\d*)/exchange.*', 1) as server_id,
  FLATTEN(REGEX_EXTRACT_ALL((chararray)$2, '<ITEM> \\[(\\w*)\\] ObjGUID:(.*)')) as (log_type,role_id),
  TRIM($3) as description_1,
  FLATTEN(STRSPLIT($4, ':', 2)) as (z1,description_2),
  FLATTEN(STRSPLIT($6, ':', 2)) as (z2,index_1),
  FLATTEN(REGEX_EXTRACT_ALL($7, ' DestIndex:(\\d*) .*T0=(.*) T1.*')) as (index_2,log_date);


A1 = FOREACH A1 GENERATE 
  ToString(ToDate(log_date,'yyyy-MM-dd_HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'), 
  log_type, server_id, role_id , description_1 , description_2 ,
  index_1 , index_2;

--------------------------------------group2---------------------
A2 = FILTER A BY $0==6;
A2 = FOREACH A2 GENERATE 
  REGEX_EXTRACT((chararray)$1, 'ge/gamelogs/ks/\\d{8}/(\\d*)/exchange.*', 1) as server_id,
  FLATTEN(REGEX_EXTRACT_ALL((chararray)$2, '<ITEM> \\[(\\w*)\\] ObjGUID:(.*)')) as (log_type,role_id),
  TRIM($3) as description_1,
  FLATTEN(STRSPLIT($4, ':', 2)) as (z1,description_2),
  FLATTEN(STRSPLIT($5, ':', 2)) as (z2,index_1),
  FLATTEN(REGEX_EXTRACT_ALL($6, ' DestIndex:(\\d*) .*T0=(.*) T1.*')) as (index_2,log_date);
A2 = FOREACH A2 GENERATE 
  ToString(ToDate(log_date,'yyyy-MM-dd_HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'), 
  log_type, server_id, role_id , description_1 , description_2 ,
  index_1 , index_2;

--------------------------------------group3---------------------
A3 = FILTER A by $0==4;
A3 = FOREACH A3 GENERATE
  REGEX_EXTRACT((chararray)$1, 'ge/gamelogs/ks/\\d{8}/(\\d*)/exchange.*', 1) as server_id,
  FLATTEN(REGEX_EXTRACT_ALL((chararray)$2, '<ITEM> \\[(\\w*)\\] ObjGUID:(.*)')) as (log_type,role_id),
  FLATTEN(STRSPLIT($3, ':', 2)) as (z1,description_1),
  FLATTEN(REGEX_EXTRACT_ALL($4, ' ItemGuid:(.*) .*T0=(.*) T1.*')) as (description_2,log_date);
A3 = FOREACH A3 GENERATE 
  ToString(ToDate(log_date,'yyyy-MM-dd_HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'), 
  log_type, server_id, role_id , description_1 , description_2;


result = UNION A1,A2,A3;
DUMP result; 


-- (7,file:/home/DanhVo/Pig_Data/game/ge/gamelogs/ks/20170412/185/exchange_2017-04-12-0.1155046901.log,<ITEM> [COPY] ObjGUID:0X00B902016E4511AA, Packet->Exchange Panel, 
-- SourceItemGuid:world(0)server(12124417)serial(229184389)itemindex(30501021)num(1), DestItemGuid:world(0)server(12124417)serial(229184389)itemindex(30501021)num(1),
 -- SourceIndex:12, DestIndex:4 (-821974719)(T0=2017-4-12_23:48:4 T1=49930.9080))
