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
	halfstep(FirstNote,A),
	halfstep(A,B),
	halfstep(B,C),
	halfstep(C,SecondNote).

minorthirdinterval(FirstNote,SecondNote) :-
	halfstep(FirstNote,A),
	halfstep(A,B),
	halfstep(B,SecondNote).


fifthinterval(FirstNote,SecondNote) :-
	halfstep(FirstNote,A),
	halfstep(A,B),
	halfstep(B,C),
	halfstep(C,D),
	halfstep(D,E),
	halfstep(E,F),
	halfstep(F,SecondNote).

flattedfithinterval(FirstNote,SecondNote) :-
	halfstep(FirstNote,A),
	halfstep(A,B),
	halfstep(B,C),
	halfstep(C,D),
	halfstep(D,E),
	halfstep(E,SecondNote).

majorseventhinterval(FirstNote,SecondNote) :-
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

dominantseventh(FirstNote,SecondNote) :-
	halfstep(FirstNote,A),
	halfstep(A,B),
	halfstep(B,C),
	halfstep(C,D),
	halfstep(D,E),
	halfstep(E,F),
	halfstep(F,G),
	halfstep(G,H),
	halfstep(H,SecondNote).


%%chords 
%majorchord(Root) :-
%
%
%minorchord(Root) :-
%
%
%majorseventhchord(Root) :-
%
%
%dominantseventhchord(Root) :-
%

