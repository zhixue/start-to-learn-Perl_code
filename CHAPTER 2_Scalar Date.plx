####CHAPTER 2 Scalar Data####

##Numbers
####Floating-Point Literals
#		1.25
#		255.000
#		255.0
#		7.25e45		#7.25 times 10 to the 45th power(a bing number)
#		-6.5e24		#negative 6.5 tiems 10 to the 24th
#				(a big negative number) 
#		-12e-24		#negative 12 times 10 to the -24th
#				#(a very small negative number)
#		-1.2E-23	#another wat to say that - the E may be uppercase

####Integer Literals
#		61298040283768 == 61_298_040_283_768	#Perl allows underscores for clarity within integer literals

####Non-Decimal Integer Literals
#		0377		#377 octal ,same as 255 decimal
#		0xff		#FF hex,also 255 decimal
#		0b11111111	#also 266 decimal
#		0x13770B77 == 0x1377_0B77
#		0x5065727C == 0x50_65_72_7C

####Numeric Operators
#		2 + 3		# 2 plus 3, or 5
#		5.1 - 2.4 	# 5.1 minus 2.4, or 2.7
#		3 * 12		# 3 times 12 = 36
#		14 / 2 		# 14 divided by 2, or 7
#		10.2 / 0.3	# 10.2 divided by 0.3, or 34
#		10 / 3 		# always floating-point divide, so 3.33333333......
#		10 % 3 		# the remainder when 10 divided by 3, which is 1 
#		10.5 % 3.2 == 10 % 3
#Perl provides the FORTRAN-like expinentiation operator,which many have yearned for in Pascal and C.
#		2 ** 3		#two to the third power, or 8

##Strings
#sequences of characters(like hello)

####Singl-Quoted String Literals
#A single-quoted string literal is a sequence of characters enclosed in single quotes.
#		'fred'		#those four characters:f, r, e, and d
#		'barney'	#those six characters
#		''		#the null string(no characters)
#		'Don't let an apostrophe end this string permaturely!'
#		'the last character of this string is a backslash: \\'
#		'hello\n'	#hello followed by backslash followed by n
#		'hello
		there'		#hello,newline, there (11 characters total)
#		'\'\\'		#single quote followed by backslash

####Double-Quoted String Literals
#A double-quoted string literal is similar to the strings you may have seen in other language.
#		"barney"	#just the same as 'barney'
#		"hello world\n"	#hello world, and a newline
#		"The last character of this string is a quote mark: \""
#		"coke\tsprite"	#coke, a tab, and sprtite
#Table Double-quoted string backslash escapes
#	Construct	Meaning
#	\n		Newline
#	\r		Return
#	\et		Tab
#	\f		Formfeed
#	\b		Backspace
#	\a		Bell
#	\e		Escape(ASCII escape character)
#	\007		Any  octal ASCII value(here,007=bell)
#	\x7f		Any hex ASCII value(here,7f=delete)
#	\cC		A "control" character(Here,Ctrl+C)
#	\\		Backslash
#	\"		Double quote
#	\l 		Lowercase next letter
#	\L 		Lowercase all following letters until \E
#	\u		Uppercase next letter
#	\U 		Uppercase all following letters until \E
#	\Q		Quote non-word characters by adding a bachslash until \E
#	\E		End \L,\U,or \Q

####String Operators
#String values can be concaternated with the . operator.(that's a single period.)
#		"hello" . "world"	#same as "helloworld"
#		"hello" .  ' ' . "world"#same as "hello world"
#		"hello world" . "\n"	#same as "hello world\n"
#A special string operator is the string repetition operator,consisting of the single lowercase letter x.
#		"fred" x 3		#is "fredfredfred"
#		"barney" x (4+1)	#is "barney" x 5
#		5 x 4			#is really "5" x 4 ,which is "5555"
#		5 x 4.5			#is 5 x 4 ,which is "5555"

####Automatic Conversion Between Numbers and Strings
#		"12" * "3"		# 36
#		"12fred34" * "3"	# 36
#		"Z" . 5 * 7		# same as "Z" . 35 or "Z35"

