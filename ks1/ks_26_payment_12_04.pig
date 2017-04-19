data = LOAD 'game/ge/gamelogs/ks/20170412/dbdata/payment_20170412.log' USING PigStorage('\t');
A = FOREACH data GENERATE 
  FLATTEN(STRSPLIT($0, ' \\[',2)) as (log_date,z1),
  $1 as transaction_id,
  $2 as account_name,
  $3 as number,
  $4 as error_code;
A = FOREACH A GENERATE 
  ToString(ToDate(log_date,'dd-MM-yyyy HH:mm:ss'),'YYYY-MM-dd HH:mm:ss'), 
  transaction_id, account_name, number ,error_code;

DUMP A;