data = LOAD 'game/ge/gamelogs/ks/20170412/185/LoginCacheLog_2017-04-12-0.1155046881.log' USING PigStorage('\n', '-tagPath');
-- A = FOREACH data GENERATE $1;

-- (185,Pet[4]: OwnerGUID,0X00B902016E44D46F OwnerName,Brother PHGUID[3],B90101 PLGUID[3],
--   18E2F0  PSHGUID[3],0 PSLGUID[3],0  MID[3],3349  PName[3],Giao Long B�o B�o  NName[3],  
--   PLevel[3],1  TLevel[3],95  PType[3],0  PJinJieLevel[3],0, PJinJieExp[3],0  GRate[3],
--   1.604000  PSavvy[3],0  PFitValue[3],0  GenGu[3],0  PETHuanHua[3],0  PETLXValue[3],0  �Ա�[3],
--   ��  �Ը�[3],��С  ��ǰ�ƺ�[3],-1  ���ֶ�[3],100  ����[3],98563  ����[3],0  ����״̬[3],0  Skill01[3],
--   -1  Skill02[3],-1  Skill03[3],653  Skill04[3],-1  Skill05[3],-1  Skill06[3],-1  Skill07[3],
--   -1  Skill08[3],-1  Skill09[3],-1  Skill10[3],-1  Skill11[3],-1  Skill12[3],-1  Skill13[3],
--   -1 (-1977807920)(T0=2017-4-12_23:59:38 T1=50644.2720)
A = FILTER data BY ($1 MATCHES 'Pet\\[\\d*\\]: OwnerGUID.*');
B = FOREACH A GENERATE (chararray)$0,FLATTEN(STRSPLIT($1, ' ='));
C = FOREACH B GENERATE 
  REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/LoginCacheLog.*', 1) as server_id,
  REGEX_EXTRACT($1, 'Pet\\[(\\d*)\\]: OwnerGUID',1) as pet_index,
  REGEX_EXTRACT($2, '(\\w*) OwnerName',1) as role_id,
  REGEX_EXTRACT($3, '(\\w*) PHGUID\\[\\d*\\]',1) as role_name,
  REGEX_EXTRACT($4, '(\\w*) PLGUID\\[\\d*\\]',1) as role_id_ph,
  REGEX_EXTRACT($5, '(\\w*)  PSHGUID\\[\\d*\\]',1) as role_id_pl,
  REGEX_EXTRACT($6, '(\\w*) PSLGUID\\[\\d*\\]',1) as role_id_psh,
  REGEX_EXTRACT($7, '(\\w*)  MID\\[\\d*\\]',1) as role_id_psl,
  REGEX_EXTRACT($8, '(\\w*)  PName\\[\\d*\\]',1) as mid,
  REGEX_EXTRACT($9, '(.*)  NName\\[\\d*\\]',1) as pet_name,
  REGEX_EXTRACT($11, '(\\w*)  TLevel\\[\\d*\\]',1) as p_level,
  REGEX_EXTRACT($12, '(\\w*)  PType\\[\\d*\\]',1) as t_level,
  REGEX_EXTRACT($13, '(\\w*)  PJinJieLevel\\[\\d*\\]',1) as p_type,
  REGEX_EXTRACT($14, '(\\w*), PJinJieExp\\[\\d*\\]',1) as p_jinjie_level,
  REGEX_EXTRACT($15, '(\\w*)  GRate\\[\\d*\\]',1) as p_jinjie_exp,
  REGEX_EXTRACT($16, '(.*)  PSavvy\\[\\d*\\]',1) as g_rate,
  REGEX_EXTRACT($17, '(\\w*)  PFitValue\\[\\d*\\]',1) as p_savvy,
  REGEX_EXTRACT($18, '(\\w*)  GenGu\\[\\d*\\]',1) as p_fit_value,
  REGEX_EXTRACT($19, '(\\w*)  PETHuanHua\\[\\d*\\]',1) as gengu,
  REGEX_EXTRACT($20, '(\\w*)  PETLXValue\\[\\d*\\]',1) as pet_huanhua,
  REGEX_EXTRACT($21, '(\\w*)  .*\\[\\d*\\]',1) as pet_lx_value,
  REGEX_EXTRACT($22, '(.*)  .*\\[\\d*\\]',1) as unk1,
  REGEX_EXTRACT($23, '(.*)  .*\\[\\d*\\]',1) as unk2,
  REGEX_EXTRACT($24, '(.*)  .*\\[\\d*\\]',1) as unk3,
  REGEX_EXTRACT($25, '(.*)  .*\\[\\d*\\]',1) as unk4,
  REGEX_EXTRACT($26, '(.*)  .*\\[\\d*\\]',1) as unk5,
  REGEX_EXTRACT($27, '(.*)  .*\\[\\d*\\]',1) as unk6,
  REGEX_EXTRACT($28, '(.*)  .*\\[\\d*\\]',1) as unk7,
  REGEX_EXTRACT($29, '(.*)  .*\\[\\d*\\]',1) as unk8,
  REGEX_EXTRACT($30, '(.*)  .*\\[\\d*\\]',1) as unk9,
  REGEX_EXTRACT($31, '(.*)  .*\\[\\d*\\]',1) as unk10,
  REGEX_EXTRACT($32, '(.*)  .*\\[\\d*\\]',1) as unk11,
  REGEX_EXTRACT($33, '(.*)  .*\\[\\d*\\]',1) as unk12,
  REGEX_EXTRACT($34, '(.*)  .*\\[\\d*\\]',1) as unk13,
  REGEX_EXTRACT($35, '(.*)  .*\\[\\d*\\]',1) as unk14,
  REGEX_EXTRACT($36, '(.*)  .*\\[\\d*\\]',1) as unk15,
  REGEX_EXTRACT($37, '(.*)  .*\\[\\d*\\]',1) as unk16,
  REGEX_EXTRACT($38, '(.*)  .*\\[\\d*\\]',1) as unk17,
  REGEX_EXTRACT($39, '(.*)  .*\\[\\d*\\]',1) as unk18,
  REGEX_EXTRACT($40, '(.*)  .*\\[\\d*\\]',1) as unk19,
  FLATTEN(REGEX_EXTRACT_ALL($41, '(.*) .*T0=(.*) T1.*')) as (unk20,log_date);

result = FOREACH C GENERATE
  ToString(ToDate(log_date, 'yyyy-MM-dd_HH:mm:ss'),'yyyy-MM-dd HH:mm:ss') as log_date,
  role_id,role_name, role_id_ph, role_id_pl, role_id_psh, role_id_psl, mid, pet_index,
  pet_name, p_level, t_level, p_type, p_jinjie_level, p_jinjie_exp, g_rate, p_savvy, 
  p_fit_value, gengu, pet_huanhua, pet_lx_value,
  unk1,unk2,unk3,unk4,unk5,unk6,unk7,unk8,unk9,unk10,unk11,unk12,unk13,unk14,unk15,unk16,unk17,unk18,unk19, 
  server_id;

DUMP result;
-- DESCRIBE result;
