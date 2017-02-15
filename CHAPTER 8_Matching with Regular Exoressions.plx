####CHAPTER 8 Matching with Regular Exoressions####

##Matches with m//
#This a shortcut for the m//(pattern match) operator.
#Choose a delimiter that doesn't appear in your pattern.
#/http:\/\// matches "http://",you can use a better choice of delimiter: m%http://%

##Option Modifiers
#Several option modifier letters,sometimes called flags,may be appended as a group right after the ending delimiter of a regular expression to change its behavior from the default.

####Case-Insensitive Matching with /i
#To make a case-insensitive pattern mathc,so you can mathc FRED as easily as fred or Fred use the /i modifier:
	print "Would you like to play a game?";
	chomp($_ = <STDIN>);
	if (/yse/i) {	#case-insensitive match
	  print "In that case,I recommand that you go bowling.\n";
	}

####Matching Any Character with /s
	$_ = "I saw Barney\ndown at the bowling alley\nwith Fred\nlast night.\n";
	if (/Barney.*Fred/s) {
	  print "That string mentions Fred after Barney!\n";
	}
#Without the /s modifier,that match would fail since the two names aren't on the same line.

####Adding Whitespace with /x
	/-?\d+\.?\d*/		#what is this doing
	/ -? \+ \.? \d* /x	#a little better
	/
	  -?			#an optional minus sign
	  \d+			#one or more digits before the decimal point
	  \.?			#an optional digits after the decimal point
	  \d*			#some optional digits after the decimal point
	/x			#end of pattern

####Combining Option Modifiers 
	if (/barney.*fred/is) {	#both /i and /s
	  print "That string mentions Fred after Barney!\n";
	}
	
	if (m{
	  barney 		#the little guy
	  .*			#anything in between
	  fred			#the loud guy
	}six) {			#all three of /s and /i and /x
	  print "That string mentions Fred after Barney!\n";
	}

####Other Options
#...

####Anchors
#The caret anchor(^) marks the beginning of the string,and the dollor sign($) marks the end.
#/^fred/ matches fred only at the start of the string.

####Word Anchors
#The word-boundary anchor,\b,matches at either end of a word./\bfred\b/ matches fred, not frederick.This is similar to the feature often called "match whole words only" in a word processor's search command.
#The nonword-boundary anchor is \B;it matches at any point where \b would not match./\bsearch\B/ will match searches,searching,but not search or researching.

##The Binding Operator,=~
#The binding operator(=~) tells Perl to match the pattern on the right against the string on the left,instead of matching against $_.
	my $some_other = "I dream of betty rubble.";
	if ($some_other =~ /\brub/) {
	  print "Aye,there's the rub.\n";
	}

	print "Do you like Perl?";
	my $likes_perl = (<STDIN> =~ /\brub\b/i);	#same as my $likes_perl = <STDIN> =~ /\brub\b/i;
	#time passes...
	if ($likes_perl) {
	  print "You said earlier that you like Perl,so ...\n";
	}

##Interpolation into Patterns
	#!/usr/bin/perl -w
	my $what = "larry";
	while(<>) {
	  if(/^($what)/) {	#pattern is anchored at beginning of string
	    print "We saw $what in beginning of $_";
	  }
	}

##The Match Variables
	$_ = "Hello there,neighbor";
	if(/\s(\w+),/) {	#memorize the word between space and comma
	  print "the word was $1\n";	#the word was there
	}

	$_= "Hello there,neighbor";
	if(/(\S+)(\S+),(\S+)/) {
	  print "words were $1 $2 $3\n";
	}

	my $dino = "I fear that I'll be extinct after 1000 years.";
	if($dino =~ /(\d*) year/) {
	  print "That said '$1' years.\n";	#1000

	$dino = "I fear that I'll be extinct after a few million years.";
	if($dino = ~/(\d*) years/) {
	  print "That said '$1' years.\n";	#empty string
	}

####The Persistence of Memory
	$wilma =~ /(\w+)/;	#BAD! Untested match result
	print "Wilma's word was $1... or was it?\n";
	
	if ($wilma =~ /(\w+)/) {
	  print "Wilma's word was  $1.\n";
	} else {
	  print "Wilma doesn't have a word.\n";
	}

	if($wilma =~ /(\w+)/) {
	  my $wilma_word = $1;
	}

####The Automatic Match Variables
	if("Hello there,neighbor" =~ /\s(\w+),/) {
	  print "That actually matched '$&'.\n";
	}

	if("Hello there,neighbor" =~ /\s(\w+),/) {
	  print "That was ($`)($&)($').\n";
	}

##General Quantifiers
#Use a comma-separated pair of numbers inside curly braces({}) to specify how few and how many repetitions are allowed.
#/a{5,15}/ will match from 5 to 15 repetitions of the letter a.
#{0,} means zero or more.

##Precedence
#THe regular expression precedence chart is simple, with only four levels.
#highest to lowest
# () -- *?{} -- ^\B\b -- |

####Examples of precedence
#/^(\w+\s+(\w+)$)/ matches lines that have a "word",some required whitesoace,and another "word," with nothing else or after.

####And There's More
#check the perlre,perlrequick,perlretut manpages for more information.

#A Pattern Test Program
	#!/usr/bin/perl
	while (<>) {	#take one input line at a time
	  chomp;
	  if (/YOUR_PATTERN_GOES_HERE/) {
	    print "Matched:|$`<$&>$'|\n";	#the sepical match vars
	  } else {
	    print "No match: |$_|\n";
	  }
	}

##Exercises
#See Appendix A for answers to the following exercises.
#Several of these exercises ask you to use the test program from this chapter.You could manually type this program,taking great care to get all of the odd punctuation marks correct.But you'll probably find it faster and easier to download the program and some other goodies from the O'Reilly web-site,as we mentioned in the Preface,You'll find this program under the name pattern_test:
#1.[8]Using the pattern test program,make a pattern to match the string match.Try the program with the input string beforematchafter.Does the output show the three parts of the match in the right order?
#2.[7]Using the pattern test program,make a pattern if any word(in the \w sense of word) ends with the letter a.Does it match wilma but not barney?Does it match Mrs.Wilma Flintstone?What about wilam&fred?Try it on the sample text file from the previous chapter's exercises(and add these test strings if they weren't already in there).
#3.[5]Modify the program from the previous exercise so the word ending with the letter a is captured into memory $1.Update the code to display that variable's contents in single quotes,something like $1 contains 'wilma'.
#4.[5]Extra credit exercise:Modify the program from the previous exercise so that immediately following the word ending in a it will capture up to five characters(if there are that many characters) in a separate memory variable.Update the code to display both memory variables.For example,if the input string says I saw Wilma yesterday,the up to five characters are  yest.If the input is I,wilma!,the extra memory should have one character.Does your pattern still match just plain wilma?
#5.[5]Write a new program(not the test program) that prints out any input line ending with whitespace(other than a newline).Put a marker character at the end of the output line so as to make whitespace visible.
