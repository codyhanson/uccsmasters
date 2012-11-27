%Cody Hanson
%CS3160 Prolog Assignment 3, Problem 1.

%Facts
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

%tell('prologForTeachersOutput.txt'),


%run the queries

write('1) What classes can be taught by jenner?'),nl,
canteach(jenner,Subject1,Number1),
nl,

write('2) What classes can be taught by Burke?'),nl,
canteach(burke,Subject,Number),
nl,

write('3) What classes can be taught by Andrews?'),nl,
canteach(andrews,Subject,Number),
nl,

write('4) What classes can be taught by richards?'),nl,
canteach(richards,Subject,Number),
nl,

write('5) What classes can be taught by Crane?'),nl,
canteach(crane,Subject,Number),
nl,

write('6) who can teach cs 300?'),nl,
canteach(Who,cs,300),
nl,

write('7) who can teach any level cs course?'),nl,
%interpreting as, can teach any cs course unrestrictedly.
canteach(Who,cs,Number), instructor(Who),
nl,

%8) who are all the teachers who could teach 100-level courses in any area
% should be none....


write('9) who can teach math 415?'),nl,
canteach(Who,math,415),
nl,

write('10) who are all the teachers that can teach english courses'),nl,
degree(Who,eng),
nl.

%told.

%end of the go routine.







