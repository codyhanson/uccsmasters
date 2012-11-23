
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

math(smith).
math(jones).
math(doe).
math(kimball).
math(crane).

cs(zola).
cs(jenner).
cs(nichols).
cs(burke).

english(andrews).
english(beeker).
english(lovell).
english(richards).

%declare which classes exist, subject and number
class(math,101).
class(math,102).
class(math,201).
class(math,301).
class(math,350).
class(math,400).
class(math,415).

class(english,100).
class(english,110).
class(english,150).
class(english,220).
class(english,300).

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

canteach(Teacher,Subject,Number) :-
	lecturer(Teacher),
	lowlevel(Number); 
	instructor(Teacher).


%whocanteach(Subject,Nummber) :-
	
