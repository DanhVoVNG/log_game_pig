data = LOAD 'game/ge/gamelogs/ks/20170412/itemList.csv' USING PigStorage(',');
A = FOREACH data GENERATE $0,$1;
DUMP A;
