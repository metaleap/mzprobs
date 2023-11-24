% We want to construct the time table of a conference. The conference will consist 
% of 11 sessions of equal length. The time table is to be organized as a sequence of 
% _slots, where a _slot can take up to 3 parallel sessions. There are the following 
% constraints on the timing of the sessions:
%  * Session 4 must take place before Session 11.
%  * Session 5 must take place before Session 10.
%  * Session 6 must take place before Session 11.
%  * Session 1 must not be in parallel with Sessions 2, 3, 5, 7, 8, and 10.
%  * Session 2 must not be in parallel with Sessions 3, 4, 7, 8, 9, and 11.
%  * Session 3 must not be in parallel with Sessions 5, 6, and 8.
%  * Session 4 must not be in parallel with Sessions 6, 8, and 10.
%  * Session 6 must not be in parallel with Sessions 7 and 10.
%  * Session 7 must not be in parallel with Sessions 8 and 9.
%  * Session 8 must not be in parallel with Session 10.
% The time table should minimize the number of _slots. 

enum Session = { S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11 };
int: maxSessPerSlot = 3;

array[Session] of var 1..card(Session): _slot;
array[1..card(Session)] of var 0..maxSessPerSlot: _numSess;
var int: _numSlots;

constraint (_slot[S4] < _slot[S11]);
constraint (_slot[S5] < _slot[S10]);
constraint (_slot[S6] < _slot[S11]);
constraint (not(_slot[S1] in [ _slot[S2], _slot[S3], _slot[S5], _slot[S7], _slot[S8], _slot[S10] ]));
constraint (not(_slot[S2] in [ _slot[S3], _slot[S4], _slot[S7], _slot[S8], _slot[S9], _slot[S11] ]));
constraint (not(_slot[S3] in [ _slot[S5], _slot[S6], _slot[S8] ]));
constraint (not(_slot[S4] in [ _slot[S6], _slot[S8], _slot[S10] ]));
constraint (not(_slot[S6] in [ _slot[S7], _slot[S10] ]));
constraint (not(_slot[S7] in [ _slot[S8], _slot[S9] ]));
constraint (not(_slot[S8] in [ _slot[S10] ]));

constraint forall (slot in 1..card(Session)) (_numSess[slot] == count (sess in Session) (_slot[sess] == slot));
constraint (_numSlots = count (slot in 1..card(Session)) (_numSess[slot] > 0));

solve minimize _numSlots;
