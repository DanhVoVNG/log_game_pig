data = LOAD 'game/ge/gamelogs/ks/20170412/185/balance_on_role_185_20170412.log' USING PigStorage('\t','-tagPath');
A = rank data;
A = FILTER A By $0>2;
A = FOREACH A GENERATE 
  FLATTEN(REGEX_EXTRACT_ALL((chararray)$1, '.*/ge/gamelogs/ks/(\\d{8})/(\\d*)/balance_on_role.*')) as (log_date_no_time, server_id),
  $2 as role_name,
  $3 as role_id,
  $4 as amount;
A = FOREACH A GENERATE 
  ToString(ToDate(CONCAT(log_date_no_time,' 23:59:59'),'yyyyMMdd HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'),
  server_id, role_id, role_name, amount;

DUMP A;
