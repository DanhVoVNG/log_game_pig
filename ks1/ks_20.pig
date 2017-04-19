data = LOAD 'game/ge/gamelogs/ks/20170412/185/chat_2017-04-12-0.1155046901.log' USING PigStorage('\n','-tagPath');

--part 1
A1 = FILTER data BY ($1 MATCHES 'CGChatHandler:GUID=.*');
A1 = FOREACH A1 GENERATE 
  REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/chat.*', 1) as server_id,
  FLATTEN(STRSPLIT($1, ',', 14));
-- A1 = FOREACH A1 GENERATE $14;
A1 = FOREACH A1 GENERATE 
  REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/chat.*', 1) as server_id,
  FLATTEN(STRSPLIT($1, '=', 2)) as (z1,role_id_1),
  FLATTEN(STRSPLIT($2, '=', 2)) as (z2,chat_type),
  FLATTEN(STRSPLIT($3, '=', 2)) as (z3,IsGM),
  FLATTEN(STRSPLIT($4, '=', 2)) as (z4,tar_name),
  FLATTEN(STRSPLIT($5, '=', 2)) as (z5,team_id),
  FLATTEN(STRSPLIT($6, '=', 2)) as (z6,channel_id),
  FLATTEN(STRSPLIT($7, '=', 2)) as (z7,guild_id),
  FLATTEN(STRSPLIT($8, '=', 2)) as (z8,Sceneid),
  FLATTEN(STRSPLIT($9, '=', 2)) as (z9,vip),
  FLATTEN(STRSPLIT($10, '=', 2)) as (z10,level),
  FLATTEN(STRSPLIT($11, '=', 2)) as (z11,bscore),
  FLATTEN(STRSPLIT($12, '=', 2)) as (z12,posx),
  FLATTEN(STRSPLIT($13, '=', 2)) as (z13,posz),
  (chararray)$14 as boss;

DUMP  A1;





-- A1 = FILTER data BY ($1 MATCHES 'CGChatHandler:GUID=.*');
-- A1 = FOREACH A1 GENERATE 
--   REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/chat.*', 1) as server_id,
--   FLATTEN(STRSPLIT($1, ',', 3)) ;
-- A1 = FOREACH A1 GENERATE (chararray)$1,(chararray)$2,(chararray)$3;
-- Dump A1;
