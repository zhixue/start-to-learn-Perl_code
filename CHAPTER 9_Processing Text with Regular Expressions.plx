####CHAPTER 9 Processing Text with Regular Expressions####

##Substitution with s///
#If you think of the m// pattern match as being like your word processor's "search" feature,the "search" and "replace" feature would be Perl's s/// substitution operator.
	$_ = "He's out bowling with Barney tonight.";
	s/Barney/Fred/;		#Replace Barney with Fred
	print "$_\n";
	
	#Continuing from above; $_ has "He's out bowling wit Fred tonight."
	s/Wilma/Betty/;		#Replace Wilma with Betty(fails)

	s/with (\w+)/against $1's team/;
	print "$_\n";	#says "He's out bowling against Fred's team tonight"

	$_ = "green scaly dinosaur";
	s/(\w+) (\w+)/$2, $1/;	#Now it's "scaly,green dinosaur"
	s/^/huge, /;		#Now it's "huge,scaly green dinosaur"

	s/,.*een//;		#Empty replacement: Now it's "huge dinosaur"
	s/green/red/;		#Fail match:still "huge dinosaur"
	s/\w+(!\W+)/$&/;	#Now it's "huge (huge !)dinosaur"
	s/\s+(!\W+)/$1 /;	#Now it's "huge (huge!) dinosaur"
	s/huge/gigantic/;	#Now it's "gigantic (huge!) dinosaur"

	$_ = "fred flintstone";
	if(s/fred/wilma/) {
	  print "Successfully replaced fred with wilma!\n";
	}

####Global Replacements with /g
	$_ = "home, sweet home!";
	s/home/cave/g;
	print "$_\n";		# "cave,sweet cave!"

	$_ = "Input data\t may have    extra whitespace.";
	s/\s+/ /g;		#Now it says "Input data may have extra whitespace."

	s/^\s+//;		#Replace leading whitespace with nothing
	s/\s+$//;		#Replace trailing whitespace with nothing

	s/^\s+|\s+$//g;		#Strip leading,trailing whitespace

##Different Delimiters
	s#^https://#http://#;
#They are all the same:
	s{fred}{barney};
	s[fred](barney);
	s<fred>#barney#;

####Option Modifiers
	s#wilma#Wilma#gi;	#Replace every WiLmA or WILMA with Wilma
	s{__end__.*}{}s;	#Chop off the end marker and all following lines

####The Binding Operator
	$file_name =~ s#^.*/##s;#In $file_name,remove any Unix-style path

####Cash Shifting
#The \U escape forces what follows to all uppercase:
	$_ = "I saw Barney with Fred.";
	s/(fred|barney)/\U$1/gi;		#$_ is now "I saw BARNEY with FRED."
#Similarly,The \L escape forces lowercase:
	s/(fred|barney)/\L$1/gi;		#$_ is now "I saw barney with fred."
#By default,these affect the rest of the (replacement) string.You can turn off case shifting with \E:
	s/(\w+) with (\w+)/\U$2\E with $1/i;	#$_ is now "I saw FRED with barney."
#When written in lowercase(\l and \u),they affect only the next character:
	s/(fred|barney)/\u$1/ig;		#$_ is now "I saw FRED with Barney."
#You can even stack them up.Using \u with \L means "all lower case,but capitalize the first letter":
	s/(fred|barney)/\u\L$1/ig;		#$_ is now "I saw Fred with Barney."
#As it happens,though we're covering case shifting in relation to substitutions,these escape sequences are available in any double-quotish string:
	print "Hello,\L\u$name\E,would you like to play a game?\n";

##The split Operator
	@fields = split /:/,"abc:def:g:h";	#gives("abc","def","g","h")
	@fields = split /:/,"abc:def::g:h";	#gives("abc","def","","g","h")
	@fields = split /:/,":::a:b:c:::";	#gives("","","","a","b","c")
	my $some_input = "This is a \t		test.\n";
	my args = split /\s+/,$some_input;	#("This","is","a","test.")
	my @fields = split;			#like split /\s+/,$_;

##The join Function
	my $result = join $glue,@pieces;	
	my $x = join ":",4,6,8,10,12;		#$x is "4:6:8:10:12"
	my $y = join "foo","bar";		#gives just "bar",since no fooglue is needed
	my @empty;				#empty array
	my $empty = join "baz",@empty;		#no items,so it's an empty string
	my @values = split /:/,$x;		#@values is (4,6,8,10,12)
	my $z = join "-",@value;		#$z is "4-6-8-10-12"
 
##m// in List Context
	$_ = "Hello there,neighbor!";
	my($first,$second,$third) = /(\S+) (\S_), (\S+)/;
	print "$second is my $third\n";
#The /g modifier you first saw on s/// also works with m//,which lets it match at more than one place in a string.In this case,a pattern with a pair of parentheses will return more than a memory from each time it matches:
	my $text = "Fred dropped a 5 ton granite block on Mr. Slate";
	my @words = ($text =~ /([a-z]+)/ig/);
	print "Result:@words\n";
	# Result: Fred dropped a ton granite block on Mr Slate
