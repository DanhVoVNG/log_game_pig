data = LOAD 'game/ge/gamelogs/ks/20170412/185/LoginCacheLog_2017-04-12-0.1155046881.log' USING PigStorage('\n', '-tagPath');
A = FILTER data BY (chararray)$1 MATCHES 'PlayerEquipInfo\\.\\.\\.\\.\\..*';
A = FOREACH A GENERATE
  REGEX_EXTRACT($0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/LoginCacheLog.*', 1), 
  FLATTEN(REGEX_EXTRACT_ALL($1, 'PlayerEquipInfo\\.\\.\\.\\.\\. GUID =(\\w*),  Name =(\\w*)  (.*) OK.*\\(T0=(.*) T1.*'));
A = FOREACH A GENERATE $0,$1,$2,REPLACE($3, 'EID', '\t'),ToDate($4, 'yyyy-MM-dd_HH:mm:ss');
A = FOREACH A GENERATE $0,$1,$2,FLATTEN(TOKENIZE($3,'\t')),$4;
A = FOREACH A GENERATE $0,$1,$2,FLATTEN(STRSPLIT($3, ' =')),$4;

A = FOREACH A GENERATE COUNT(TOBAG(*)),$0..;

NoDark = FILTER A BY $0==14;
NoDark = FOREACH NoDark GENERATE 
  ToString($14,'yyyy-MM-dd HH:mm:ss'),$1,$2,$3,REGEX_EXTRACT($5, '(\\d*)(  EType\\[\\d*\\])',1),
  REGEX_EXTRACT($6, '(\\d*)(  EnhanceLvl\\[\\d*\\])',1),
  REGEX_EXTRACT($7, '(\\d*)(  Label\\[\\d*\\])',1),
  REGEX_EXTRACT($8, '(\\d*)(  Ident\\[\\d*\\])',1),
  REGEX_EXTRACT($9, '(\\d*)(  StarRank\\[\\d*\\])',1),
  REGEX_EXTRACT($10, '(\\d*)(  Hole\\[\\d*\\])',1),
  REGEX_EXTRACT($11, '\\((.*)\\)(  GemInfo\\[\\d*\\])',1),
  REGEX_EXTRACT($12, '\\((.*)\\)(  DiaoWen\\[\\d*\\])',1),TRIM($13);

Dark = FILTER A BY $0==18;
Dark = FOREACH Dark GENERATE 
  ToString($18,'yyyy-MM-dd HH:mm:ss'),$1,$2,$3,REGEX_EXTRACT($5, '(\\d*)(  EType\\[\\d*\\])',1),
  REGEX_EXTRACT($6, '(\\d*)(  EnhanceLvl\\[\\d*\\])',1),
  REGEX_EXTRACT($7, '(\\d*)(  Label\\[\\d*\\])',1),
  REGEX_EXTRACT($8, '(\\d*)(  Ident\\[\\d*\\])',1),
  REGEX_EXTRACT($9, '(\\d*)(  StarRank\\[\\d*\\])',1),
  REGEX_EXTRACT($10, '(\\d*)(  Hole\\[\\d*\\])',1),
  REGEX_EXTRACT($11, '\\((.*)\\)(  GemInfo\\[\\d*\\])',1),
  REGEX_EXTRACT($12, '\\((.*)\\)(  DarkLevel\\[\\d*\\])',1),
  REGEX_EXTRACT($13, '(\\d*)(  DarkExp\\[\\d*\\])',1),
  REGEX_EXTRACT($14, '(\\d*)(  DarkTimes\\[\\d*\\])',1),
  REGEX_EXTRACT($15, '(\\d*)(  DarkQual\\[\\d*\\])',1),
  REGEX_EXTRACT($16, '(\\d*)(  DiaoWen\\[\\d*\\])',1),TRIM($17);


result = UNION Dark,NoDark;
DUMP result;

-- A = FOREACH A GENERATE COUNT(TOBAG(*));
  -- $0,$1,FLATTEN(REGEX_EXTRACT_ALL
    -- ($2,'\\[\\d*\\] =(\\w*)  EType\\[\\d*\\] =(\\w*)  EnhanceLvl\\[\\d*\\] =(\\w*)  Label\\[\\d*\\] =(\\w*)  Ident\\[\\d*\\] =(\\w*)  StarRank\\[\\d*\\] =(\\w*)  Hole\\[\\d*\\] =(.*)  GemInfo\\[\\d*\\] =(\\(.*\\))(  DarkLevel\\[\\d*\\] =(\\w*))*(  DarkExp\\[\\d*\\] =(\\w*))*(  DarkTimes\\[\\d*\\] =(\\w*))*(  DarkQual\\[\\d*\\] =(\\w*))*  DiaoWen\\[\\d*\\] =(\\w*)  ')),$3;