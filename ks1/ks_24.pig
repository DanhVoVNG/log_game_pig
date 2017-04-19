data = LOAD 'game/ge/gamelogs/ks/20170412/185/vn_185_20170412.txt' USING PigStorage('\t', '-tagPath');
A = rank data;
A = FILTER A by $0 > 1;
  REGEX_EXTRACT((chararray)$1, '.*/ge/gamelogs/ks/(\\d{8})/(\\d*)/vn.*', 1) as log_date_no_time,
  $2 as server_id,
  $2 as account_name,
  $2 as Icharguidl,
  $2 as server_id,

DUMP data;