#If there are more than one pair of parentheses,each match may return more than one string.Let's say we have a string we want to read into a hash,like this:
	my $data = "Barnet Rubble Fred Flintstone Wilma Flintstone";
	my %last_name = ($data =~ /(\w+)\s+(\w+)/g);

##More powerful Regular Expressions

####Non-Greedy Quantifiers
#text:	I'm talking about the cartoon with Fred and <BOLD>Wilma</BOLD>!
	s#<BOLD>(.*)</BOLD>#$1#g;	#WRONG!
	s#<BOLD>(.*?)</BOLD>#$1#g;	#RIGHT!

####Matching Multiline Text
	$_ = "I'm much better\nthan Barney is \nat bowling,\nWilma.\n";
#This pattern can match:
	print "Found 'wilma' at start of line\n" if /^wilma\b/im;

	open FILE,$filename
	  or die "Can't open '$filename': $!";
	my $lines = join '',<FILE>;
	$lines =~ s/^/$filename: /gm;

####Updating Many File
#One of hundreds of files with a similar format is fred03.dat, and it's full of lines like these:
	Program name: granite
	Author: Gilbert Bates
	Company: RockSoft
	Department: R&D
	Phone: +1 503 555-0095
	Date: Tues March 9 ,2004
	Version: 2.1
	Size: 21k
	Status: Final beta
#We need to fix this file so that it has some different information.Here's roughly what this one should look like when we're done:
	Program name: granite
	Author: Randal L. Schwartz
	Company: RockSoft
	Department: R&D
	Date: June 12, 2008 6:38 pm
	Version: 2.1
	Size: 21k
	Status: Final beta
#In short,we need to make three changes.
	#!/usr/bin/perl -w
	use strict;
	
	chomp(my $date = 'date');
	$^I = ".bak";
	
	while (<>) {
	  s/^Author:.*/Author:Randal L. Schwartz/;
	  s/^Phone:.*\n//;
	  s/^Date:.*/Date: $date/;
	  print;
	}

	my $date = localtime;
####In-Place Editing from the Command Line
	$ perl -p -i .bak -w -e 's/Randall/Randal/g' fred*.dat
#The -p option tells Perl to write a program for you.It's not much of a program,thouth; it looks something like this:
	while (<>) {
	  print;
	}
#Put the pieces all together
	#!/usr/bin/perl -w
	$^I = ".bak";
	while (<>) {
	  s/Randall/Randal/g£»
	  print;
	}

####Non-Capturing Parentheses
	if (/(bronto)?saurus (steak|burger)/)
		{
		print "Fred wants a $2\n";
		}
#We add a question mark and a colon after the opening parenthesis,(?:),and that tells Perl we only use these oarebtheses for grouping.
#We change our regular expression to use non-capturing parentheses around "bronto",and the part that we want to remember appears in $1.
	if (/(?:bronto)?saurus (steak|burger)/)
		{
		print "Fred wants a $1\n";
		}
#Later, hwne we change our regular expression,perhaps to include a possible barbecue version of the brontosaurus burger,we can make the added "BBQ" (with a space) optional and non-capturing so the part we want to remember still shows up in $1.Otherwise,we'd potentially have to shift all of our memory variable names every time we add grouping parentheses to our regular expression.
	if (/(?:bronto)?saurus (?:BBQ )?(steak|burger)/)
		{
		print "Fred wants a $2\n";
		}

##Exercises
#See Appendix A for answers to the following exercises:
#1.[7]Make a pattern that will match three consecutive copies of whatever is currently contained in $what.That is ,if $what is fred,your pattern should match fredfredfred. If $what is fred|barney, your pattern should match fredfredbarney,barneyfredfred, barneybarneybarney,or many other variations.(Hint: You should set $what at the top of the pattern test program with a statement like my $what = 'fred|barney';.)
#2.[12]Write a program that makes a modified copy of a text file.In the copy,every string Fred(case insensitive) should be replaced with Larry.(So,"ManfredMann" should become "ManLarry Mann".)The input filename should be given on the command line (don't ask the user), and the output file name should be the corresponding file name ending with .out.
#3.[8]Modify the previous program to change evey Fred to Wilma and every Wilma to Fred. Now input like fred&wilma should look like Wilma&Fred in the output.
#4.[10]Extra credit exercise:Write a program to add a copyright line to all of your exercise answers so far,by placing a line such as:
	## copyright (C) 20XX by Yours Truly
#Place it in the file immediately after the "shebang" line.YOu should edit the files "in place" and keep a backup.Presume that the program will be invoked with the filenames to edit on the command line.
#5.[15]Extra extra credit exercise:Modify the precious program so it doesn't edit the files that contain the copyright line.Hint: You might need to know that the name of the file being read by the diamond operator in $ARGV.