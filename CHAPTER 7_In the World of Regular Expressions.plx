####CHAPTER 7 In the World of Regular Expressions####

##What Are Regular Expressions?
#A regular expression,often called a pattern in Perl, is a template that matches or doesn't match a give string.

##Using Simple Pattern
#To match a pattern(regular expression) against the contents of $_,put the pattern between a pair of forward slashes(/) as we do here:
	$_ = "yabba dabba doo";
	if (/abba/) {
	  print "It matched!\n";
	}

####About Metacharacters
#The dot(.) matches any single character except a newline(which is represented by "\n").
#The backslash(\) is our second metacharacter.If you mean a real backslash,use a pair of them -- a rule that applies everywhere else in Perl.

####Simple Quantifiers
#The star(*) means to match the preceding item zero or more times.
#The plus(+) means to match the preceding item one or more times.
#The question mark(?) means that the preceding item is optional in that it may occur once or not at all.
#All three of these quantifiers must follow something since they tell how many times the previous item may repeat.

####Grouping in Patterns
#Parentheses are also metacharacters.As in mathematics parentheses(()) may be used for grouping.
#/fred+/ matches fredddddd
#/(fred)+/ matches fredfred
#/(fred)*/ matches hello,world.

####Alternatives
#The vertical bar(|),often pronounced "or" in this usage,means that the left or right side may match.
#/fred|barney|betty/ matches fred or barney or betty.
#/fred(|\t)+barney/
#/fred (and|or) barney/

Character Classes
#A character class, a list of possible characters inside square brackets([]), matches any single character from within the class.
#[abcwxyz]
#[a-cw-z]
#[a-zA-Z]
#[\000-\177] seven-bit ASCII character
	$_ = "The HAL-9000 requires autorization to continue.";
	if (/HAL-[0-9]+/) {
	  print "The string mentions some model of HAL computer.\n";
	}
#A caret("^") at the start of the character class negates it.
#[^def] don't matches def

####Character Class Shortcuts
#\d = [0-9]
#\w = [A-Za-z0_9_] 
#\s matches whitespace, the same as tab,newline,carriage return and space.

####Negating the Shortcuts
#[^\d],[^\w],[^\s]
#[\d\D] means any digit or any non-digit
#[^\d\D] means nothing

##Exercises
#See Appendix A for answers to the following exercises:
#Remember,it's normal to be surprised by some of the things that regular expressions do.That's one reason the exercises in this chapter are more important than the others.Expect the unexpected.
#1.[10]Make a program that prints each line of its input that mentions fred.(It shouldn't do anything for other lines of input.)Does it match if your input string is Fred,frederick,or Alfred? Make a small text file with a few lines mentioning "fred flintstone" and his friends.Then use that file as input to this program and the ones later in this section.
#2.[6]Modify the previous program to allow Fred to match as well.Does it match now if your input string is Fred,frederich, or Alfred?(Add lines withe these names to the text file.)
#3.[6]Make a program that prints each line of its input that contains a period(.), ignoring other lines of input.Try it one the small text file from the previous exercise:Does it notice Mr.Slate?
#4.[8]Make a program that prints each line with a word that is capitalized but not ALL capitalized.Does it match Fred but neither fred nor FRED?
#5.[8]Extra credit exercise:Write a program that prints out any input line that mentions both wilma and fred.  