data = LOAD 'game/ge/gamelogs/ks/20170412/185/LoginCacheLog_2017-04-12-0.1155046881.log' USING PigStorage('\n', '-tagPath');

pbi = FILTER data BY ($1 MATCHES '.*\\.\\.\\.\\.\\. GUID =(\\w*),  Name =(\\w*)(  BGID\\[\\d*\\] =\\d*  BGType\\[\\d*\\] =\\d*  BGCnt\\[\\d*\\] =\\d*)+ OK .*\\(T0=(.*)T1.*');
pbi = FOREACH pbi GENERATE 
  REGEX_EXTRACT($0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/LoginCacheLog.*', 1), 
  FLATTEN(REGEX_EXTRACT_ALL($1, '(.*)\\.\\.\\.\\.\\. GUID =(\\w*),  Name =(\\w*)  (.*) \\(.*\\(T0=(.*) T1.*'));
----------- ATTENTION: BE CAREFUL WITH REGEX EXTRACT WORD OK NEAR THE END... ---------------------
----------- ATTENTION: BE CAREFUL WITH REGEX EXTRACT WORD OK NEAR THE END... ---------------------
----------- ATTENTION: BE CAREFUL WITH REGEX EXTRACT WORD OK NEAR THE END... ---------------------
----------- ATTENTION: BE CAREFUL WITH REGEX EXTRACT WORD OK NEAR THE END... ---------------------
----------- ATTENTION: BE CAREFUL WITH REGEX EXTRACT WORD OK NEAR THE END... ---------------------
----------- ATTENTION: BE CAREFUL WITH REGEX EXTRACT WORD OK NEAR THE END... ---------------------
pbi = FOREACH pbi GENERATE 
  $0,$1,$2,$3,REPLACE($4, 'BGID', '\t'),ToDate($5, 'yyyy-MM-dd_HH:mm:ss');
pbi = FOREACH pbi GENERATE 
  $0,$1,$2,$3,FLATTEN(TOKENIZE($4,'\t')),$5;
pbi = FOREACH pbi GENERATE 
  $0,$1,$2,$3,
  FLATTEN(REGEX_EXTRACT_ALL($4, '\\[\\d*\\] =(\\d*)  BGType\\[\\d*\\] =(\\d*)  BGCnt\\[\\d*\\] =(\\d*).*')),
  $5;
pbi = FOREACH pbi GENERATE 
  ToString($7, 'yyyy-MM-dd HH:mm:ss'),$0,$2,$3,$4,$5,$6,$1;

-- STORE pbi INTO 'game/output/ks_03_pbi' USING PigStorage(',');



own = FILTER data BY($1 MATCHES '.* =(\\w*), OwnerName =(\\w*) (BKID\\[\\d*\\] =\\d*  BKType\\[\\d*\\] =\\d*  BKCnt\\[\\d*\\] =\\d*  )+.*\\(T0=(.*)T1.*'); 
own = FOREACH own GENERATE 
  REGEX_EXTRACT($0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/LoginCacheLog.*', 1), 
  FLATTEN(REGEX_EXTRACT_ALL($1, '(.*) =(\\w*), OwnerName =(\\w*) (.*) \\(.*\\(T0=(.*) T1.*'));
own = FOREACH own GENERATE 
  $0,$1,$2,$3,REPLACE($4, 'BKID', '\t'),ToDate($5, 'yyyy-MM-dd_HH:mm:ss');
own = FOREACH own GENERATE 
  $0,$1,$2,$3,FLATTEN(TOKENIZE($4,'\t')),$5;
own = FOREACH own GENERATE 
  $0,$1,$2,$3,
  FLATTEN(REGEX_EXTRACT_ALL($4, '\\[\\d*\\] =(\\d*)  BKType\\[\\d*\\] =(\\d*)  BKCnt\\[\\d*\\] =(\\d*).*')),
  $5;
own = FOREACH own GENERATE 
  ToString($7, 'yyyy-MM-dd HH:mm:ss'),$0,$2,$3,$4,$5,$6,$1;

result = UNION pbi,own;
DUMP pbi;

-- PlayerBagInfo\.\.\.\.\. GUID =(\w*),  Name =(\w*)(  BGID\[\d*\] =\d*  BGType\[\d*\] =\d*  BGCnt\[\d*\] =\d*)+
-- PlayerBagInfo..... GUID =0X00B902016E451779,  Name =ThienL0ng  BGID[0] =223023812  BGType[0] =38001206  BGCnt[0] =200