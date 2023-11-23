% Choose your crew
%
% Successfully navigating the waters during sea voyages is a 
% challenging task. A captain's most important decision is selecting 
% the right crew for the voyage. A mix of different skill sets is 
% required to sail the ship efficiently, navigate to the destination 
% and fish for good along the way.
%
% Table 1 shows a list of crew members available for you to 
% hire for the voyage. Each crew member demands a salary for the 
% voyage and has different skill levels of fishing, sailing and navigation.
%
% In order for your journey to be successful, you must have a 
% cumulative skill of 15 or more in each of the three skill 
% categories from all of your chosen crew members. You may choose 
% as many crew members as you like.

enum Person = { Amy, Bill, Carl, Dan, Eva, Fred, Greg, Henry, Ida };

int: minCumulativeSkill = 15;
array[Person] of record(int: skillFishing, int: skillSailing, int: skillNavi, int: salary): people = [
  (skillFishing: 3, skillSailing: 5, skillNavi: 1, salary: 46000), % Amy
  (skillFishing: 1, skillSailing: 2, skillNavi: 5, salary: 43000), % Bill
  (skillFishing: 3, skillSailing: 4, skillNavi: 2, salary: 47000), % Carl
  (skillFishing: 4, skillSailing: 3, skillNavi: 1, salary: 36000), % Dan
  (skillFishing: 4, skillSailing: 2, skillNavi: 2, salary: 43000), % Eva
  (skillFishing: 1, skillSailing: 3, skillNavi: 4, salary: 55000), % Fred
  (skillFishing: 3, skillSailing: 1, skillNavi: 5, salary: 68000), % Greg
  (skillFishing: 5, skillSailing: 4, skillNavi: 2, salary: 64000), % Henry
  (skillFishing: 3, skillSailing: 3, skillNavi: 3, salary: 60000), % Ida
];

array[Person] of var bool: chosen;
var int: cumuSkillsFishing;
var int: cumuSkillsSailing;
var int: cumuSkillsNavi;
var int: cumuSalary;

constraint cumuSalary == sum (person in Person where chosen[person]) (people[person].salary);
constraint ((cumuSkillsFishing == sum (person in Person where chosen[person]) (people[person].skillFishing))
            /\  (cumuSkillsFishing >= 15));
constraint ((cumuSkillsSailing == sum (person in Person where chosen[person]) (people[person].skillSailing))
            /\  (cumuSkillsSailing >= 15));
constraint ((cumuSkillsNavi == sum (person in Person where chosen[person]) (people[person].skillNavi))
            /\  (cumuSkillsNavi >= 15));

solve minimize cumuSalary;
