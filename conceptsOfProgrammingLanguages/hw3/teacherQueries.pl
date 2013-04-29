%run the queries
%1) What classes can be taught by jenner?
canteach(jenner,Subject,Number).


%2) What classes can be taught by Burke?
canteach(Burke,Subject,Number).

%3) What classes can be taught by Andrews?
canteach(andrews,Subject,Number).

%4) What classes can be taught by richards?
canteach(richards,Subject,Number).

%5) What classes can be taught by Crane?
canteach(crane,Subject,Number).  

%6) who can teach cs 300?
canteach(Who,cs,300).

%7) who can teach any level cs course?
%interpreting as, can teach any cs course unrestrictedly.
canteach(Who,cs,Number), instructor(Who).

%8) who are all the teachers who could teach 100-level courses in any area
% should be none....


%9) who can teach math 415?
canteach(Who,math,415).

%10) who are all the teachers that can teach english courses
degree(Who,eng).








