####Chapter 13 String and Sorting####

##Finding a Substring with index
	$where = index($big,$small);

	my $stuff = "Howdy world!";
	my $where = index($stuff,"wor");

	my $stuff = "Howdy world";
	my $where1 = index($stuff,"w");			#$where1 gets 2
	my $where2 = index($stuff,"w",$where1 + 1);	#$where2 gets 6
	my $where3 = index($stuff,"w",$where2 + 1);	#$where3 gets -1(not found)

	my $fred = "Yabba dabba doo!";
	my $where1 = rindex($fred,"abba");		#$where1 gets 7
	my $where2 = rindex($fred,"abba",$where1 -1);	#$where2 gets 1
	my $where3 = rindex($fred,"abba",$where2 -1);	#$where3 gets -1

##Manipulating a Substring with substr
	$part = substr($string,$initial_position,$length);

	my $mineral = substr("Fred J. Flintstone",8,5);	#gets "Flint"
	my $rock = substr "Fred J. Flintstone",13,1000;	#gets "stone"

	my $pebble = substr "Fred J. Flintstone",13;	#gets "stone"

	my $out = substr("some very long string",-3,2);	#$out gets "in"

	my $long = "some very very long string";
	my $right = substr($long,index($long,"l"));

	my $string = "Hello,world!";
	substr($string,0,5) = "Goodbye";	#$string is now "Goodbye,world!"

	substr($string,-20) =~ s/fred/barney/g;

	my $previous_value = substr($string,0,5,"Goodbye");

##Formatting Data with sprintf
	my $data_tag = sprintf
	  "%3d/%02d/%02d %2d:%02d:%02d",
	  $yr,$mo,$da,$h,$m,$s;
#looks like "2038/ 1/19 3: 0: 8"

####Using sprintf with "Money Numbers"
	my $money = sprintf "%.2f",2.49997;

	sub big_money{
	  my $number = sprintf "%.2f",shift @_;
	  # Add one comma each time through the do-nothing loop
	  1 while $number =~ s/^(-?\d+)(\d\d\d)/$1,$2/;
	  #put the dollar sign in the right place
	  $number =~ s/^(-?)/$1\$/;
	  $number;
	}

	while($number =~ s/^(-?\d+)(\d\d\d)/$1,$2/){
	  1;
	}

	'keep looping' while $number =~ s/^(-?\d+)(\d\d\d)/$1,$2/;

##Advanced Sorting
	sub any_sort_sub{	#It doesn't really work this way
	  my($a,$b) = @_;	$get and name the two parameters
	  # start compare $a and $b here
	  ...
	}

	sub by_number{
	  #a sort subroutine,expect $a and $b
	  if($a<$b) { -1 } elsif ($a>$b) { 1 } else { 0 }
	}

	my @result = sort by_number @some_numbers;

	sub by_number { $a <=> $b }

	sub ASCIIbetically { $a cmp $b } my @strings = sort ASCIIbetically @any_strings;

	sub case_insensitive{ "\L$a" cmp "\L$b"}

	my @numbers = sort { $a <=> $b } @some_numbers;

	my @descending = reverse sort { $a <=> $b } @some_numbers;

	my @descending = sort { $b <=> $a } @some_numbers;

####Sorting a Hash by Value
	my %score = ("barney"=>195,"fred"=>205,"dino"=>30);
	my @winners = sort by_score keys %score;

	sub by_score { $score{$b} <=> $score{$a} }

####Sorting by Multiple Keys
	my %score = (
	  "barney" => 195, "fred" => 205,
	  "dino" => 30,"bamm-bamm" => 195,
	);

	my @winners = sort by_score_and_name keys %score;
	sub by_score_and_name {
	  $score{$b} <=> $score{$a}	#by descending numeric score
	    or
	  $a cmp $b			#ASCIIbetically by name
	}

	@patron_IDs = sort {
	  &fines($b) <=> &fines($a) or
	  $items{$b} <=> $items{$a} or
	  $family_name{$a} cmp $family_name{$a} or
	  $personal_name{$a} cmp $family_name{$b} or
	  $a <=> $b
	} @patron_IDs;

##Exercises
#See Appendix A for answers to the following exercise:
#1.[10]Write a program to read in a list of numbers and sort them numerically,printing out the resulting list in a right-justified column.Try it out on this sample data,or use the file numbers from the O'Reilly web site(see the Preface):
	17 1000 04 1.50 3.14159 -10 1.5 4 2001 90210 666
#2.[15]Make a program that will print the following hash's data sorted in case-insensitive alphabetical order by last name.When the last names are the same,sort those by first name(without regard for case).That is,the first name in the output should be Fred's,and the last one should be Betty's.All of the people with the same family name should be grouped together.Don't alter the data.The names should be printed with the same capitalization as shown here.(You can find the source code to create a hash like this in the file sortable_hash with the other downloaded files.)
	my %last_name = qw{
	  fred flintstone Wilma Flintstone Barney Rubble
	  betty rubble Bamm-Bamm Rubble PEBBLES FLINTSTONE
	};
#3.[15]Make a program that looks through a given string for every occurrence of a given substring,printing out the positions where the substring is found.For example,given the input string "That is a test." and the substring "is",it should report positions 2 and 5.If the substring were "a",it should report 8.What does it report if the substring is "t"?