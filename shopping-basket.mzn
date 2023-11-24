% I have a list of items I want to buy. The items are offered by different 
% shops and different prices. The shops have individual delivery costs. 
% Example:
%    * Item1 is offered at Shop1 for $100, at Shop2 for $111.
%    * Item2 is offered at Shop1 for $90, at Shop2 for $85.
%    * Delivery cost of Shop1: $10 if total order < $150; $0 otherwise
%    * Delivery cost of Shop2: $5 if total order < $50; $0 otherwise 
% Find optimal shopping strategy to purchase all of the items with a minimal total price.

include "globals.mzn";

enum Shop = { S1, S2 };
enum Product = { P1, P2 };

array[Product,Shop] of int: price = [| 100, 111 | 90, 85 |];
array[Shop] of int: delivCost = [ 10, 5 ];
array[Shop] of int: freeDeliv = [ 150, 50 ];

array[Product] of var Shop: _buyFrom;
array[Shop] of var int: _prodCost;
array[Shop] of var int: _delivCost;
var int: _totalDelivCost;
var int: _totalProdCost;
var int: _totalCost;

constraint forall (shop in Shop)
                  (_prodCost[shop] == sum (prod in Product) (if (_buyFrom[prod] != shop) then 0 else price[prod,shop] endif));
constraint forall (shop in Shop)
                  (_delivCost[shop] == let{ var int: pc = _prodCost[shop] } in if ((pc == 0) \/ (pc >= freeDeliv[shop])) then 0 else delivCost[shop] endif);
constraint (_totalDelivCost == sum(_delivCost));
constraint (_totalProdCost == sum(_prodCost));
constraint (_totalCost == _totalProdCost + _totalDelivCost);

solve minimize _totalCost;
