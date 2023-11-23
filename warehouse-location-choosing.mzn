include "globals.mzn";

enum City = { NY, LA, SF, LV };
enum Region = { West, Mid, East };

array[City] of int: warehouseRentPerWeek = [ 400, 500, 450, 350 ];
array[Region] of int: unitsNeededPerWeek = [ 80, 70, 40 ];
array[City,Region] of int: unitShippingCost = [| 50, 40, 20 |
                                                 15, 26, 48 |
                                                 18, 26, 35 |
                                                 24, 35, 50 |];

array[City] of var bool: warehousePicked;
array[City] of var int: warehouseCostPerWeek;
var int: warehousesPickedCostPerWeek;

constraint warehousePicked[NY]  ->  (warehousePicked[LA] == true);
constraint (let { var int: count = count(warehousePicked) } in ((count <= 3) /\ (count >= 1)));
constraint (warehousePicked[LA]  \/  warehousePicked[LV]);
constraint forall (city in City)
            (warehouseCostPerWeek[city] == if not(warehousePicked[city]) then 0 else
                                             (warehouseRentPerWeek[city] + sum (region in Region) (unitShippingCost[city, region] * unitsNeededPerWeek[region])) 
                                           endif);
constraint (warehousesPickedCostPerWeek == sum (city in City) (warehouseCostPerWeek[city]));

solve minimize warehousesPickedCostPerWeek;
