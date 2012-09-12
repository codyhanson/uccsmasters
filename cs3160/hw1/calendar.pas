{CS 3160 HW1. UCCS fall 2012. Cody Hanson}
PROGRAM calendar; 

	Uses sysutils; { for string formatting}

	VAR month : Integer;
	    year  : Integer;
	    input : String;
	    boolIsLeapYear : Boolean; 
	    fmt,S : string;

	FUNCTION IsLeapYear(Year: Integer): BOOLEAN;
	{Returns TRUE if Year is a leap year, else FALSE}
	BEGIN
	{Leap if Divisible by 4; except century must be divisible by 400}
	IsLeapYear := (Year MOD 4 = 0) AND
		      ((Year MOD 100 <> 0) OR (Year MOD 400 = 0));
	END; {IsLeapYear}
	
	FUNCTION getMonthName(month:Integer) : string;
	BEGIN
		Case month of
		1 : 	getMonthName := 'January';
		2 : 	getMonthName := 'February';
		3 : 	getMonthName := 'March';
		4 : 	getMonthName := 'April'; 
		5 : 	getMonthName := 'May'; 
		6 : 	getMonthName := 'June'; 
		7 : 	getMonthName := 'July'; 
		8 : 	getMonthName := 'August'; 
		9 : 	getMonthName := 'September'; 
		10 : 	getMonthName := 'October'; 
		11 : 	getMonthName := 'November'; 
		12 : 	getMonthName := 'December'; 
		End; {case}	
	END;

	FUNCTION numberDaysInMonth(monthParam : Integer; yearParam : Integer): Integer; 
	BEGIN
		{returns the number of days in a month, taking into acount leap years} 
		Case monthParam of
		1 : 	numberDaysInMonth := 31;
		2 : 	Begin 
			if (IsLeapYear(yearParam) = True) then 
				numberDaysInmonth := 29
			else
				numberDaysInMonth := 28; 
			End;
		3 : 	numberDaysInMonth := 31; 
		4 : 	numberDaysInMonth := 30; 
		5 : 	numberDaysInMonth := 31; 
		6 : 	numberDaysInMonth := 30; 
		7 : 	numberDaysInMonth := 31; 
		8 : 	numberDaysInMonth := 31;
		9 : 	numberDaysInMonth := 30; 
		10 : 	numberDaysInMonth := 31; 
		11 : 	numberDaysInMonth := 30; 
		12 : 	numberDaysInMonth := 31;
		End; {case}
	END; 

	FUNCTION computeStartDay(monthParam : Integer; yearParam : Integer): Integer;
	VAR currYear : Integer;
	day : Integer;
	currMonth : Integer; 
	BEGIN
	{returns the day of the week (by number) that the month starts on}	
	{year 1600 January started on a saturday}
	{S:0 M:1 T:2 W:3 R:4 F:5 S:6}

	currMonth := 1;
	currYear := 1600;	
	day := 6; {1600 started on saturday} 

	while (curryear < yearParam) do
	begin
		if (isLeapYear(currYear) = true) then
			day := day + 366
		else
			day := day + 365;

		day := day MOD 7;

		currYear := currYear + 1;
	end;

	{we are in the right year, now add up the months}
	while (currMonth < monthParam) do 
	begin

		day := day + numberDaysInMonth(currMonth,currYear);
		currMonth := currMonth + 1;	
	end; 
		
	computeStartDay := day MOD 7;

	END;
	
	PROCEDURE writeSeparator;
	begin
		Writeln('|---------------------------|');
	end;

	PROCEDURE writeDays;
	begin
		Writeln('| S | M | T | W | R | F | S |');
	end;

	PROCEDURE writeRows (month : integer; year : integer);
	Var startDay : Integer;
		day : Integer;
		posptr : Integer;
		numDays : Integer;	
		linestr : string;
		strArray : Array[0..6] of String;
	
	begin

		{clear junk from string array}
		for posPtr := 0 to 6 do
			strArray[posPtr] := '';

		numDays := numberDaysInMonth(month,year);
		startDay := computeStartDay(month,year);
		posptr := startDay;
		day := 1;
		fmt := '|%0:3s|%1:3s|%2:3s|%3:3s|%4:3s|%5:3s|%6:3s|';
		Repeat 
			strArray[posptr] := IntToStr(day);
			day := day + 1;
			posPtr := (posPtr + 1) MOD 7;
			if posPtr = 0 then begin	
			linestr := Format(fmt,[strArray[0],strArray[1],strArray[2],strArray[3],strArray[4],strArray[5],strArray[6]]);
			writeln(linestr); 
			writeSeparator
			end; 
		Until (day > numDays);

		{finish the row}
		if posPtr > 0 then begin
			for posPtr := posPtr to 6 do 
			strArray[posPtr] := '';

			linestr := Format(fmt,[strArray[0],strArray[1],strArray[2],strArray[3],strArray[4],strArray[5],strArray[6]]);
			writeln(linestr); 
		end;
		writeSeparator;
		
	end;




BEGIN
	writeln('#######################################');
	writeln('calendar starting');

	year := 0;
	month := 0;

	{get user input for month and year, repeat until they get it right}
	REPEAT 
		write('Enter a year (1600-2400):');
		Readln(year);
		writeln(year)	
	Until (year >=  1600) AND (year <= 2400);

	REPEAT 
		write('Enter a month (1-12):');
		Readln(month);
		writeln(month)	
	Until (month >=  1) AND (month <= 12);

	{input is now good.}
	writeSeparator;
	fmt := '|%0:13s %1:-13s|'; 
	S:= Format(fmt,[getMonthName(month),IntToStr(year)]);
	writeln(S);         	
	writeDays;
	writeSeparator;
	writeRows(month,year);


	

END. {end of program}
