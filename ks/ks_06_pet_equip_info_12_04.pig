data = LOAD 'game/ge/gamelogs/ks/20170412/185/LoginCacheLog_2017-04-12-0.1155046881.log' USING PigStorage('\n', '-tagPath');
A = FILTER data BY ($1 MATCHES 'Pet\\[\\d*\\]EquipInfo\\.\\.\\.\\.\\. OwnerGUID =.*');
A = FOREACH A GENERATE 
  REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/LoginCacheLog.*', 1),
  FLATTEN(REGEX_EXTRACT_ALL($1, 'Pet\\[(\\d*)\\]EquipInfo\\.\\.\\.\\.\\. (.*) OK.*T0=(.*) T1.*'));
A = FOREACH A GENERATE 
  $0,$1,REPLACE($2, 'OwnerGUID', '\t'),$3;

A = FOREACH A GENERATE 
  $0,$1,FLATTEN(TOKENIZE($2,'\t')),$3;

A = FOREACH A GENERATE 
  $0,$1,FLATTEN(STRSPLIT($2, ' =')),$3;

A = FOREACH A GENERATE 
  $0,$1,FLATTEN(STRSPLIT($3, ' ')),
  FLATTEN(STRSPLIT($4, '  ')),
  FLATTEN(STRSPLIT($5, '  ')),
  FLATTEN(STRSPLIT($6, ' ')),
  FLATTEN(STRSPLIT($7, ' ')),
  FLATTEN(STRSPLIT($8, '  ')),
  FLATTEN(STRSPLIT($9, '  ')),
  FLATTEN(STRSPLIT($10, '  ')),
  FLATTEN(STRSPLIT($11, '  ')),
  FLATTEN(STRSPLIT($12, '  ')),
  FLATTEN(STRSPLIT($13, '  ')),
  FLATTEN(STRSPLIT($14, '  ')),
  $15,$16
  ;

A = FOREACH A GENERATE 
  $0 as server_id,
  $1 as pet_index,
  $2 as role_id,
  $4 as role_name,
  $6 as pet_id,
  $8 as pet_h_id,
  $10 as pet_l_id,
  $12 as pet_name,
  $14 as pet_eid,
  $16 as pet_etype,
  $18 as pet_enhance_lv,
  $20 as pet_ident,
  $22 as pet_star_rank,
  $24 as pet_hole,
  $26 as pet_gem_info,
  $27 as log_date;

A = FOREACH A GENERATE 
  ToString(ToDate(log_date,'yyyy-MM-dd_HH:mm:ss'),'yyyy-MM-dd HH:mm:ss'),
  role_id, role_name, pet_id, pet_name, pet_index, pet_h_id, pet_l_id,
  pet_eid, pet_etype, pet_enhance_lv, pet_ident, pet_star_rank, 
  REGEX_EXTRACT(pet_hole, '\\((.*)\\)',1),
  REGEX_EXTRACT(pet_gem_info, '\\((.*)\\)',1), server_id;

DUMP A;