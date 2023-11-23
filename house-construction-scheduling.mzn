include "globals.mzn";

enum Task = { NoTask,ErectingWalls,RoofCarpentry,Roof,Installations,FacadePainting,Windows,Garden,Ceilings,Painting,MovingIn };
enum Company = { NoCompany, ConstructionInc, HouseInc, BuilderCorp };

array[Task] of int: taskDurationDays = [ 0,7,3,1,8,2,1,1,3,2,1 ];
array[Task] of Company: taskCompany = [ NoCompany, ConstructionInc, HouseInc, HouseInc, ConstructionInc, ConstructionInc, HouseInc, HouseInc, ConstructionInc, BuilderCorp, BuilderCorp ];
array[Task] of tuple(Task,Task): taskPreds = [
                                              (NoTask, NoTask),        % NoTask
                                              (NoTask, NoTask),        % a ErectingWalls
                                              (ErectingWalls, NoTask), % b RoofCarpentry
                                              (RoofCarpentry, NoTask), % c Roof
                                              (ErectingWalls, NoTask), % d Installations
                                              (Roof, Installations),   % e FacadePainting
                                              (Roof, Installations),   % f Windows
                                              (Roof, Installations),   % g Garden
                                              (ErectingWalls, NoTask), % h Ceilings
                                              (Windows, Ceilings),     % i Painting
                                              (Painting, NoTask),      % j MovingIn
                                             ];

array[Task] of var int: day;

constraint day[NoTask] == 0;
constraint forall(task in Task)
  (if (task == NoTask) then (day[task] == 0) 
    else 
      ((day[task] > 0)  /\ let {
        Task: pred1 = taskPreds[task].1;
        Task: pred2 = taskPreds[task].2;
      } in
        ((pred1 == NoTask)  \/  (day[task]  >=  (day[pred1] + taskDurationDays[pred1])))  /\
        ((pred2 == NoTask)  \/  (day[task]  >=  (day[pred2] + taskDurationDays[pred2])))) 
    endif);

solve minimize sum(day);
