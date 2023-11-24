% Please can you help optimize this working MiniZinc code:
% Task: There is a conference which has 6x time slots. There are 3 speakers attending 
% the conference who are each available at certain slots. Each speaker will present for 
% a predetermined number of slots.
% Objective: Produce the schedule that has the earliest finish of speakers.
% Example: Speakers A, B & C. Talk durations = [1, 2, 1]
% Speaker availability:
% +---+------+------+------+
% |   | Sp.A | Sp.B | Sp.C |
% +---+------+------+------+
% | 1 |      | Busy |      |
% | 2 | Busy | Busy | Busy |
% | 3 | Busy | Busy |      |
% | 4 |      |      |      |
% | 5 |      |      | Busy |
% | 6 | Busy | Busy |      |
% +---+------+------+------+

include "globals.mzn";

enum Speaker = { S1,S2,S3 };
enum Hour = { H1, H2, H3, H4, H5, H6 };


array[Speaker,Hour] of bool: blocked = [| false,  true,  true, false, false,  true |
                                           true,  true,  true, false, false,  true |
                                          false,  true, false, false,  true, false |];
array[Speaker] of int: talkDur = [ 1,2,1 ];
int: lastHour = max(index_set(Hour));




array[Speaker] of var Hour: talkHour;

constraint forall (speaker in Speaker)
                  (talkHour[speaker] <= (lastHour - (talkDur[speaker]-1)));
constraint forall (speaker in Speaker, hour in talkHour[speaker]..talkHour[speaker]+(talkDur[speaker] - 1) where hour <= lastHour)
                  (not(blocked[speaker, to_enum(Hour, hour)]));
constraint forall (this in Speaker, other in Speaker where other != this, hour in talkHour[this]..talkHour[this]+(talkDur[this] - 1) where hour <= lastHour)
                  (to_enum(Hour, hour) != talkHour[other]);

solve minimize sum(talkHour);
