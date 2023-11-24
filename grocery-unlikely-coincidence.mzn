% A kid goes into a grocery store and buys four items. The cashier charges $7.11. 
% The kid pays and is about to leave when the cashier calls the kid back, and says 
% "Hold on, I multiplied the four items instead of adding them; I'll try again... 
% Gosh, with adding them the price still comes to $7.11"! What were the prices of 
% the four items?

int: numItems = 4;
int: totalCents = 711;

array[1..numItems]of var 0..711: itemCents;

constraint (sum(itemCents) == totalCents);
constraint (product(itemCents) == totalCents);
