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

inform(W,X,Y,Z) :-
	write([teacher,W,with,degree,in,X,can,teach,course,Y,Z]),nl.

canteach(Teacher,Subject,Number) :-
	(lecturer(Teacher),
	class(Subject,Number),
	lowlevel(Number),
	degree(Teacher,Subject),
	inform(Teacher,Subject,Subject,Number)); 
	(instructor(Teacher),
	class(Subject,Number),
	degree(Teacher,Subject),
	inform(Teacher,Subject,Subject,Number));  
	(instructor(Teacher),
	lowlevel(Number),
	class(Subject,Number),
	Subject == cs,	
	degree(Teacher,math),
	inform(Teacher,math,cs,Number)). 

%they must be instructor or a lecturer
canteachLvl100(Who) :-
	lecturer(Who),
	degree(Who,Sub),
	write([Who,is,a,lecturer,who,can,teach,lvl,100,Sub]),nl;
	instructor(Who),
	degree(Who,Sub),
	write([Who,is,an,instructor,who,can,teach,lvl,100,Sub]),nl.

go :-

%tell('prologForTeachersOutput.txt'),


%run the queries

write('1) What classes can be taught by jenner?'),nl,
findall(Subject1,canteach(jenner,Subject1,Number1),bag),
nl,

write('2) What classes can be taught by Burke?'),nl,
findall(Subject2,canteach(burke,Subject2,Number2),bag),
nl,

write('3) What classes can be taught by Andrews?'),nl,
findall(Subject3,canteach(andrews,Subject3,Number3),bag),
nl,

write('4) What classes can be taught by richards?'),nl,
findall(Subject4,canteach(richards,Subject4,Number4),bag),
nl,

write('5) What classes can be taught by Crane?'),nl,
findall(Subject5,canteach(crane,Subject5,Number5),bag),
nl,

write('6) who can teach cs 300?'),nl,
findall(Who6,canteach(Who6,cs,300),bag),
nl,

write('7) who can teach any level cs course?'),nl,
%interpreting as, can teach any cs course at all.
findall(Who7,canteach(Who7,cs,Number7),bag),
nl,

%8) who are all the teachers who could teach 100-level courses in any area
findall(Who8,canteachLvl100(Who8),bag),

write('9) who can teach math 415?'),nl,
findall(Who9,canteach(Who9,math,415),bag),
nl,

write(' 10) who are all the teachers that can teach english courses'),nl,
findall(who10,degree(Who10,eng),bag),
nl.


%told.

%end of the go routine.



