include "globals.mzn";

% Description-only-but-not-solution taken from http://www.hakank.org/minizinc/message_sending.mzn
%
% Email is out of order at the College and the teacher wants 
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
% Which path(s), from longest to shortest, might the message from Craig to Robert have taken?

enum Person = { Craig,John,Jason,Kiki,Adam,David,Scott,Jeremy,Chris,Robert };
int: numPersons = card(Person);
Person: msgFrom = Craig;
Person: msgTo = Robert;


array[Person,Person] of bool: meets = array2d(Person, Person,
  [ %Craig John   Jason  Kiki   Adam   David  Scott  Jeremy Chris  Robert
    false,  true,  true, false, false, false, false, false, false, false, % Craig
     true, false, false, false, false, false, false,  true, false, false, % John
     true, false, false,  true,  true,  true, false, false, false, false, % Jason
    false, false,  true, false, false, false, false, false,  true, false, % Kiki
    false, false,  true, false, false, false,  true,  true,  true, false, % Adam
    false, false,  true, false, false, false, false, false,  true,  true, % David
    false, false, false, false,  true, false, false,  true, false, false, % Scott
    false,  true, false, false,  true, false,  true, false, false, false, % Jeremy
    false, false, false,  true,  true,  true, false, false, false, false, % Chris
    false, false, false, false, false,  true, false, false, false,  true, % Robert
  ]);

array[1..count(meets)] of var Person: hops;
array[1..count(meets)] of var bool: isRecipient;

constraint hops[1] == msgFrom;
constraint hops[count(meets)] == msgTo;
constraint all_different_except(hops, {msgTo});
constraint forall (i in 1..count(meets))
  (isRecipient[i] == (hops[i] == msgTo));
constraint forall (i in 2..count(meets))
  (meets[hops[i],hops[i-1]]);

solve maximize(count(isRecipient));
