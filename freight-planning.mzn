% Transport 42 tons of freight using 8 trucks, which come in
% 4 sizes...
% 
% Truck Number Capacity  Cost
%  type available (tons)  per
%                        truck
%   1      3         7     90
%   2      3         5     60
%   3      3         4     50
%   4      3         3     40

enum TruckType = { A, B, C, D };

array[TruckType] of int: numAvail = [ 3,3,3,3 ];
array[TruckType] of int: capTons = [ 7,5,4,3 ];
array[TruckType] of int: truckCost = [ 90, 60, 50, 40 ];
int: jobSizeInTons = 42;

array[TruckType] of var int: trucksChosen;

constraint forall (tt in TruckType) ((trucksChosen[tt] >= 0) /\ (trucksChosen[tt] <= numAvail[tt]));
var int: totalCost;
constraint (totalCost == sum (tt in TruckType) (trucksChosen[tt] * truckCost[tt]));
var int: totalCapTons;
constraint totalCapTons >= jobSizeInTons;
constraint (totalCapTons == sum (tt in TruckType) (trucksChosen[tt] * capTons[tt]));

solve minimize totalCost;
