% Given a set of items I = {1,...,m} with weight w[i] > 0, the Bin
% Packing Problem (BPP) is to pack the items into bins of capacity c
% in such a way that the number of bins used is minimal. 

include "globals.mzn";

enum Item = { I1, I2, I3, I4, I5, I6 };
type Bin = 1..card(Item);

array[Item] of int: itemWeight = [ 50, 60, 30, 70, 50, 40 ];
int: binCapacity = 100;

array[Item] of var Bin: _bin;
array[Bin] of var 0..binCapacity: _binWeightPacked;
var int: _numBins;

constraint (_numBins == count (w in _binWeightPacked) (w > 0));
constraint forall (bin in 1..card(Item)) 
                  (_binWeightPacked[bin] == sum (item in Item where (_bin[item] == bin)) (itemWeight[item]));

solve minimize _numBins;
