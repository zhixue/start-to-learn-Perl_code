####CHAPTER 5 Input and Output####

##Input from Standard Input
	$line = <STDIN>;	#read the next line
	chomp($line);		#and chomp it

	chomp($line = <STDIN>);	#same thing,more idiomatically
	
	while (defined($line = <STDIN>)) {
	  print "I saw $line";
	}

	while (<STDIN>) {
	  print "I saw $_";
	}

	while (defined($_ = <STDIN>)) {
	  print "I saw $_";
	}

	foreach(<STDIN>) {
	  print "I saw $_";
	}

##Input from the Diamond Operator
	$./my_program fred barney betty
#The diamond operator is a special kind of line-input operator.Instead of getting the input from the keyborad,it comes from the user's choice of input:
	while (defined($line = <>)) {
	  chomp($line);
	  print "It was $line that I saw!\n";
	}
#Since this is a special kind of line-operator,we may use the same shortcut we saw earlier to read the input into $_ by deflaut:
	while(<>) {
	  chomp;
	  print "It was $_ that I saw!\n";
	}

##The Invocation Arguments
#The diamond operator looks in @ARGV to determine what filenames it should use.
	@ARGV = qw# larry moe curly #;	#force these three files to be read
	while( )<> {
	  chomp;
	  print "It was $_ that I saw in some stooge-like file!\n";
	}

##Output to Standard Output
	$name = "Larry Wall";
	print "Hello there,$name, did you know that 3+4 IS ",3+4,"?\n";

	print @array;	#print a list of items
	print "@array";	#print a string (containing an interpolated array)

	print <>;	#source code for 'cat'
	print sort <>;	#source code for 'sort'
#To be fair,the standard Unix commands cat and sort do have some additional functionality that these replacements lack,but you can't beat them for the price!
#Here are two way to print the same thing:
	print("Hello,world!\n");
	print "Hello,world!\n";
#It nearly always succeeds unless you get some I/O error, so the $result in the following statement will normally be 1:
	$result = print("hello world!\n");
	
	print (2+3)*4;
#It prints 5.Then it takes the return value from print,which is 1,and multiplies that times 4.
#It's the same to Perl as if you'd said this:
	( print(2+3) ) * 4;	#Oops!
#Use -w,or use warnings,at least during program development and debugging.

##Formatted Output with printf
 	printf "Hello,%s; your password expires in %d days!\n",$user,$days_to_die;	#Hello,merlyn; your password expires in 3 days!
	printf "%g %g %g\n", 5\2, 51\17, 51 ** 17;	# 2.5 3 1.0583e+29
	printf "in %d days!\n",17.85;	#in 17 days!
	printf "%6d\n",42;		#output like     42 
	printf "%2d\n",2e3 + 1.95;	#2001
	printf "%10s\n","wilma";	#looks like      wilma
	printf "%-15s\n","flintstone";	#looks like flintstone     
	printf "%12f\n",6* 7 + 2/3;	#looks like    42.666667
	printf "%12.3f\n", 6* 7 + 2/3;	#looks like       42.667
	printf "%12.0f\n", 6* 7 + 2/3;	#looks like           43
#To print a real percent sign,use %%
	printf "Monthly interest rate: %.2f%%\n",5.25\12;	#the value looks like "0.44%"

####Arrays and printf
	my @items = qw(wilma dino pebbles );
	my $format = "The items are:\n" . ("%10s\n" x @items);
	## print "the format is >>$format<<\n";	#for debugging
	printf $format,@items
#This uses the x operator to replicate the given string a number of times given by @items(which is being used in a scalar context).
	printf "The items are:\n".(%10s\n x @items), @items;

##Filehandles
	$./your_program <dino >wilma
#input should be read from the file dino,and output should go to the file wilma.
	$cat fred barney|sort|./your_program|grep something|lpr
#Pipelines like that are common in Unix and many other systems today.	
	$netstat|./your_program 2>/tmp/my_errors

##Opening a Filehandle
#Use the open operator to tell Perl to ask the operating system to open the connection between your program and the outside world.
	open CONFIG, "dino";
	open CONFIG, "<dino";
	open BEDROCK, ">fred";
	open LOG,">>logfile";
#You can use any scalar expression in place of the filename specifier,though typically you'll want to be explicit about the direction specification:
	my $selected_output = "my_output";
	open LOG,"> $selected_output";
#In modern versions of Perl(starting with Perl 5.6),you can use a "three-argument" open:
	open CONFIG,"<","dino";
	open BEDROCK,">",$file_name;
	open LOG,">>",&logfile_name();

####Bad Filehandles
	my $success = open LOG,">>logfile";	#capture the return value
	if ( ! $success) {
	  # The open failed
	}

####Closing a Filehandle
#When you are finished with a filehandle,you may close it with the close operator like this:
	close BEDROCK;

##Fatal Error with die
	if (! open LOG,">>logfile") {
	  die "Cannot create logfile: $!";
	}

	if (@ARGV < 2 ) {
	  die "Not enough arguments\n";
	}

####Warning Messages with warn
#Use the warn function to cause a warning that acts like one of Perl's built-en warnings.

##Using Filehandles
	if ( ! open PASSWD, "/etc/passwd") {
	  die "How did you get logged in? ($!)";
	}
	while (<PASSWD>) {
	  chomp;
	}
#A filehandle open for writing or appending may be used with print or printf,appearing immediately after the keyword but before the list of arguments:
	print LOG "Captain's log, stardare 3.14159\n";	#output goes to LOG
	printf STDERR "%d percent complete,\n", $done/$total * 100;
#either of following forms is correct:
	printf (STDERR "%d percent complete.\n",$done/$total * 100);
	printf STDERR ("%d percent complete.\n",$done/$total * 100);

####Changing the Default Output Filehandle
#By default,the output will go to STDOUT,but that default may be changed withe the select operator.
	select BEDROCK;
	print "I hope Mr. Slate doesn't find out about this .\n";
	print "Wilma!\n";
	
	select LOG;
	$| = 1;		#don't keep LOG entries sitting in the butter
	select STDOUT;
	# ... time passes, babies earn to walk,tectonic plates shift,and then...
	print LOG "This gets written to the LOG at once!\n";

##Reopening a Standard Filehandle
	#send error to my private error log
	if (! open STDERR, ">>/home/barney/.error_log") {
	  die "Can't open error log for append: $!";
	}

##Exercises
#See Appendix A for answers to the following exercises:
#1.[7]Write a program that acts like cat but reverses the order of the output lines.(Some systems have a utility like this named tac.)If you run yours as ./tac fred barney betty,the output should be all of file betty from the last line to the first,then barney and then fred,also from the last line to the first.(Be sure to use the ./ in your program's invocation if you call it tac so you don't get the system's utility instead!)
#2.[8]Write a program that asks the user to enter a list of strings on separate lines,printing each string in a right-justified 20-character column,To be cetain that the output is in the proper columns,print a "ruler line" of digits as well.(This is a debugging aid.)Make sure that you're not using a 19-character column by mistake.For example,entering hell,good-bye should give output someting like this:
	123456789012345678901234567890123456789012345678901234567890
		       hello
		    good-bye
#3.[8]Modify the previous program to let the user choose the column width,so entering 30,hello,good-bye(on separate line) would put the strings at the 30th column.(Hint:See the section in Chapter 2 about controlling cariable interpolation.) For extra credit, make the ruler line longer when the selected with is larger.
	