
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
	lowlevel(Number),
	class(Subject,Number),
	degree(Teacher,Subject); 
	instructor(Teacher),
	class(Subject,Number),
	degree(Teacher,Subject). 


%whocanteach(Subject,Nummber) :-
	


%run the queries
%1) What classes can be taught by jenner?
%A:



