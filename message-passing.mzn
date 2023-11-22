include "globals.mzn";

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
