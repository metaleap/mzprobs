% In which order do you schedule the tasks starting from day 0 (today)?
% Task  T1 takes 4 days with deadline on day 45
% Task  T2 takes 4 days with deadline on day 48
% Task  T3 takes 5 days with deadline on day 25
% Task  T4 takes 2 days with deadline on day 49
% Task  T5 takes 5 days with deadline on day 36
% Task  T6 takes 2 days with deadline on day 31
% Task  T7 takes 7 days with deadline on day 9
% Task  T8 takes 5 days with deadline on day 39
% Task  T9 takes 4 days with deadline on day 13
% Task T10 takes 6 days with deadline on day 17
% Task T11 takes 4 days with deadline on day 29
% Task T12 takes 1 days with deadline on day 19

include "globals.mzn";

enum Task = { T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12 };

array[Task] of int: daysNeeded = [ 4,4,5,2,5,2,7,5,4,6,4,1 ];
array[Task] of int: dueInDays = [ 45,48,25,49,36,31,9,39,13,17,29,19 ];

array[Task] of var 0..max(dueInDays): taskDay;

% for every task, every other task should start on an earlier day or after the former is completed
constraint forall (this in Task, other in Task where other != this) 
                  ((taskDay[other] < taskDay[this]) \/ (taskDay[other] >= (taskDay[this] + daysNeeded[this])));
% every task must start early enough to meet the deadline
constraint forall (task in Task)
                  ((taskDay[task] + daysNeeded[task]) <= dueInDays[task]);

solve minimize sum(taskDay);
