{CS 3160 HW1. UCCS fall 2012. Cody Hanson}
PROGRAM calendar; 

	VAR month : Integer;
	    year  : Integer;
	    input : String;
	    boolIsLeapYear : Boolean;

	FUNCTION IsLeapYear(Year: Integer): BOOLEAN;
	{Returns TRUE if Year is a leap year, else FALSE}
	BEGIN
	{Leap if Divisible by 4; except century must be divisible by 400}
	IsLeapYear := (Year MOD 4 = 0) AND
		      ((Year MOD 100 <> 0) OR (Year MOD 400 = 0));
	END; {IsLeapYear}
	
	FUNCTION numberDaysInMonth(month : Integer; year : Integer): Integer; 
	BEGIN
		{returns the number of days in a month, taking into acount leap years} BEGIN 
		numberDaysInMonth := 0;
	END;



BEGIN
	writeln('#######################################');
	writeln('calendar starting');

	year := 0;
	month := 0;
	{get user input for month and year, repeat until they get it right}
	REPEAT 
		write('Enter a year (1600-2400):');
		Readln(year);
		writeln(year);	
	Until (year >=  1600) AND (year <= 2400);

	REPEAT 
		write('Enter a month (1-12):');
		Readln(month);
		writeln(month);	
	Until (month >=  1) AND (month <= 12);

	boolIsLeapYear := IsLeapYear(year);	

	If (boolIsLeapYear = True) then
		writeln(year,' is a leap year')
	else
		writeln(year,' is NOT a leap year');


END. {end of program}
