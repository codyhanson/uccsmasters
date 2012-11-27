%part two of the prolog assignment: Musicians.
%Cody Hanson - CS3160 Fall 2012.

%facts
%The notation of an 's' after a note will denote a '#'.

note(a).
note(as).
note(b).
note(c).
note(cs).
note(d).
note(ds).
note(e).
note(f).
note(fs).
note(g).
note(gs).

halfstep(a,as).  
halfstep(as,b).
halfstep(b,c).
halfstep(c,cs).
halfstep(cs,d).
halfstep(d,ds).
halfstep(ds,e).
halfstep(e,f).
halfstep(f,fs).
halfstep(fs,g).
halfstep(g,gs).
halfstep(gs,a).


%----------rules-----------------------------------

%intervals
thirdinterval(FirstNote,SecondNote) :-
	note(FirstNote),
	note(SecondNote),
	halfstep(FirstNote,A),
	halfstep(A,B),
	halfstep(B,C),
	halfstep(C,SecondNote).

minorthirdinterval(FirstNote,SecondNote) :-
	note(FirstNote),
	note(SecondNote),
	halfstep(FirstNote,A),
	halfstep(A,B),
	halfstep(B,SecondNote).


fifthinterval(FirstNote,SecondNote) :-
	note(FirstNote),
	note(SecondNote),
	halfstep(FirstNote,A),
	halfstep(A,B),
	halfstep(B,C),
	halfstep(C,D),
	halfstep(D,E),
	halfstep(E,F),
	halfstep(F,SecondNote).

flattedfithinterval(FirstNote,SecondNote) :-
	note(FirstNote),
	note(SecondNote),
	halfstep(FirstNote,A),
	halfstep(A,B),
	halfstep(B,C),
	halfstep(C,D),
	halfstep(D,E),
	halfstep(E,SecondNote).


%need 11
majorseventhinterval(FirstNote,SecondNote) :-
	note(FirstNote),
	note(SecondNote),
	halfstep(FirstNote,A),
	halfstep(A,B),
	halfstep(B,C),
	halfstep(C,D),
	halfstep(D,E),
	halfstep(E,F),
	halfstep(F,G),
	halfstep(G,H),
	halfstep(H,I),
	halfstep(I,J),
	halfstep(J,SecondNote).

%need 10 steps
dominantseventhinterval(FirstNote,SecondNote) :-
	note(FirstNote),
	note(SecondNote),
	halfstep(FirstNote,A),
	halfstep(A,B),
	halfstep(B,C),
	halfstep(C,D),
	halfstep(D,E),
	halfstep(E,F),
	halfstep(F,G),
	halfstep(G,H),
	halfstep(H,I),
	halfstep(I,SecondNote).

inform(TypeOfCord,Root,Second,Third,Fourth) :-
	write([TypeOfCord,chord,for,root,Root,is,Root,Second,Third,Fourth]),nl.

inform(TypeOfCord,Root,Second,Third) :-
	write([TypeOfCord,chord,for,root,Root,is,Root,Second,Third]),nl.

%chords 
majorchord(Root) :-
	thirdinterval(Root,ThirdNote),
	fifthinterval(Root,FifthNote),
	inform(major,Root,ThirdNote,FifthNote).


minorchord(Root) :-
	minorthirdinterval(Root,ThirdNote),
	fifthinterval(Root,FifthNote),
	inform(minor,Root,ThirdNote,FifthNote).


majorseventhchord(Root) :-
	thirdinterval(Root,ThirdNote),
	fifthinterval(Root,FifthNote),
	majorseventhinterval(Root,Seventh),
	inform(majorseventh,Root,ThirdNote,FifthNote,Seventh).

dominantseventhchord(Root) :-
	minorthirdinterval(Root,ThirdNote),
	fifthinterval(Root,FifthNote),
	dominantseventhinterval(Root,Seventh),
	inform(dominantseventh,Root,ThirdNote,FifthNote,Seventh).

%main entry point for running of queries

go :-

tell('prologForMusiciansOutput.txt'),

write('Prolog For Muscicians test cases:'),nl,

write('1) Major chord rooted at C'),nl,
majorchord(c),
nl,

write('2) Major chord rooted at G'),nl,
majorchord(g),
nl,

write('3) Major chord rooted at C#'),nl,
majorchord(cs),
nl,

write('4) Major Seventh chord rooted at C'),nl,
majorseventhchord(c),
nl,

write('5) Major Seventh chord rooted at A'),nl,
majorseventhchord(a),
nl,

write('6) Minor chord rooted at D'),nl,
minorchord(d),
nl,

write('7) Minor chord rooted at E'),nl,
minorchord(e),
nl,

write('8) Dominant Seventh chord rooted at F'),nl,
dominantseventhchord(f),
nl,

write('9) Dominant Seventh chord rooted at B'),nl,
dominantseventhchord(b),
nl,

write('10) Dominant Seventh chord rooted at G#'),nl,
dominantseventhchord(gs),
nl,
told.
%end of go

