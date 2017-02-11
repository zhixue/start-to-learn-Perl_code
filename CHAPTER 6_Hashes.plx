####CHAPTER 6 Hashes####

##What Is a Hash?
#A hash is a data structure like an array,in that it can hold any number of values and retrieve these values at will.
#A hash as a barrel of data

####Why Use a Hash?
#One set of data "related to" another set of data.
#Here are some hashes you might find in typical applications of Perl:
	Given name,family name
	Hostname,IP address
	Ip address, hostname
	Word,count of number of times that word appears
	Username,number of disk blocks they are using [wasting]
	Driver's license number,name
#another way to think of a hash is as a simple database,in which one piece of data may be filed under each key.

##Hash Element Access
#Use syntax that looks like this:
	$hash{$some_key} 
#That key expression is now a string,rather than a number:
	$family_name{"fred"} = "flintstone";
	$family_name{"barney"} = "rubble";
#This lets us use code like this:
	foreach $person (qw < barney fred >) {
	  print "I've heard of $person $family_name{$person}.\n";
	}
#The hash key may be anny expression and not just the literal strings and scalar variables that we're showing here:
	$foo = "bar";
	print $family_name{$foo . "ney" };	#prints "rubble"
#When you store something into an existing hash element,it overwrites the previous value:
	$family_name{"fred"} = "astaire";	#gives new value to existing element
	$bedrock = $family_name{"fred"};	#gets "astaire";old value is lost
#Hash elements spring into existence by assignment:
	$family_name{"wilma"} = "flintstone";	#adds a new key(and value)
	$family_name{"betty"} . = $family_name{"barney"};
#Accessing outside the hash gives undef:
	$granite = $family_name("larry");	#No larry here: undef

####The Hash as a Whole
#A hash may be convered into a list and back again.Assigning to a hash is a list-context assignment,where the list is made of key/value pairs:
	%some_hash = ("foo",35,"bar",12.4,2.5,"hello","wilma",1.72e30,"betty","bye\n");
#The value of the hash(in a list context) is a list of key/value pairs:
	@any_array = %some_hash;
#The pairs won't necessarily be in the same order as the original list:
	print "@any_array\n";
	  # might give something like this:
	  # betty bye (and a newline) wilma 1.72e+30 foo 35 2.5 hello bar 12.4

####Hash Assignment
#It's rare to do so,but a hash may be copied using this syntax:
	%new_hash = %old_hash;
#Transforming the hash in some way is more common.
	%inverse_hash = reverse %any_hash;

####The Big Arrow
#We have to count through the list,saying,"key,value,key,value..." to determine whether 2.5 is a key or a value:	
	%some_hash = ("foo",35,"bar",12.4,2.5,"hello","wilma",1.72e30,"betty","bye\n");
#It's easily understood by the big arrow(=>)
	my %last_name = ( # a hash may be a lexical variable
	  "fred"	=> "flintstone",
	  "dino"	=> undef,
	  "barney"	=> "rubble",
	  "betty"	=> "rubble",
	);

##Hash Functions
#Some useful functions can work on an entire hash simultaneously.

####The keys and values Functions
	my %hash = ("a"=>1,"b"=>2,"c"=>3);
	my @k = keys %hash;	#"a","b","c"
	my @v = values %hash; 	#1,2,3
	my $count = keys %hash;	#gets 3,meaning three key/value pairs
#Once in a while,you'll see that someone has used a hash as a Boolean(true/false) expression like this:
	if (%hash) {
	  print "That was a true value!\n";
	}

####The each Function
	while ( ($key,$value) = each %hash ) {
	  print $key => $value\n";
	}

	foreach $key (sort keys %hash) {
	  $value = $hash{$key};
	  print "$key => $value\n";
	  # Or, we could have avoided the extra $value variable:
	  # print "$key => $hash{$key}\n";
	}

##Typical Use of a Hash
	$books{"fred"} = 3;
	$books{"wilma"} = 1;
	if ($books{$someone}) {
	  print "$someone has at leat one book checked out.\n";
	}
	$books{"barney"} = 0	#no books currently checked out
	$books{"pebbles"} = undef #no books EVER checked out - a new library card

####The exists Function
	if (exists $books{"dino"}) {
	  print "Hey,there's a library card for dino!\n";
	}

####The delete Function
	my $person = "betty";
	delete $books{$person};	#Revoke the library card for $person

####Hash Element Interpolation
	foreach $person (sort keys %books) {	#each patron, in order
	  if ($books{$person}) {
	    print "$person has $books{$person} items\n";	#fred has 3 items
	  }
	}

##Exercises
#See Appendix A for answer to the following exercise:
1.[7]Write a program that will ask the user for a given name and report the corresponding family name.Use the names of people you know, or (if you spend so much time on the computer that you don't know any people) use Table 6-1.
#Table 6-1. Sample data
#	Input	Output
#	--------------
#	fred	flintstone
#	barney	rubble
#	wilma	flintstone
2.[15]Write a program that reads a series of words (with one word per line) until end-of-input, then print a summary of how many times each word was seen.(Hint: remember that when an undefined value is used as if it were a number,Perl auto matically converts it to 0.It may help to look back at the earlier exercise that kept a running total.)If the input words were fred,barney,fred,dino,wilma,fred(all on separate lines),the output should tell us that fred was seen 3 times.For extra credit,sort the summary words in ASCII order in the output.
