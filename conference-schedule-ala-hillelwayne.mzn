/*
https://www.hillelwayne.com/post/minizinc/
https://www.hillelwayne.com/post/minizinc-2/
A conference has to schedule all of the accepted talks. 
Each talk is slotted to a specific day, hour, and conference room. 
To help with this, it sends a poll out to all attendees: 
rate every talk on a 5 point scale from “very interested” to “very uninterested”. 
This helps them find an ideal schedule. For example, if there are two talks that 
everybody wants to see, they probably shouldn’t be scheduled to the same day and time. 
Conversely, if there’s two talks with no overlap in the interested parties, 
then it’s fine to put them at the same time.
Let’s throw on a random complication: while every talk is unique, every presenter is not. 
t08 and t02 are both by the same person. 
For the sake of her sanity we won’t schedule both talks for the same day.
*/

enum Talk = { T1, T2, T3, T4, T5, T6, T7, T8 };
enum Room = { R1, R2 };
enum Person = { P1, P2 };
enum TimeSlot = { D1M, D1N, D2M, D2N };

array[Person,Talk] of 1..5: ranking = [| 5, 2, 5, 5, 2, 5, 2, 2 |
                                         2, 2, 5, 5, 5, 2, 2, 5 |];
