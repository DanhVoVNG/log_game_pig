-- data = LOAD 'ge/gamelogs/ks/20170412/billing/bill_40_28/store.log.2017-04-12' USING PigStorage(',', '-tagPath');
-- A = FOREACH data GENERATE 
--   REGEX_EXTRACT($0, '/ge/gamelogs/ks/\\d{8}/billing/(.*)/store\\.log\\..*', 1),
--   FLATTEN(STRSPLIT($1, ' ',2));
-- A = FOREACH A GENERATE CONCAT((chararray)$0, (chararray)$1),$2;
-- DUMP A;

-- data = LOAD 'ge/gamelogs/ks/20170412/billing/bill_40_28/store.log.2017-04-12' USING PigStorage(',', '-tagPath');
-- A = FOREACH data GENERATE 
--   REGEX_EXTRACT($0, '/ge/gamelogs/ks/\\d{8}/billing/(.*)/store\\.log\\..*', 1),
--   FLATTEN(REGEX_EXTRACT_ALL($1, '\\[(\\d{2}:\\d{2}:\\d{2})\\] (\\d*)'))
--   ,$2,$3..$8;
-- -- success = FOREACH A GENERATE $0..$7,$8,$9;
-- unsuccess = FILTER A by ($8 MATCHES 'list.*');



-- success = FILTER A by ($9 MATCHES 'success_list.*');
-- success = FOREACH success GENERATE 
--   CONCAT((chararray)$0,CONCAT(' ', (chararray)$1)),$2,$3,$4,$5,$6,$7,$8,$9;
-- success = FOREACH success GENERATE REGEX_EXTRACT((chararray)$8, '=', 1);
-- -- success = FOREACH success GENERATE $0..$9;
-- -- A = FOREACH A GENERATE 
-- --   CONCAT((chararray)$0,CONCAT(' ', (chararray)$1)),$2,$3,$4,$5,$6,$7,$8,$9;
-- DUMP success;



data = LOAD 'ge/gamelogs/ks/20170412/billing/bill_40_28/store.log.2017-04-12' USING PigStorage(',', '-tagPath');
A = FOREACH data GENERATE 
  REGEX_EXTRACT($0, '/ge/gamelogs/ks/\\d{8}/billing/(.*)/store\\.log\\..*', 1),
  FLATTEN(REGEX_EXTRACT_ALL($1, '\\[(\\d{2}:\\d{2}:\\d{2})\\] (\\d*)'))
  ,$2..$6,
  FLATTEN(REGEX_EXTRACT_ALL($7, '(list=)*(\\d*)')),
  FLATTEN(REGEX_EXTRACT_ALL($8, '(success)_list=(\\d*)'));
A = FOREACH A GENERATE 
  CONCAT((chararray)$0,CONCAT(' ', (chararray)$1)),$2,$3,$4,$5,$6,$7,$8,$9,$10,$11;
unsuccess = filter A by $10 is null;
unsuccess = FOREACH unsuccess GENERATE $0..$6,$8;
success = FILTER A by $10 is not null;
success = FOREACH success GENERATE $0..$6,$8,$9;

result = UNION unsuccess, success;
dump result
