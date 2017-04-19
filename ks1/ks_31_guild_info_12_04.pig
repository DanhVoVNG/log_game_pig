data = LOAD 'game/ge/gamelogs/ks/20170412/185/guild_2017-04-12-0.1154130299.log' USING PigStorage('\n','-tagPath');
A = FILTER data BY ($1 MATCHES '\\[ValidateGuildBoomAndTicket:\\].*');
A = FOREACH A GENERATE 
  REGEX_EXTRACT((chararray)$0, '/ge/gamelogs/ks/\\d{8}/(\\d*)/guild.*', 1) as server_id,
  FLATTEN(STRSPLIT($1, ' = '));
A = FOREACH A GENERATE 
  $0 as server_id, 
  FLATTEN(STRSPLIT($1, ' ', 2)),
  FLATTEN(STRSPLIT($2, ' ', 2)),
  FLATTEN(STRSPLIT($3, ' ', 2)),
  FLATTEN(STRSPLIT($4, ' ', 2)),
  FLATTEN(STRSPLIT($5, ' ', 2)),
  FLATTEN(STRSPLIT($6, ' ', 2)),
  FLATTEN(STRSPLIT($7, ' ', 2)),
  FLATTEN(STRSPLIT($8, ' ', 2));
A = FOREACH A GENERATE 
  $0 as server_id,
  $3 as guild_id,
  $5 as guild_name,
  $7 as guild_level,
  $9 as boom_value,
  $11 as taken_ticket,
  $13 as submit_ticket,
  $15 as user_count,
  $16 as log_date;

DUMP A;