##Perl's Built-in Warning
#Perl can be told to warn you when it sees something suspicious going on in your program.
#		$perl -w my_program
#or 		#!/usr/bin/perl -w
#or 		#!perl -w
#With Perl 5.6 or later
#		#!/usr/bin/per
#		use warnings;
#If you get a warning message you don't understand,you can get alonger description of the problem with the diagnostics pragma.
#		#!/usr/bin/perl
#		use diagnostics;
#A further optimization can be had by using one of Perl's command-line option, -M,to load the pragma only when needed instead of editing the source code each time to enable and disable diagnostics:
#		$perl -Mdiagnostics ./my_program

##Scalar variables
#A variable is a name for a container that holds one or more values.
#Scalar variable names begin with a dollar sign followed by what we'll call a Perl identifier.
#Uppercase and lowercase letters are distinct.

##Choosing Good Variable Names
#You should generally select variable names that mean something regarding the purpose of the variable.

##Scalar Assignment
#The most common operation on a scalar variable is assignment,which is the way to give a value to a varable.
#		$fred	=17;		#give $fred the value of 17
#		$barney	='hello';	#give $barney the five-character string 'hello'
#		$barney =$fred + 3;	#give $barney the current value of $fred plus 3 (20)
#		$barney =$barney * 2;	#$barney is now $barney multplied by 2 (40)

##Binary Assignment Operators
#		$fred 	=$fred + 5;	#without the binary assignment operator
#		$fred  += 5;		#with the binary assignment operator
#		$barney = $barney * 3	# equivalent: $barney *= 3
#		$str   .= " "		# equivalent: $str = $str . " "
#Nearly all binary operator are valid this way,such as **. 

##Output with print
#		print "The answer is ";
#		print 6 * 7;
#		print ".\n";
#		print "The answer is ", 6 * 7,".\n";

##Imterpolation of Scalar Variables into Strings
#When a string literal is double-quoted,it is subject to variable interpolation besides being checked for a backslash escaped.
#		$meal = "brontosaurus steak";
#		$barney = "fred ate a $meal";	#$barney is now "fred ate a brontosaurus steak"
#		$barney = 'fred ate a ' . $meal #another way to write that
#Don't bother with interpolating if you have the one lone variable:
#		print "$fred";		#unneeded quote marks
#		print $fred;		#better style
#To put a real dollar sign into a double-quoted string,precede the dollar sign with a backslash,which turns off the dollar sign's special significance:
#		$fred = "hello"		
#		print "The name is \$fred.\n"	#prints a dollar sign
#		print 'The name is $fred' . "\n"#so does this
#Perl provides a delimiter for the variable name in a manner similar to the shell.Enclose the name of the variable in a pair of curly braces.Or you can end that part of the string and start another part of the string with a concatenation operator:
#		$what = "brontosaurus steak";
#		$n = 3;			
#		print "fred ate $n $whats.\n";	#not the steaks, but the value of $whats
#		print "fred ate $n ${what}s.\n";#now uses $what
#		print "fred ate $n $what" . "s.\n"; #another way to do it 
#		print 'fred ate ' . $n . ' ' . $what . "s.\n" #an especially difficult way

##Operator Precedence and Associativity
#Table Associativity and precedence of operators(highest to lowest)
#	Associativity 	Operators
#	left		Parentheses and arguments to list operators
#	left		->
#			++--(autoincrement and autodecrement)
#	right		**
#	right		\!~+-(unary operators)
#	left		=~!~
#	left		*/%x
#	left		+-.(binary operators)
#	left		<<>>
#			Named unary operators(-X filetests,rand)
#			< <= > >= lt le gt ge(the "unequal" ones)
#			== != <=> eq ne cmp(the "equal" ones)
#	left		&
#	left		|^
#	left		$$
#	left 		||
#			.. ...
#	right		?:(temary)
#	right 		= += -= .=(and similar assignment operators)
#	left		, =>
#			List operators(rightward)
#	right		not
#	left		and
#	left		or xor

#Like precedence,associativity resolves the order of operations when two operators of the same precedence compete for three operands:
#		4 ** 3 ** 2	 		# 4 ** (3 ** 2), or 4 ** 9 (right associative)
#		72 / 12 /3 			# (72 / 12) / 3, or 6 / 3 ,or 2(left assiciative)
#		36 / 6 * 3			# (36 / 6) * 3 ,or 18

