data = LOAD 'game/ge/gamelogs/ks/20170412/dbdata/vng_point_query_20170412.log' USING PigStorage('\n','-tagPath');
A = RANK data;
A = FILTER A BY $0>2;
A = FOREACH A GENERATE 
  REGEX_EXTRACT((chararray)$1, '/ge/gamelogs/ks/(\\d{8})/dbdata/vng_point_query.*', 1) as t_folder_name,
  FLATTEN(REGEX_EXTRACT_ALL($2, '(\\w*).*?(\\d*)')) as (account_name,number);

DUMP A;
