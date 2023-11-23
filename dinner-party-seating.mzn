% Hosting a dinner party requires several skills to pull off a successful 
% evening. One of your duties, aside from preparing dinner and selecting 
% the drinks, is to make sure your guests enjoy themselves.
%
% Figure 1 shows a dinner table with six seats for your guests. Some 
% guests, however, do not get along with each other. If two guests who 
% do not get along are seated next to each other, it will create conflict 
% at dinner. As host, you must arrange the guests in a seating order 
% that minimizes conflict.
%
% Andrew will only sit next to Dave and Frank; 
% Betty will only sit next to Cara and Erica; 
% Cara will only sit next to Betty and Frank; 
% Dave will only sit next to Andrew and Erica; 
% Erica will only sit next to Betty and Dave; 
% Frank will only sit next to Andrew and Cara. 
%
%   Figure 1 shows the following arrangement:
%               Andrew
%        Frank         Betty
%        Erica         Cara
%               Dave
% 
% In the example seating arrangement above, there are three conflicts 
% (Andrew and Betty, Cara and Dave, Erica and Frank).
% What better seating arrangement will minimize the conflict at dinner?
include "globals.mzn";

enum Person = { None, A, B, C, D, E, F };
array[Person,Person] of bool: prefer = [| false, false, false, false, false, false, false
                                        | false, false, false, false,  true, false,  true
                                        | false, false, false,  true, false,  true, false
                                        | false, false,  true, false, false, false,  true
                                        | false,  true, false, false, false,  true, false
                                        | false, false,  true, false,  true, false, false
                                        | false,  true, false,  true, false, false, false |];

array[1..6] of var Person: seat;
constraint all_different(seat);
constraint forall (i in 1..6)
  (let {
    var Person: prev = if (i == 1) then seat[6] else seat[i-1] endif;
    var Person: next = if (i == 6) then seat[1] else seat[i+1] endif;
    var Person: this = seat[i];
  } in
      (prefer[this, prev]  /\  prefer[this, next]));
