####CHAPTER 10 More Control Structures####

##The unless Control Structure
	unless ($fred =~ /^[A-Z_]\w*$/i) {
	  print "The value of \$fred doesn't look like a Perl identifier name.\n\";

	if ($fred =~ /^[A-Z_]\w*$/i) {
	  #do something
	} else {
	  print "The value of \$fred doesn't look like a Perl identifier name.\n\";

	if ( !($fred = ~ /^[A-Z_]\w*$/i)) {
	  print "The value of \$fred doesn't look like a Perl identifier name.\n";
	}

####The else Clause with unless
	unless ($mon =~ /^Feb/) {
	  print "This month has at least thirty days.\n";
	} else {
	  print "Do you see what's going on here?\n";
	}

	if ($mon =~ /^Feb/) {
	  print "Do you see what's going on here?\n";
	} else {
	  print "This month has at least thirty days.\n";
	}

##The until Control Structure
	until ($j > $i) {
	  $j *= 2;
	}

##Expression Modifiers
	print "$n is a negative result number.\n";
	
	if ($n<0) {
	  print "$n is a negative number.\n";
	}

	&error("Invalid input") unless &valid($input);
	$i *= 2 until $i>$j;
	print " ", ($n += 2) while $n <10;
	&greet($_) foreach @person;

	while($n < 10) {
	  print " ", ($n += 2);
	}
	
	print "fred is '$fred',barney is '$barney'\n" if $I_am_curious;
	
##The Naked Block Control Structure
#The naked block is like a while or foreach loop,except that it doesn't loop;it executes the body of the loop once,and it's done.It's an un-loop!
	{
	  print "Please enter a number: ";
	  chomp(my $n = <STDIN>);
	  my $root = sqrt $n;		#calculate the square root
	  print "The square root of $n is $root.\n";
	}
#In this block,$n and $root are temporart variables scoped to the block.As a general guideline,all variables should be declared in the smallest scope available.

##The elsif Clause
	if ( ! defined $dino) {
	  print "The value is undef.\n";
	} elsif ($dino =~ /^-?\d+\.?$/) {
	  print "The value is an integer.\n";
	} elsif ($dino =~ /^-?\d+\.\d+$/) {
	  print "The value is a _simple_ floating-point number.\n";
	} elsif ($dino eq '') {
	  print "The value is the empty string.\n";
	} else {
	  print "The value is the string '$dino'.\n";
	}

##Autoincrement and Autodecrement
	my $bedrock = 42;
	$bedrock++;	#add one to $bedrock; it's now 43

	my @people =qw{ fred barney fred wilma dino barney fred pebbles };
	my %count;			#new empty hash
	$count{$_}++ foreach @people;	#creates new keys and values as needed

	$bedrock--;			#subtract one from $bedrock;it's 42 again

####The Value of Autoincrement
	my $m = 5 ;
	my $n = ++$m;	#increment $m to 6,and put that value into $n

	my $c = --$m;	#decrement $m to 5,and put that value into $c

	my $d = $m++;	#$d gets the old value (5),then increment $m to 6
	my $e = $m--;	#$e gets the old value (6),then decrement $m to 5

	$bedrock++;	#adds one to $bedrock
	++$bedrock;	#just the same;add one to $bedrock;

	my @people = qw{ fred barney bamm-bamm wilma dino barney betty pebbles };
	my %seen;

	foreach(@people) {
	  print "I've seen you somewhere before,$_!\n"
	    if $seen{$_}++;
	}

##The for Control Structure
	for (initialization;test;increment){
 	body;  
	}

	for($i=1;$i<=10;$i++){ #count from 1 to 10
	  print "I can count to $i\n";
	}

	for($i=10;$i>=1;$i--){ 
	  print "I can count down to $i\n";
	}

	for($i=-150;$i<=1000;$i+=3){
	  print "$i\n";
	}

	for($_="bedrock";s/(.)//;){ #loop while the s/// is successful
	  print "Obe character is: $i\n";
	}

	for(;;){ 
	  print "It's an infinite loop!\n";
	}

##The Secret Connection Between foreach and for
	for(1..10){ #Really a foreach loop from 1 to 10
	  print "I can count to $_!\n";
	}

	for($i=1;$i<10;$i++){	#Oops! Something is wrong here!
	  print "I can count to $_!\n";
	}

##Loop Controls
#Three loop-control operators

####The last Operator
#like break
	#Print all input lines mentioning fred,untill the __END__ marker
	while(<STDIN>){
	  if(/__END__/){
	    #No more input on or after this marker line
	    last;
	  } elsif (/fred/){
	    print;
	  }
	}

####The next Operator
#like continue
	#Analyze words in the input file or files
	while(<>){
	  foreach(split){	#break $_into words,assign each to $_ in turn
	  $total++;
	  next if /\W/;		#strange words skip the remainder of the loop
	  $valid++;		#count each separate word
	  ##next comes here##
	  }
	}

	print "total things = $total,valid words = $valid\n";
	foreach $word(sort kets %count){
	  print "$word was seen $count{$word} times.\n";
	}

####The redo Operator
#Going back to the top of the current loop block,without testing any conditional expression or advancing to the next iteration.
	#typing test
	my @words = qw{ fred barney pebbles dino wilma betty };
	my $errors = 0;	
	foreach(@words){
	  ##redo comes here##
	  print "Type the word '$_': ";
	  chomp(my $try=<STDIN>);
	  if($try ne $_) {
	    print "Sorry - That's not right.\n\n";
	    $errors++;
	    redo;	#jump back up to the top of the loop
	  }
	}
	print "You've completed the test,with $errors errors.\n";

	foreach(1..10){
	  print "Iteration number $_.\n\n";
	  print "Please choose: last,next,redo,or none of the above? ";
	  chomp(my $choice=<STDIN>);
	  print "\n";
	  last if $choice =~ /last/i;
	  next if $choice =~ /next/i;
	  redo if $choice =~ /redo/i;
	  print "That wasn't any of the choices... onward!\n\n";
	}
	print "That's all,folks!\n";

##Labeled Blocks
	LINE: while(<>){
	  foreach (split){
	    last LINE if /__END__/;	#bail out the LINE loop
	  }
	}

##Logical Operators
	if($dessert{'cake'} && $dessert{'ice cream'}){
	  #Both are true
	  print "Hooray!Cake and ice cream!\n";
	} elsif ($dessert{'cake'} || $dessert{'ice cream'}){
	  #At least one is true
	  print "That's still good..\n";
	} else {
	  #Neither is true =do something
	}

	if((9<=$hour)&&($hour<17)){
	  print "Aren't you supposed to be at work...?\n";
	}
	
	if(($name eq 'fred')||($name eq 'barney')){
	  print "You're my kind of guy!\n";
	}

	if(($n!=0)&&($total/$n<<5)){
	  print "The average is below five.\n";
	}

####The Value of a Short-Circuit Operator
	my $last_name = $last_name{$someone} || '(No last name)';
#if someone not exist,left will be undef,which is false

####The Ternary Operator,?:
	expression ? if_true_expr : if_false_expr

	my $location = &is_weekend($day) ? "home" : "work";

	my $average = $n ? (total/$n) : "-----";
	print "Average : $average\n";
	
	my $average;
	if($n){
	  $average = $total/$n;
	} else {
	  $average = "-----";
	}
	print "Average: $average\n";

	my $size = 
	  ($width<10) ? "small"	:
	  ($width<20) ? "medium":
	  ($width<50) ? "large"	:
	  		"extra-large";	#default

####Control Structures Using Partial-Evaluation Operators
	($m<$n) && ($m=$n);
	
	if($m<$n){$m=$n}
	
	($m>10)||print "why is it not greater?\n";

	($m<$n)?($m=$x):($n=$x);

	$m<$n and $m=$n;	#but better written as the corresponding if 

	open CHAPTER,$filename
	  or die "Can't open '$filename':$!";

##Exercise
#See Appendix A for an answer to the following exercise:
1.[25]Make a program that will repeatedly ask the user to guess a secret bnumber from 1 to 100 until the user guesses the secret number.You program should pick the number at random by using the magical fromula int(1 +rand 100).When the user guesses wrong,the program should respond "Too high" or "To low."If the user enters the word quit or exit,or if the user enters a blank line,the program should quit.If the user guesses correctly,the program should quit then as well. 
	