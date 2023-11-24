include "globals.mzn";

enum Project = { None,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15 };

int: staffAvail = 28;
int: budgetTotalMio = 225;
array[Project]of int: projValueMio = [ 0,600,400,100,150,80,120,200,220,90,380,290,130,80,270,280 ];
array[Project]of int: projBudgetMio = [ 0,35,34,26,12,10,18,32,11,10,22,27,18,16,29,22 ];
array[Project]of int: projStaffReq = [ 0,5,3,4,2,2,2,4,1,1,5,3,2,2,4,3 ];
array[Project]of Project: projNotWith = [ None,P10,None,None,None,P6,P5,None,None,None,P1,P15,None,None,None,P11 ];
array[Project]of Project: projWith = [ None,None,None,P15,P15,None,None,None,P7,None,None,None,None,P2,P2,None ];

array[Project]of var bool: projChosen;
var int: staffNeededForProjChoices;
var int: budgetNeededForProjChoices;
var int: totalValueOfProjChoices;

constraint (projChosen[None] == false);
constraint (staffNeededForProjChoices == sum (proj in Project) (if projChosen[proj] then projStaffReq[proj] else 0 endif));
constraint (staffNeededForProjChoices <= staffAvail);
constraint (budgetNeededForProjChoices == sum (proj in Project) (if projChosen[proj] then projBudgetMio[proj] else 0 endif));
constraint (budgetNeededForProjChoices <= budgetTotalMio);
constraint (totalValueOfProjChoices == sum (proj in Project) (if projChosen[proj] then projValueMio[proj] else 0 endif));
constraint forall (proj in Project)
                    (((projChosen[proj]) /\ (projWith[proj] != None)) -> (projChosen[projWith[proj]] == true));
constraint forall (proj in Project)
                    (((projChosen[proj]) /\ (projNotWith[proj] != None)) -> (projChosen[projWith[proj]] == false));

solve maximize totalValueOfProjChoices;
