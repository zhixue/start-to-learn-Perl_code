####CHAPTER 11 File Tests####

##File Test Operators
	die "Oops!A file called '$filename' already exists.\n"
	  if -e $filename;

	warn "Config file is looking pretty old!\n"
	  if -M CONFIG > 28;

	my @original_files = qw/ fred barney betty wilma pebbles dino bamm-bamm /;
	my @big_old_files;	#The ones we want to put on backup tapes
	foreach my $filename (@original_files) {
	  push @big_old_files,$filename
	    if -s $filename >100_000 and -A $filename > 90;
	}

#Table 11-1. File tests and their meanings
#	file test	Meaning
#	-r		File or directory is readable by this(effective) user or group
#	-w		File or directory is writable by this(effective) user or group
#	-x		File or directory is executable by this(effective) user or group
#	-o		File or directory is owned by this(effective) user
#	-R		File or directory is readable by this real user or group
#	-W		File or directory is writable by this real user or group
#	-O		File or directory is owned by this real user
#	-e		File or directory name exists
#	-z		File exists and has zero size(always false for directories)
#	-s		File or directory exists andhas nonzero size(the value is the size in bytes)
#	-f		Entry is a plain file
#	-d		Entry is a directory
#	-l		Entry is a symbolic link
#	-S		Entry is a socket
#	-p		Entry is a named pipe(a 'fifo')
#	-b 		Entry is a block-special file(like a mountable disk)
#	-c 		Entry is a character-special file(like an I/O device)
#	-u		File or directory is setuid
#	-g		File or directory is setgid
#	-k		File or directory has the sticky bit set
#	-t 		The filehandle is a TTY(as reported by the isatty() system function;filenames can't be tested by this test) 
#	-T		File looks like a 'text' file
#	-B		File looks like a 'binary' file
#	-M		Modification age (measured in days)
#	-A		Access age(measured in days)
#	-C		Inode-modification age(measured in days)

	foreach(@lots_of_filename){
	  print "$_ is readable\n" if -r	# same as -r $_
	}

	#The filename is in $_
	my $size_in_K = -s / 1000;	#Oops!

	my $size_in_k = (-s) / 1024;	#Uses $_ by default

####The stat and lstat Functions
	my($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,
	  $size,$atime,$mtime,$ctime,$blksize,$blocks)
	    = stat($filename);
#$dev and $ino:The device number and inode number of the file.
#$mode:The set of permission bits for the file and some other bits.
#$nlink:The number of (hard) links to the file or directory.
#$uid and $gid:The numeric user ID and group ID showing the file's ownership.
#$size:The size in bytes,as returned by the -s file test.
#$atime,$mtime,$ctime:The three timestamps,but here they're represented in the system's timestamp format: a 32-bit number telling how many seconds have passed.	

####The localtime Function
	my $timestamp = 1180630098;
	my $date = localtime $timestamp;

	my($sec,$min,$hour,$day,$mon,$year,$wday,$yday,$isdst)
	  = localtime $timestamp;

	my $now = gmtime;	#get the current universal timestamp as a string

##Bitwise Operators
#Table 11-2. Bitwise operators
#	Expression	Meaning
#	10 & 12		Bitwise-and;which bits are true in both operands(this gives 8)
#	10 | 12		Bitwise-or;which bits are true in one operand or the other(this give 14)
#	10 ^ 12		Bitwise-xor;which bits are true in one operand or the other but not both(this gives 6)
#	6 << 2		Bitwise shift left;shift the left operand the number of bits shown by the right operand,adding zero-bits at the least-significant places(this gives 24)
#	25 >> 2		Bitwise shift right;shift the left operand the number of bits shown by the right operand,discarding the least-significant bits(this gives 6)
#	~ 10		Bitwise negation,also called unary bit complement;return the number with the opposite bit for each bit in the operand(this gibes 0xFFFFFFF5,but see the text)

	#$mode is the mode value returned from a stat of CONFIG
	warn "Hey,the configuration file is world-writable!\n"
	  if $mode & 0002;				#configuration security problem
	my $classical_mode = 0777 & $mode;		#mask off extra high-bits
	my $u_plus_x = $classical_mode |0100;		#turn one bit on
	my $go_minus_r = $classical_mode & (~ 0044);	#turn two bits off

####Using Bitstrings
#All of the bitwise operators can work with bitstrings,as well as with integers.
#"\xAA" | "\x55" will give the string "\xFF".

##Using the Special Underscore Filehandle
	my @original_files = qw/ fred barney betty wilma pebbles dino bamm-bamm /;
	my @big_old_files;	#The ones we want to put on backup tapes
	foreach (@original_files){
	  push $big_old_files,$_
	    if (-s) > 100_000 and -A_ > 90;	#more efficient than before
	}

##Exercises
#See Appendix A for answers to the following exercises:
#1.[15]Make a program that takes a list of files named on the command line and reports for each one whether it's readable,writable,executable,or doesn't exist.(Hint:It may be helpful to have a function that will do all fo the file tests for one file at a time.)What does it report about a file which has been chmod'ed to 0?(That is,if you're on a Unix system,use the command chmod 0 some_file to mark that file as neither being readable,writable,nor executable.)In most shells,use a star as the argument to mean all of the normal files in the current directory.That is,you could type something like ./ex11-1 * to ask the program for the attributes of many files at once.
#2.[10]Make a program to identify the oldest file named on the command line and report its age in days,What does it do if the list is empty(that is,if no files are mentioned on the command line)?