data = LOAD 'game/ge/gamelogs/ks/20170412/185/CostYuanBao_2017-04-12.1155046881.log' USING PigStorage(',','-tagPath');
A = FOREACH data GENERATE COUNT(TOBAG(*));
-- ,$1..;
DUMP A;