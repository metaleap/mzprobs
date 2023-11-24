% Six workers (Alan, Bob, John, Mike, Scott, and Ted) are to be assigned 
% to three working shifts. The first shift needs at least one and at 
% most four people; the second shift needs at least two and at most 
% three people; and the third shift needs exactly two people. Alan 
% does not work on the first shift; Bob works only on the third shift. 
% The others can work any shift. The objective is to find a feasible 
% assignment for this problem.

include "globals.mzn";

enum Worker = { A,B,J,M,S,T };
enum Shift = { S1,S2,S3 };

array[Shift] of int: numWorkersMin = [ 1,2,2 ];
array[Shift] of int: numWorkersMax = [ 4,3,2 ];

array[Shift,Worker] of var bool: plan;
array[Shift] of var int: numWorkers;
array[Worker] of var int: numShifts;

constraint (plan[S1,A] == false);
constraint (plan[S3,B] == true);
constraint forall (shift in Shift)
                  ((numWorkers[shift] == count (worker in Worker) (plan[shift,worker]))
                    /\ (numWorkers[shift] >= numWorkersMin[shift]) /\ (numWorkers[shift] <= numWorkersMax[shift]));
constraint forall (worker in Worker)
                  ((numShifts[worker] == count (shift in Shift) (plan[shift,worker]))
                    /\  (numShifts[worker] == 1));
y
solve minimize sum(numWorkers);