##Comparison Operators
#Table Numeric and string comparison operators
#	Comparison		Numeric		String
#	Equal			==		eq
#	Not equal		!=		ne
#	Less than		<		lt
#	Greater than		>		gt
#	Less than or equal to 	<=		le
#	Greater than or equal to>=		ge

#Here are some example expressions using these comparison operators:
#		35 != 30 + 5			#false
#		35 == 30 + 5			#true
#		'35' eq '35.0'			#false(comparing as strings)
#		'fred' lt 'barney'		#false
#		'fred' lt 'free'		#true
#		'fred' eq "fred"		#true
#		'fred' eq 'Fred'		#false
#		' ' gt ''			#true

##The if Control Structure
#Perl has an if control structure:
	if($name gt 'fred'){
	  print "'$name' comes after 'fred' in sorted order.\n";
	}
#If you need an alternative choice,the else keyword provides that as well:
	if($name gt 'fred'){
	  print "'$name' comes after 'fred' in sorted order.\n";
	} else{
	  print "'$name' does not come after 'fred' .\n";
	  print "Maybe it's the same string,in fact.\n";
	}

##Boolean Values			
	$is_bigger = $name gt 'fred';
	if(! $is_bigger){
	  #Do something when $is_bigger is not true
	}

##Getting User Input
	$line = <STDIN>;
	if($line eq "\n"){
	  print "That was just a blank line!\n";
	}else{
	  print "That line of input was: $line";
	}
#In practice, you don't often want to keep the newline, so you need the chomp operator.

##The chomp Operator
#The first time you read about the chomp operator,it seems overspecoalized. It works on a variable,and the variable has to hold a string.If the string ends in a newline character,chomp can get rid of the newline.That's (nearly) all it does as in this example:
	$text = "a line of text\n";		#Or the same thing from <STDIN>
	$chomp($text);				#Gets rid of the newline character
#chomp is a function.As a function, it has a return value,which is the number of characters removed.This number is hardly ever useful:
	$food = <STDIN>;
	$betty = chomp $food;			# gets the value 1 - but you knew that!
#If a line ends with two or more newlines,chomp removes only one.If there's no newline, it does nothing and return zero.

##The while Control Structure
	$count = 0;
	while($count < 10){
	  $count += 2;
	  print "count is now $count\n";	#Gives values 2 4 6 8 10
	}

##The undef value
#undef is neither a number nor a string;it's an entirely separate kind of scalar value.
#	Add up some odd numbers
	$n = 1;
	while($n < 10){
	  $sum += $n;
	  $n += 2;				#On to the next odd number
	}
	print "The total was $sum.\n";
#Similarly,you could have a string accumulator that starts out empty:
	$string .= "more text\n";

##The defined function
#To tell if a value is undef and not the empty string, use the defined function,which returns false for undef and true for everything else:
	$madonna = <STDIN>;
	if(defined($nadonna)){
	  print "The input was $madonna";
	}else{
	  print "No input available!\n";
	}
#If you'd like to make your own undef values,you can use the obscurely named undef operator:
	$madonna = undef; 			#As if it had never been touched

##Exercises
#See Appendix A for answers to the following exercises:
#1.[5]Write a program that computes the circumference of a circle with a radius of 12.5.Circumferenceis 2pai times the radius(approximately 2times 3.141592654).The answer you get should be about 78.5.
#2.[4]Modify the program from the previous exrcise to prompt for and accept a radius from the person running the program,So,if users enter 12.5 for the radius,they should get the same number as in the precious exercise.
#3.[4]Modify the program from the previous exercise so,if the user enters a number less than zero,the reported circumference will be zero,rather than negative.
#4.[8]Write a program that prompt fpr and reads two numbers(on separate lines of input) and prints out the product of the two numbers multiplied together.
#5.[8]Write a program that prompt fpr and reads a string and a number(on separate lines of input)and prints out the string the number of times indicated by the number on separate lines.(Hint:Use the "x" operator.)If the user enters "fred" and "3", the output should be three lines,each saying "fred".if the user enters "fred" and "299792",there may be a lot of output. 	