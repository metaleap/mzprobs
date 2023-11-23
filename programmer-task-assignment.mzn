% Consider assigning five programmers to five programming jobs. Each
% programmer prefers specific programming job over others. [...] 
% Suppose you ask each programmer to rank the jobs according to preference
% (using 1 for the most preferred job and 5 for the least preffered job).
% Maximize the total preference of the group by minimizing the
% sum of the preferences. 
include "globals.mzn";

enum Programmer = {A, B, C, D, E};
enum Task = {T1, T2, T3, T4, T5};

array[Programmer,Task] of int: ranking = [| 4, 1, 3, 5, 2
                                          | 2, 1, 3, 4, 5
                                          | 3, 2, 4, 1, 5
                                          | 2, 3, 4, 5, 1
                                          | 4, 2, 3, 1, 5 |]; % lowest number is highest ranking

array[Programmer] of var Task: taskPerProgrammer;
constraint all_different(taskPerProgrammer);

array[Programmer] of var int: taskRankingPerProgrammer;
constraint forall (p in Programmer) (taskRankingPerProgrammer[p] == ranking[p, taskPerProgrammer[p]]);

var int: totalRanking;
constraint totalRanking == sum(taskRankingPerProgrammer);

solve minimize totalRanking;
