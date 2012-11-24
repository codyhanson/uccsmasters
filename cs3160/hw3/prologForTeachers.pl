
instructor(lovell).
instructor(richards).
instructor(kimball).
instructor(crane).
instructor(nichols).
instructor(burke).  
lecturer(smith).
lecturer(jones).
lecturer(doe).
lecturer(andrews).
lecturer(beeker).
lecturer(zola).
lecturer(jenner).

degree(smith,math).
degree(jones,math).
degree(doe,math).
degree(kimball,math).
degree(crane,math).
degree(zola,cs).
degree(jenner,cs).
degree(nichols,cs).
degree(burke,cs).
degree(andrews,eng).
degree(beeker,eng).
degree(lovell,eng).
degree(richards,eng).

%declare which classes exist, subject and number
class(math,101).
class(math,102).
class(math,201).
class(math,301).
class(math,350).
class(math,400).
class(math,415).  
class(eng,100).
class(eng,110).
class(eng,150).
class(eng,220).
class(eng,300).  
class(cs,110).
class(cs,145).
class(cs,200).
class(cs,300).
class(cs,410).
class(cs,450).

lowlevel(Coursenumber) :-
	Coursenumber < 300.

csinstructor(X) :-
	cs(X),
	instructor(X).

inform(X,Y,Z) :-
	write([teacher,X,can,teach,course,Y,Z]),nl.

canteach(Teacher,Subject,Number) :-
	lecturer(Teacher),
	class(Subject,Number),
	lowlevel(Number),
	degree(Teacher,Subject),
	inform(Teacher,Subject,Number); 
	instructor(Teacher),
	class(Subject,Number),
	degree(Teacher,Subject),
	inform(Teacher,Subject,Number). 

%canteach(Teacher) :-
%	lecturer(Teacher),
%	lowlevel(class(degree(Teacher,Subject),Number));
%	instructor(Teacher),
%	class(degree(Teacher,Subject),Number).
%	

go :-
%run the queries
%1) What classes can be taught by jenner?
canteach(jenner,Subject,Number);


%2) What classes can be taught by Burke?
canteach(Burke,Subject,Number);

%3) What classes can be taught by Andrews?
canteach(andrews,Subject,Number);

%4) What classes can be taught by richards?
canteach(richards,Subject,Number);

%5) What classes can be taught by Crane?
canteach(crane,Subject,Number); 

%6) who can teach cs 300?
canteach(Who,cs,300);

%7) who can teach any level cs course?
%interpreting as, can teach any cs course unrestrictedly.
canteach(Who,cs,Number), instructor(Who);

%8) who are all the teachers who could teach 100-level courses in any area
% should be none....


%9) who can teach math 415?
canteach(Who,math,415);

%10) who are all the teachers that can teach english courses
degree(Who,eng).








