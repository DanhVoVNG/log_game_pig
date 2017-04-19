data = LOAD 'game/ge/gamelogs/ks/20170412/185/LoginCacheLog_2017-04-12-0.1155046881.log' USING PigStorage(',', '-tagPath');
A = FILTER data BY ($1 MATCHES 'PlayerBaseInfo\\.\\.\\.\\.\\..*');
A = FOREACH A GENERATE
  REGEX_EXTRACT($0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/LoginCacheLog.*', 1), 
  REGEX_EXTRACT($1, 'PlayerBaseInfo\\.\\.\\.\\.\\. GUID =(\\w*)', 1),
  REGEX_EXTRACT($2, ' Name =(\\w*)', 1),
  REGEX_EXTRACT($3, ' AccName =(\\w*)', 1),
  REGEX_EXTRACT($4, ' Level =(\\w*)', 1),
  REGEX_EXTRACT($5, ' Sex =(\\w*)', 1),
  REGEX_EXTRACT($6, ' Menpai =(\\w*)', 1),
  REGEX_EXTRACT($7, ' Money =(\\w*)', 1),
  REGEX_EXTRACT($8, ' YuanBao =(\\w*)', 1),
  REGEX_EXTRACT($9, ' ZengDian =(\\w*)', 1),
  REGEX_EXTRACT($10, ' ShouLanCount =(\\w*)', 1),
  REGEX_EXTRACT($11, ' HP =(\\w*)', 1),
  REGEX_EXTRACT($12, ' MP =(\\w*)', 1),
  REGEX_EXTRACT($13, ' Rage =(\\w*)', 1),
  REGEX_EXTRACT($14, ' LeftPoint =(\\w*)', 1),
  REGEX_EXTRACT($15, ' Vigor =\\((.*)\\)', 1),
  REGEX_EXTRACT($16, ' Energy =\\((.*)\\)', 1),
  REGEX_EXTRACT($17, ' Exp =(\\w*)', 1),
  REGEX_EXTRACT($18, ' DoubleExp =\\(luoyang=(\\w*)', 1),
  REGEX_EXTRACT($19, 'city=(\\w*)', 1),
  REGEX_EXTRACT($20, 'other=(\\w*)\\)', 1),
  REGEX_EXTRACT($21, ' GoodBadValue =(\\w*)', 1),
  REGEX_EXTRACT($22, ' PKValue =(\\w*)', 1),
  REGEX_EXTRACT($23, ' KillCaoYun =(\\w*)', 1),
  REGEX_EXTRACT($24, ' MenPaiPoint =(\\w*)', 1),
  REGEX_EXTRACT($25, ' GuildPoint =(\\w*)', 1),
  FLATTEN(REGEX_EXTRACT_ALL($26, ' JuQingPoint =(\\w*) OK .*T0=(.*) T1.*'));
A = FOREACH A GENERATE 
  ToString(ToDate($27,'yyyy-MM-dd_HH:mm:ss'),'yyyy-MM-dd HH:mm:ss'),$3,$2,$1,$4,$5,$24,$17,$7,$8,
  $9,$10,$11,$12,$13,$14,$15,$16,$21,$22,$23,$25,$26,$0;
DUMP A;