####CHAPTER 4 Subroutines####

##Defining a subroutine
	sub marine{
	  $n += 1;		#Global variable $n
	  print "Hello, sailor number $n!\n";
	}

##Invoking a Subroutine
	&marine;		#says Hello, sailor number 1!
	&marine;		#says Hello, sailor number 2!
	&marine;		#says Hello, sailor number 3!
	&marine;		#says Hello, sailor number 4!
#Most often,we refer to the invovation as calling the subroutine.

##Return Values
	sub sum_of_fred_and_barney {
	  print "Hey, you called the sum_of_fred_and_barney subroutine!\n";
	  $fred + $barney;	#That's the return value
	$fred = 3;
	$barney = 4;
	$wilma = &sum_of_fred_and_barney;	# $wilma gets 7
	print "\$wilma is $wilma.\n";
	$betty =3 * &sum_of_fred_and_barney;	# $betty gets 21
	print "\$betty id $betty.\n";

	sub sum_of_fred_and_barney {
	  print "Hey, you called the sum_of_fred_and_barney subroutine!\n";
	  $fred + $barney;	#That's not really the return value!
	  print "Hey, I'm returning a value now!\n";	#Because you add another line to the end of the code

	sub larger_of_fred_or_barney {
	  if ($fred > $barney) {
	    $fred;
	  } else {
	    $barney;
	  }
	}

##Arguments
	$n = &max(10,15);	#This sub call has two parameters
	sub max {
	  #Compare this to $larger_of_fred_or_barney
	  if ($_[0] > $_[1]){
	    $_[0];
	  } else {
	    $_[1];
	  }
	}
	$n = &max(10,15,27);	#Excess parameters are ignored.

##Private Varables in Subroutines
	sub max {
	  my($n,$n);		#new,private variables for this block
	  ($m,$n) = @_;		#give names to the parameters
	  if ($m>$n) ( $m ) else { $n }
	}
#You can create private variables called lexical variables at any time with the my operator.
#The first two statements in the subroutine can be combined.
	my($m,$n) = @_;		#Name the subroutine parameters

##Variable-Length Parameter Lists
#Of course,the subroutine can easily check that it has the right number of argument by examining the @_array.
	sub max {
	  if (@_ != 2) {
	    print "WARNING! &max should get exactly two arguments!\n";
	  }
	  #continue as before...
	}

####A Better &max Routine
	$maximum = &max(3,5,10,4,6);
	sub max {
	  my($max_so_far) = shift @_;	# the first one is the largest yet seen
	  foreach (@_) {
	    if ($_ > $max_so_far) {
	      $max_so_far = $_
	    }
	  }
	  $max_so_far;
	}

####Empty Parameter Lists
	$maximum = &max(@numbers);
#Sometimes the array @numbers might be an empty list,return undef.

##Notes on Lexical(my) Variables
	foreach (1..10) {
	  my($spuare) = $_ * $_;	#private variable in this loop
	  print "$_ squared is $squared.\n";
	}
#Also,the my operator doesn't change the context of an assignment:
	my($num) = @_;		# list context, same as ($num) = @_;
	my $sum = @_; 		# scalar context, same as $nnum = @_;
	my $fred,$barney;	# WRONG! Fails to declare $barney;
	my($fred,$barney);	# declares both
#Of course, you can use my to create new,private arrays as well:
	my @phone_number;
#Any new variable will start out empty:undef for scalar or the empty list for arrays.

##The use strict Pragma
#A pargma is a hint to a compiler,telling it something about the code.
	$bamm_bamm = 3;		#Perl creates that variable automatically
	$bammbamm += 1;	#Oops!
	use strict;		#Enforce some good programming rules
	my $bamm_bamm = 3;	#New lexical variable
	$bammbamm += 1;		#No such variable:Compile time fatal error
#Perl can complain that you haven't declared any variable called $bammbamm,so you mistake is automatically caught at compile time.

##The return Operator
	my @names = qw / fred barney dino wilma pebbles bamm-bamm /;
	my $result = &which_element_is("dino",@names);
	sub which_element_is {
	  my($what,@array) = @_;
	  foreach(0..$array) {		#indices of @array's elements
	    if ($what eq $array[$_]) {
	      return $_;
	    }
          }
	  -1;				#element not found (return is optional here)
	}

####Omitting the Ampersand
	my @cards = shuffle(@deck_of_cards);	#No & necessary on $shuffle
	sub division {
	  $_[0] / $_[1];	#Divide first param by second
	}
	my $quotient = division 355,113;	#Uses &dicision
	
	sub chomp {
	  print "Munch,munch!\n";
	}
	&chomp;			#That ampersand is not optional!

##Non-Scalar Return Values
	sub lsit_from_fred_to_barney {
	  if ($fred < $barney) {
	    #Count upwards from $fred to $barney
	    $fred..$barney;
	  } else {
	    #Count downwards from $fred to $barney
	    reverse $barney..$fred;
	  }
	}
	$fred = 11;
	$barney = 6;
	@c = &list_from_fred_to_barney;		# @c gets (11,10,9,8,7,6)

##Exercises
#See Appendix A for answers to the following exercises:
#1.[12]Write a subroutine, called &total, which returns the total of a list of numbers.Hint:The subroutine should not perform any I/O;it should process its parameters and return a value to its caller.Try it out in this sample program,which exercises the subroutine to see that it works,The first group of numbers should add up to 25.
	my @fred = qw{ 1 3 5 7 9 };
	my $fred_total = &total(@fred);
	print "The total of \@fred is $fred_total.\n";
	print "Enter some numbers on separate lines:";
	my $user_total = &total(<STDIN>);
	print "The total of those numbers is $user_total.\n";
#2.[5]Using the subroutine from the previous problem,make a program to calculate the sum of the numbers from 1 to 1,000.
#3.[18]Extra credit exercise:Write a subroutine,called &above_average,which takes alist of numbers and returns the ones which are above the average(mean).(Hint:Make another subroutine that calculates the average by dividing the total by the number of items.)Try your subroutine in this test program.
	my @fred = &above_average(1..10);
	print "\@fred is @fred\n";
	print "(Should be 6 7 8 9 10)\n";
	my @barney = &above_average(100,1..10);
	print "\@barney is @barney\n";
	print "(Should be just 100)\n";
