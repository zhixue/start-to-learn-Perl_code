####CHAPTER 3 Lists and Arrays####

##Accessing Elements
#The array elements are numbered using sequential integers,begining at zero and increasing by one for each element,like this:
	$fred[0] = "yabba";
	$fred[1] = "dabba";
	$fred[2] = "doo";
	print $fred[0];
	$fred[2] = "diddley";
	$fred[1] .= "whatsis";
	$number = 2.71828;
	print $fred[$number - 1];	#Same as printing $fred[1]
	$blank = $fred[ 142_857 ];	#unsed array element gives undef
	$blanc = $mel;			#unused scalar $mel also gives undef

##Special Array Indices
	$rocks[0] = 'bedrock';		#One element
	$rocks[1] = 'slate';		#another
	$rocks[2] = 'lava';		#and another
	$rocks[3] = 'crushed rock';	#and another
	$rocks[99] = 'schist';		#now there are 95 undef elements
	$end = $#rocks;			# 99,which is the last element's index
	$number_of_rocks = $end + 1;	#okay,but you'll ss a better way later
	$rocks[$#rocks] = 'hard rock';	#the last rock
	$rocks[-1] = 'hard rock';	#easier way to do that last example
	$dead_rock = $rocks[-100];	#gets 'bedrock'
#	$rocks[-200] = 'crystal';	#fatal error!

##List Literals
#An array(the way you represent a list value within your program) is a list of comma-separated values enclosed in parentheses.These values form the elements of the list:
	(1,2,3)				#list of three values 1,2, and 3
	(1,2,3,)			#the same three three values(the trailing comma is ignored)
	("fred",4.5)			#two values, "fred" and 4.5
	()				#empty list - zero elements
	(1..100)			#list of 100 integers
	(1..5)				#same as (1,2,3,4,5)
	(1.7..5.7)			#same thing -both values are truncated
	(5..1)				#empty list -..only counts "uphill"
	(0,2..6,10,12)			#same as (0,2,3,4,5,6,10,12)
	($m..$n)			#range determined by current values of $m and $n
	(0..$#rocks)			#the indices of the rocks array from the previous section
	($m,17)				#two values: the current value of $m,and 17
	($m+$o,$p+$q)			#two values
	("fred","barney","betty","wilma","dino") #scalar values

####The qw Shortcut
#The qw shortcut makes it easy to generate them without typing a lot of extra quote marks:
	qw( fred barney betty wilma dino ) #same as above, but less typing
	qw(fred
	barrney betty
	wilma dino)			#same as above,but pretty strange whitespace
#Perl lets you choose any punctuation charaacter as the delimiter.
	qw! fred barney betty wilma dino !
	qw# fred barney betty wilma dino # #like in a comment!
	qw( fred barney betty wilma dino )
	qw{ fred barney betty wilma dino }
	qw[ fred barney betty wilma dino ]
	qw< fred barney betty wilma dino >
#IF you need to include the closing delimiter within the string as one of the chaaracters, you probably picked the wrong delimeter.But if you can't or don't want to change the delimiter,you can include the character using the backslash:
	qw! yahoo\! google excite lycos ! #include yahoo! as an element 
#But even here,it could be useful if  you were to need a list of Unix filenames:
	qw{
	  /usr/dict/words
	  /home/rootbeer/.ispell_english
	}
#That list would be inconvenient to read,write, and maintain if the slash were the only available delimiter.

##List Assignment
#In much the same way as scalar values,list values may be assigned to variables:
	($fred,$barney) = ($barney,$fred);	#swap those values
	($betty[0],$betty[1]) = ($betty[1],$betty[0]);
	($fred,$barney) = qw< filename rublle slate granite >; #two igored items
	($wilma,$dino) = qw[flintstone];	# $dino gets undef
	($rocks[0],$rocks[1],$rocks[2],$rocks[3]) = qw/talc mica feldspar quartz/;
#But when you wish to refer to an entire array,Perl has a simpler notation.Just use the at sign(@) before the name of the array(and no index brackets after it) to refer to the entire array at once.You can read this as "all of the",so @rocks is "all of the rocks."This works on either side of the assignment operator:
	@rocks = qw/ bedrock slate lava /;
	@tiny = ();				#the empty list
	@giant = 1..1e5;			#a list with 100,000 elements
	@stuff = (@giant,undef,@giant);		#a list with 200,001 elements
	$dino = "granite";
	@quarry = (@rocks,"crushed rock",@tiny,$dino);
#When an array is copied to another array, it's still a list assignment.The lists are stored in arrays as in this example:
	@copy = @quarry;			#copy a list from onTe array to another

####The pop and push Operators
#The pop operator takes the last element off of an array and returns it:
	@array = 5..9
	$fred = pop(@array)			# $fred gets 9 ,@array now has (5,6,7,8)
	$barney = pop @array			# $barney gets 8,@array now has (5,6,7)
 	pop @array				# @array now has (5,6).(The 7 is discarded.)
#The converse operation is push,which adds an element(or a list of elements) to the end of an array:
	push(@array,0);				# @array now has (5,6,0)
	push @array,8;				# @array now has (5,6,0,8)
	push @array,1..10;			# @array now has those 10 new elements
	@others = qw/ 9 0 2 1 0 /;
	push @array,@others;			# @array now has those five new elements (19 total)

####The shift and unshift OPerators
#The unshift and shift operators perform the corresponding actions on the "start" of the array(the "left" side of an array or the portion with the lowest subscripts).Here are a few examples:
	@array = qw# dino fred barney #;
	$m = shift(@array); 			# $m gets "dino",@array now has ("fred","barney")
	$n = shift @array;			# $n gets "fred',@array now has ("barney")
	shift @array;				# array is now empty
	$o = shift @array;			# $o gets undef,@array is still empty
	unshift(@array,5);			# @array now has the one-element list (5)
	unshift @array,4;			# @array now has (4,5)
	@others = 1..3;
	unshift @array,@others;			# @array now has (1,2,3,4,5)
#Analogous to pop,shift returns undef if given an empty array variable.

##Interpolating Arrays into Strings
#elements of an array are automatically separated by spaces upon interpolation:
	@rocks = qw{ flintstone slate rubble };
	print "quartz @rocks limestone\n";	#prints five rocks separated by spaces
	print "Three rocks are: @rocks.\n";
	print "There's nothing in the parens (@empty) here .\n";
	$email = "fred@bedrock.edu";		#WRONG! Tries to interpolate @bedrock
	$email = "fred\@bedrock.edu";		#Correct
	$email = 'fred@bedrock.edu';		#Another way to do that
	@fred = qw(hello dolly);
	$y = 2;
	$x = "This is $fred[1]'s place";	# "This is dolly's place"
	$x = "This is $fred[$y-1]'s place";	# same thing
	@fred = qw(eating rocks is wrong);
	$fred = 'right';			#we are trying to say "this is right[3]"
	print "this is $fred[3]\n";		#prints "wrong" using $fred[3]
	print "this is ${fred}[3]\n";		#prints "right" (protected by braces)
	print "this is $fred"."[3]\n";		#right again(different string)
	print "this is $fred\[3]\n";		#right again(backslash hides it)

##The foreach Control Structure
#The foreach loop steps through a list of values ,executing one iteration(time through the loop)for each value:
	foreach $rock (qw/ bedrock slate lava /){
	  print "One rock is $rock.\n";		#Prints names of three rocks
	}
#Thie control variable is not a copy of the list element-it actually is the list element.That is ,if you modify the control variable inside the loop,you 'll be modifying the element in the original	list,as shown in the following code snippet,This is useful and supported,but it would surprise you if you weren't expecting it.
	@rocks =qw/ bedrock slate lava /;
	foreach $rock(@rocks){
	  $rock = "\t$rock";			#put a tab in front of each element of @rocks
	  $rock .= "\n";			#put a newline on the end of each
	}
	print "The rocks are:\n", @rocks;	#Each one is indented,on its own line

####Perl's Favorite Default:$_
#If you omit control variable from the beginning of the foreach loop,Perl uses its favorite default variable,$_.This is (mostly) like any other scalar variable,except for its unusual name,as in this example:
	foreach (1..10){ 			#uses $_ by default
	  print "I can count to $_!\n"; 	
	}
#Not to keep you in suspense,one of those cases is print,which prints $_ if given no other argument:
	$_ = "Yabba dabba doo\n";
	print;					#print $_ by default

####The reverse Operator
#The reverse operator takes a list of values (which may come from an array) and returns the list in the opposite order.If you were disappointed that the range operator,...only counts upward,this is the way you fix it:
	@fred = 6..10;
	@barney = reverse(@fred);		#gets 10,9,8,7,6
	@wilma = reverse 6..10;			#gets the same thing,without the other array
	@fred = reverse @fred;			#puts the result back into the original array
#Remember that reverse returns the reversed list;it doesn't affect its arguments;If the retrun value isn't assigned anywhere,it's useless:
	reverse @fred:				#WRONG - doesn't change @fred
	@fred = reverse @fred			#that's better

####The sort Operator
	@rocks = qw/ bedrock slate rubble granite /;
	@sorted = sort(@rocks);			#gets bedrocks,granite,rubble,slate
	@back = reverse sort @rocks;		#these go from slate to bedrock
	@rocks = sort @rocks;			#puts sorted result back into @rocks
	@numbers = sort 97..102;		#gets 100,101,102,97,98,99
#Like whate happened with reverse, the arguments themselves aren't affected.
	sort @rocks;				#WRONG,doesn't modify @rocks
	@rocks = sort @rocks;			#now the rock collection is in order

##Scalar and list context
#As Perl is parsing your expressions, it always expects a scalar or list value.What Perl expects is called the context of the expression.
	42 + something				#The something must be a scalar
	sort something				#The something must be a list
#In a list context,it gives the list of elements.But in a scalar context,it returns the number of elements in the array:
	@people = qw( fred barney betty );
	@sorted = sort @people;			#list context: barney,betty,fred
	$number = 42 + @people;			#scalar context:42 + 3 gives 45
#Even ordinary assignment(to a scalar or a list) cause different context:
	@list = @people;			#a list of three people
	$n = @people;				#the number 3

####Using List-Producing Expressions in Scalar Context
	@backwards = reverse qw/ yabba dabba doo /;	#gives doo,dabba,yabba
	$backwards = reverse qw/ yabba dabba doo /;	#gives oodabbadabbay
#Here are some common contexts to start you off:
	$fred = something;			#scalar context
	@pebbles = something;			#list context
	($wilma,$betty) = something;		#list context
	($dino) = something;			#still list context!
#Let's look at other expressions you've seen and the contexts they provide.First,here are some that provide scalar context to something:
	$fred = something;
	$fred[3] = something;
	123 + something
	something + 654
	if(something){...}
	while(something){...}
	$fred[something] = something;
#Here are some that provide a list context:
	@fred = something;
	($fred,$barney) = something;
	push @fred, something;
	foreach $fred (something){...}
	sort something
	reverse something
	print something

####Using Scalar-Producing Expression in List Context
	@fred = 6 * 7;				#gets one-element list (42)
	@barney = "hello" . '' . "world";
#Well,there's one possible catch:
	@wilma = undef;				#OOPS!Gets the one-element list (undef)
	  # which is not the same as this:
	@betty = ();				#A correct way to empty an array

####Forcing Scalar Context
#Function scalar is not a true function because it just tells Perl to provide a scalar context:
	@rocks = qw( talc quartz jade obsidian );
	print "How many rocks do you have?\n";
	print "I have ",@rocks," rocks!\n";	#WRONG,prints names of rocks
	print "I have ",scalar @rocks, " rocks!\n";	#Correct,gives a number

##<STDIN> in List Context
#Now, in list context,this operator returns all of the remaining lines up to the end of file.Each line is returned as separate element of the list as in this example:
	@lines = <STDIN>;			#read standard input in list context
#Unix/Linux/Mac OS X--Ctrl + D
#DOS/Windows-- Ctrl + Z
	chomp(@lines)				#discard all the newline characters
	chomp(@lines = <STDIN>);		#read the lines ,not the newlines

##Exercise
#See Appendix A for answers to the following exercises:
#1.[6]Write a program that reads a list of strings on separate lines until end-of-input and prints out the list in reverse order.If the input comes from the keyboard,you'll probably need to signal the end of the input by pressing Ctrl-D on Unix or Ctrl-Z on Windows.
#2.[12]Write a program that reads a list of numbers(on separate lines) until end-of-input and then prints for each number the corresponding person's name from the list shown below.(Hardcode this list of names into your program.That is, it should appear in your program's source code.) For example,if the input numbers were 1,2,4, and 2,the output names would be fred,betty,dino,and betty:
	fred betty barney wilma pebbles bamm-bamm
#3.[8]Write a program that reads a list of string (on separate lines) until end-of-input.Then it should print the strings in ASCIIbetical order.That is, if you enter the string fred,barney,wilma,betty,the output should show barney betty fred wilma.Are all of the strings on one line in the output,or on separate lines?Could you make the output appear in either style?
	
