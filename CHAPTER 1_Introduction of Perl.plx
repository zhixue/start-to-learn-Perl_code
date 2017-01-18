####CHAPTER 1####
#http://www.oreilly.com/catalog/learnperl4/
#Perl is sometimes called the "Practical Extraction and Report Language"("Pathologically Eclectic Rubbish Lister")
#Larry Wall created Perl in the mid_1980s.

while(<>){
  chomp;
  print join("\t",(spkit /:/)[0,2,1,5]),"\n";
}

#What is CPAN? 
#CPAN is the Comprehensive Perl Archive Network.
#http://search.cpan.org/ 
#http://kobesearch.cpan.org/

#Kinds of Support
#Perl Mongers,Http://www.pm.org
#documentation on the CPAN,http://www.cpan.org,http://perldoc.perl.org,http://perldoc.com,http://faq.perl.org

#a few web communities
#The Perl Monastery,http://www.perlmonks.org
#http://learn.perl.org

#programmers' text editor
#Unix:emacs/vi,Mac OS X:BBE-dit/Alpha,Windows:UltraEdit/Programmer's Favourate Editor(PFE)
#The perlfaq2 manpage lists serral other editors

#A simple program

#!/usr/bin/perl  or #!usr/local/bin/perl
print "Hello,world!\n";

#require an extension like .plx(meaning PerL eXecutable)
#	$chmod a+x my_program
#	$./my_program

#On Unix systems, #!usr/bin/env perl

#Compile Perl
#	$perl my_program
#A Whirlwind Tour of Perl

#!usr/bin/perl
@lines = 'perldoc -u -f atan2';	#runs an external command ,named within backquotes("' '"),perldoc command is used on most systems to read and display the documentation for Perl and its associated extension and utilities,the trigonometric function atan2,the output of that command in the backticks is saved in an array variable called @lines 
foreach(@lines){	#start a loop that processes each one of those lines.Inside the loop,the statements are indented.Though Perl doesn't require this,good programmers do.
  s/\w<([^>]+)>/\U$1/g;	#change any line that has a special marker made with angle brackets(< >),and there should be at least one of those in the output of the perldoc command.
  print;	#print out each line
}





##################################
#Exercises
##################################
#Normally,each chapter will end with some exercises,with the answers in Appendix A.But you don't need to write the programs needed to complete this section as they are supplied within the chapter text.
#If you can't get these exercises to work on your machine,check your work and then consult your local expert.Remember that you may need to tweak each program a little,as discribed in the text.
#1.[7] Type in the"Hello,world" program and get it work.(You may name it anything you wish,but a good name might be ex1-1,for simplicity,since it's exercise 1in Chapter 1.)
#2.[5] Type the command perldoc -u -f atan2 at a command prompt and note its output.If you can't get that to work,then find out from a local administrator or the documentation for your version of Perl about how to invoke perldoc or its equiicalent.(You'll need this exercise anyway.)
#3.[6] Type in the second example program (from the previous section) and see what it prints.(Hint:Be careful to type those ounctuation mark exactly as shown.) Do you see how it changed the output of the command?


