####Chapter 14 Process Management####

##The system Function
#To invoke the Unix date command from within Perl
	system "date";

#a more complicated command
	system "ls -l $HOME";

#While the child process is running,Perl is patiently waiting for it to finish.
	system "long_running_command with parmeters &";

#You can write an entire little shell scipt in the following argument:
	system 'for i in *;do echo == $! ==; cat $i;done';

####Avoiding the Shell
	my $tarfile = "something*wicked.tar";
	my @dirs =qw(fred|flintstone <barney&rubble> betty );
	system "tar","cvf",$tarfile,@dirs;

	system "tar cvf $tarfile @dirs";	#Oops!

	system $command_line;
	system "/bin/sh","-c",$command_line;

	system "/bin/csh","-fc",$command_line;

	unless(system "date"){
	  #Return was zero - meaning success
	  print "We gave you a date,OK!\n";
	}

	!system "rm -rf files_to_delete" or die "something went wrong";

##The exec Function
#The system function creates a child process,which scurries off to perform the requested action while Perl naps.The exec function causes the Perl process itself to perform the requested action.Think of it as more like a "goto" than a subroutine call.
	chdir "/tmp" or die "Cannot chdir /tmp: $!";
	exec "bedrock","-o","args1",@ARGV;

	exec "date";
	die "date couldn't run: $!";

##The Environment Variables
	$ENV{'PATH'} =  "/home/rootbeer/bin:$ENV{'PATH'}";
	delete $ENV{'IFS'};
	my $make_result = system "make";

##Using Backquotes to Capture Output
	my $now = 'date';	#grab the output of date
	print "The time is now $now";	#newline already present

	chomp(my $no_newline_now = 'date');
	print "A moment ago,it was $no_newline_now,I think.\n";


	my @function = qw { int rand sleep length hex eof not exist sqrt umark };
	my %about;

	foreach(@functions){
	  $about{$_} = 'perldoc -t -f $_';
	}

	print "Starting the frobnitzigator:\n";
	'forbnitz -enable';	#please don't do this!
	print "Done!\n";

	my $output_with_errors = 'robnitz -enable 2>&10';

	my $result = 'some_questionable_command arg arg argh </dev/null';

####Using Backquotes in a List Context
#The unix command who normally spits out a line of text for each current login on the system as follows:
	merlyn	tty/42	Dec 7	19:41
#The left to right coloums are the username,user's connection to the machine,the date and the time login
	my $who_text = 'who';
#But in a list context,we automatically get the data broken up by lines:
	my @who_lines = 'who';

	foreach('who'){
	  my($user,$tty,$date) = /(\S+)\s+(\S+)\s+(.*)/;
	  $ttys{$user} .= "$tty at $date\n";
	}

##Processes as Filehandles
	open DATE,"date|" or die "cannot pipe from date: $!";
	open MAIL,"|mail merlyn" or die "cannot pipe to mail" $!";

	my $now = <DATE>;
	print MAIL "The time is now $now";	#presume $now ends in newlines
	close MAIL;
	die "mail: nonzero exist of $? if #?";

	open F,"find / -atime +90 -size +1000 -print|" or die "fork: $!";
	while(<F>){
	  chomp;
	  printf "%s size %dk last accessed on %s\n";
	    $_, (1023 + -s $_)/1024,-A $_;

##Getting Down and Dirty with fork
	system "date";

	defined(my $pid = fork) or die "Cannot fork: $!";
	unless($pid){
	  #Child process is here
	  exec "date";
	  die "cannot exec date: $!";
	}
	#parent process is here
	waitpid($pid,0);

##Sending and Receiving Signals
	kill 2,4201 or die "Cannot signal 4201 with SIGINT: $!";

	unless(kill 0 ,$pid){
	  warn "$pid has gone away!";
	}

	my $temp_directory = "/tmp/myprog.$$";	#create files below here
	mkdir $temp_directory,0700 or die "Cannot create $temp_directory: $!";

	sub clean_up{
	  unlink glob "$temp_directory/*";
	  rmdir $temp_directory;
	}

	sub my_int_handler{
	  &clean_up;
	  die "interrupted,exiting...\n";
	}

	$SIG{'INT'} = 'my_int_handler';
		#time passes,the program runs,creates some temporary
		#files in the temp directory,maybe someone presses Ctrl-C
	#now it's the end of normal execution
	&clean_up;

	my $int_count;
	sub my_int_handler{ $int_count++ }
	$SIG{'INT'} = 'my_int_handler';
	...
	$int_count = 0;
	while(<SOMEFILE>){
	  if($int_count){
	    #interrupt was seen!
	    print "[processing interrupted...]\n";
	    last;
	  }
	}

##Exercises
#See Appendix A for answers to the following exercises:
#1.[6]Write a program that changes to some particular (handcoded) directory,like the system's root directory,and executes the ls -l command to get a long-format directory listing in that directory.(If you use a non-Unix system,use your own system's command to get a detailed directory listing.)
#2.[10]Modify the previous program to send the output of the command to a file called ls.out in the current directory.The error output should go to a file called ls.err.(You don't need to do anything special about the fact that either of these files may end up being empty.)
#3.[8]Write a program to parse the output of the date command to determine the current day of the week.If the day of the week is a weekday,print get to work;otherwise,print go play.The output of the date command begins with Mon on a Monday.If you don't have a date command on your non-Unix system,make a fake program that prints a string similar to one that date might print.We'll give you this two-line program if you promise not to ask us how it works.
	#!/usr/bin/perl
	print localtime() . "\n";
