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
	halfstep(I,SecondNote).

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
	halfstep(H,SecondNote).

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

majorchord(c),

majorchord(g),

majorchord(cs),

majorseventhchord(c),

majorseventhchord(a),

minorchord(d),

minorchord(e),

dominantseventhchord(f),

dominantseventhchord(b),

dominantseventhchord(gs).
%end of go

