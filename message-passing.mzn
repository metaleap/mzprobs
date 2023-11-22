include "globals.mzn";

% Email is out of order at St. Mary's College and the teacher wants 
% to tell Robert something urgent.
% The teacher meets Craig and asks him to tell Robert she wants to speak 
% with him. 
% Craig says that if he meets Robert its OK, but else he will send the message 
% to everyone he meets and the message will go further.
% Each student tells each student he meets that the teacher waits for Robert
% in her office.
% The students meet each other (we don't know in what order):
% 1) Craig meets John and Jason
% 2) Jason meets Kiki and Adam and David
% 3) Adam meets Scott and Jeremy
% 4) Jeremy meets John and Scott
% 5) Kiki meets Chris
% 6) Chris meets David and Adam
% 7) David meets Robert
% Which path(s) might the message to Robert have taken?
% Description-only-but-not-solution taken from http://www.hakank.org/minizinc/message_sending.mzn

enum Person = { Craig,John,Jason,Kiki,Adam,David,Scott,Jeremy,Chris,Robert };
Person: msgFrom = Craig;
Person: msgTo = Robert;

array[_] of tuple (Person, Person): tupMeets = [(Craig, John), (Craig, Jason), (Jason, Kiki), (Jason, Adam), (Jason, David), (Adam, Scott), (Adam, Jeremy), (Jeremy, John), (Jeremy, Scott), (Kiki, Chris), (Chris, David), (Chris, Adam), (David, Robert)];
array[Person,Person] of var bool: meets;

constraint forall (meet in tupMeets)
  ((meets[meet.1,meet.2] == true)  /\  (meets[meet.2,meet.1] == true));

array[index_set(tupMeets)] of var Person: hops;

constraint hops[1] == msgFrom;
constraint hops[length(tupMeets)] == msgTo;
constraint all_different_except(hops, {msgTo});
constraint forall (i in hops where i > 1)
  (meets[hops[i],hops[i-1]]);
