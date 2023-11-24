% The P-Median problem is a well known problem in Operations Research. 
% The problem can be stated very simply, like this: given a set of customers 
% with known amounts of demand, a set of candidate locations for warehouses, 
% and the distance between each pair of customer-warehouse, choose 2 
% warehouses to open that minimize the demand-weighted distance of serving 
% all customers from those P warehouses.

enum Customer = { C1, C2, C3, C4 };
enum Location = { L1, L2, L3 };

array[Customer] of int: demand = [ 100,80,80,70 ];
array[Customer,Location] of int: distance = [| 2, 10, 50 |
                                               2, 10, 52 |
                                               50, 60, 3 |
                                               40, 60, 1 |];
int: maxNumWarehouses = 2;                 

array[Location] of var bool: _warehouse;
array[Location] of var 0..(max(distance)*max(demand)*card(Customer)): _distanceNr;

constraint (let {var int:c = count(_warehouse)} in (c >= 1) /\ (c <= maxNumWarehouses));
constraint forall (loc in Location) 
                  (_distanceNr[loc] == (if not(_warehouse[loc]) then 0 else (sum (cust in Customer) (distance[cust,loc] * demand[cust])) endif));

solve minimize sum(_distanceNr);
