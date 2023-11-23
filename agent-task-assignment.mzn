% There are a number of agents and a number of tasks. Any agent can be
% assigned to perform any task, incurring some cost that may vary
% depending on the agent-task assignment. It is required to perform all
% tasks by assigning exactly one agent to each task in such a way that
% the total cost of the assignment is minimized.
include "globals.mzn";

enum Agent = { A1, A2, A3, A4, A5, A6, A7, A8 };
enum Task = { T1, T2, T3, T4, T5, T6, T7, T8 };

array[Agent,Task] of int: cost = array2d(Agent, Task, [13, 21, 20, 12,  8, 26, 22, 11,
                                                      12, 36, 25, 41, 40, 11,  4,  8,
                                                      35, 32, 13, 36, 26, 21, 13, 37,
                                                      34, 54,  7,  8, 12, 22, 11, 40,
                                                      21,  6, 45, 18, 24, 34, 12, 48,
                                                      42, 19, 39, 15, 14, 16, 28, 46,
                                                      16, 34, 38,  3, 34, 40, 22, 24,
                                                      26, 20,  5, 17, 45, 31, 37, 43]);

array[Agent] of var Task: taskForAgent;
constraint all_different(taskForAgent);

array[Agent] of var int: taskCostForAgent;
constraint forall (agent in Agent) (taskCostForAgent[agent] == cost[agent, taskForAgent[agent]]);

var int: totalCost;
constraint totalCost == sum(taskCostForAgent);

solve minimize totalCost;
