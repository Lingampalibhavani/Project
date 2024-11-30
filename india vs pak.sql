create table batting(player_name varchar (50) not null,team varchar(10) not null,runs int null,fours int default 0,sixes int default 0,is_out bit default 0,out_method varchar(50),bowler varchar(50),fielder varchar(50));
create table bowling(bowler_name varchar(50) not null,team varchar(3) not null,overs int not null,maidens int default 0,runs_conceded int not null,wickets int default 0);
insert into bowling(bowler_name,team,overs,maidens,runs_conceded,wickets) values('arshadeep singh','ind',4,0,31,1),('mohammed siraj','ind',4,0,19,0),('jasprit bumrah','ind',4,0,14,3),('hardik pandya','ind',4,0,24,2),('ravindra jadeja','ind',2,0,10,0),('axar patel','ind',2,0,11,1),('shahen afridi','pak',4,0,29,1);
insert into bowling(bowler_name,team,overs,maidens,runs_conceded,wickets)values("nasheem shah","pak",4,0,21,3),("mohammad amir","pak",1,0,7,0),("ifthikar ahmed","pak",1,0,7,0),("imad asim","pak",3,0,17,0),("haris rauf","pak",3,0,21,3);
select*from bowling;
select*from batting;
alter table batting add column balls_faced int null after runs;
insert into batting(player_name,team,runs,balls_faced,fours,sixes,is_out,out_method,bowler,fielder)values
("rohit sharma","ind",13,12,1,1,1,"caught","shaheen afridi","haris rauf"),
("virat kohli","ind",4,3,1,0,1,"caught","naseem shah","usam khan"),
("rishab pant","ind",42,31,6,0,1,"caught","mohammad amir","babar azam"),
("axer patel","ind",20,18,2,1,1,"bowled","naseem shah",null),
("shivam dube","ind",3,9,0,0,1,"caught&bowled","nasheem shan",null),
("suryarkumar yadav","ind",7,8,1,0,1,"caught","haris rauf","mohammad amir"),
("hardik pandya","ind",7,12,1,0,1,"caught","haris rauf","iftikhar ahmed"),
("ravindra jadeja","ind",0,1,0,0,1,"bowled","mohammad amir",null),
("arshadeep singh","ind",9,13,1,0,1,"run out",null,"babar azam/mohammad rizwan"),
("jasprit bumrah","ind",0,1,0,0,1,"bowled","haris rauf",null),
("mohammad siraj","ind",7,7,0,0,0,null,null,null);
insert into batting(player_name,team,runs,balls_faced,fours,sixes,is_out,out_method,bowler,fielder)values
("mohammad rizwn","pak",31,44,1,1,1,"bowled","jasprit bumrah",null),
("babar azam","pak",13,12,2,0,1,"caught","jasprit bumrah","suryakumar yadav"),
("ushman khan","pak",13,15,1,0,1,"ibw","axar patel",null),
("fakhar zaman","pak",13,8,1,1,1,"caught","hardik pandya","rishabh pant"),
("imad wasim","pak",15,23,1,0,1,"caught","arshadeep singh","rishabh pant"),
("shad khan","pak",4,7,0,0,1,"caught","hardik pandya","rishab pant"),
("ifthikar ahmed","pak",5,9,0,0,1,"caught","jasprit bumrah","harshadeep singh"),
("shaheen afrid","pak",0,1,0,0,0,null,null,null),
("nasheem shan","pak",10,4,2,0,0,null,null,null),
("haris rauf","pak",null,null,null,null,null,null,null,null),
("mohammd amir","pak",null,null,null,null,null,null,null,null);
select*from batting;
#list of all players who hit atleast two fours
select player_name from batting where fours>=2;
#find the player who scored the highest runs
select player_name,runs from batting order by runs desc limit 1;
#find the total number of boundaries(fours+sixes) hit  by india
select sum(fours) + sum(sixes) as boundaries from batting where team="ind";
#find the top three highest strike rate
select * from batting;
select player_name,round((cast(runs as float)*100.0/balls_faced),2) as strike_rate from batting where runs order by strike_rate desc limit 3;
#find the top 3 players with the lowest strike rate who scored atleast 10 runs
select player_name,round((cast(runs as float)*100.0/balls_faced),2) as strike_rate from batting where runs>=10 order by strike_rate asc limit 3;

#find the top3 economy rate of bowler
select bowler_name,round((cast(runs_conceded as float)/overs),2) as economy_rate from bowling order by economy_rate asc limit 3;

#list the bowlers who did not take any wickets
select bowler_name from bowling where wickets=0;

#list all players who were not out
select player_name from batting where is_out=0;

#find the number of plyers who were caught out
select * from batting;
select count(*) as caught_out_caught from batting where out_method="caught" or out_method="caught & bowled";

#who bowled the mostt economical overs(lowest runs conceded per over)
select bowler_name,(cast(runs_conceded as float)/cast(overs as float)) as economy_rate from bowling order by economy_rate asc limit 1;

#list the top 3 players with the highest individual scores from each team


with rankedescores as(select player_name,team,runs,row_number() over(partition by team order by runs desc)
as ranks from batting)

select player_name,team,runs from rankedscores where rank <=3 order by team,rank;



































