####CHAPTER 12 Directory Operatioms####



##Moving Around the Directory Tree

#The chdir operator changes the working directory.It's just like the Unix shell's cd command:
    	chdir "/etc" or die "cannot chdir to /etc: $!";



##Globbing
	$echo *.pm
	barney.pm dino.pm fred.pm wilma.pm
	$

	$cat >show-args
	foreach $arg(@ARGV){
	  print "one arg is $arg\n";
	}
	^D
	$perl show-args *.pm
	one arg is barney.pm
	one arg is dino.pm
	one arg is fred.pm
	one arg is wilma.pm
	$

	my @all_files = glob "*";
	my @pm_files = glob "*.pm";

	my @all_files_including_dot = glob ".* *";

##An Alternate Syntax for Globbing
	my @all_files = <*>;	##exactly the same as my @all_files = glob "*";

	my $dir = "/etc";
	my @dir_files = <$dir/* $dir/.*>;

	my @files = <FRED/*>;	##a glob
	my @lines = <FRED>;	##a filehandle read
	my $name = "FRED";
	my @files = <$name/*>;	##a glob

	my $name = "FRED";
	my @lines = <$name>;	##an indirect filehandle read of FRED handle

	my $name = "FRED";
	my @lines = readline FRED;	##read from FRED
	my @lines = readline $name;	##read from FRED


##Directory Handles
	my $dir_to_ptovrdd = "/etc";
	opendir DH,$dir_to_process or die "Cannot open $dir_to_process:$!";
	foreach $file(readdir DH){
	  print "one file in $dir_to_process is $file\n";
	}
	closedir DH;

	while($name = readdir DIR){
	  next unless $name =~ /\.pm$/;
	  ...more processing...
	}


	next if $name =~ /^\./;

	next if $name eq "." or $name eq "..";

	opendir SOMEDIR,$dirname or die "Cannot open $dirname:$!";
	while(my $name = readdir SOMEDIR){
	  next if $name =~ /^\./;	#skip over dot files
	  $name = "dirname/$name";	#patch up the path
	  next unless -f $name and -r $name;	#only readable files
	  ...
	}

##Recursive Directory Listing

##Manipulating Files and Directories

##Removing Files
#In Unix shell
	$rm slate bedrock lava
#In Perl,we use the unlink operator:
	unlink "slate","bedrock","lava";
#Since unlink takes a list,and the glob function returns a list,we can combine the two to delete many files at once:
	unlink glob "*.o";

	my $successful = unlink "slate","bedrock","lava";
	print "I deleted $successful file(s) just now\n";

	foreach my $file(qw(slate bedrock lava)){
	  unlink $file or warn "failed on $file: $!\n";
	}

##Renaming Files
	rename "old","new";
	rename "over_there/some/place/some_file","some_file";

	foreach my $file(glob "*.old"){
	  my $newfile = $file;
	  $newfile =~ s/\.old$/.new/;
	  if(-e $newfile){
	    warn "can't rename $file to $newfile: $newfile exists\n";
	  } elsif(rename $file,$newfile){
	    ## success,do nothing
	  } else {
	    warn "rename $file to $newfile failed: $!\n";
	  }
	}

	(my $newfile = $file) =~ s/\.old$/.new/;

##Links and Files
	link "chicken","egg"
	  or warn "can't link chicken to egg: $!";

	my $where = readlink "carroll";		#gives "dodgson"

	my $perl = readlink "/usr/local/bin/perl";	#maybe tells where perl is 

##Making and Removing Directories
	mkdir "fred",0755 or warn "Cannot make fred directory: $!";

	my $name = "fred";
	my $permissions = "0755";	#danger... this isn't working
	mkdir $name,$permissions;

	mkdir $name,oct($permissions);

	my($name,$perm) = @ARGV;	#first two args are name,permissions
	mkdir $name,oct($perm) or die "cannot create $name: $!";

	rmdir glob "fred/*";	#remove all empty directories below fred/
	foreach my $dir(qw(fred barney betty)){
	  rmdir $dir or warn "cannot rmdir $dir: $!\n";
	}

	my $temp_dir = "/tmp/scratch_$$";	#based on process ID;see the text
	mkdir $temp_dir,0700 or die "cannot create $temp_dir: $!";
	...
	#use $temp_dir as location of all temporary files
	...
	unlink glob "$temp_dir/* $temp_dir/.*";	#delete contents of $temp_dir
	rmdir $temp_dir;			#delete now-empty directory

##Modifying Permissions
	chmod 0755,"fred","barney";

##Changing Ownership
	my $user = 1004;
	my $group = 100;
	chown $user,$group,glob "*.o";

	defined(my $user = getpwnam "merlyn") or die "bad user";
	defined(my $group = getgrnam "users") or die "bad group";
	chown $user,$group,glob "/home/merlyn/*";

##Changing Timestamps
	my $now = time;
	my $ago = $now -24 * 60 * 60;	#seconds per day
	utime $now,$ago,glob "*";	#set access to now,mod to a day ago

##Exercises
#The programs here are potentially dangerous.Test them in a mostly empty directory to make it difficult to accidentlly delete something useful.
#See Appendix A for answers to the following exercises:
#1.[12]Write a program to ask the user for a directory name and change to that directory.If the user enters a line with nothing but whitespace,change to his or her home directory as a default.After changing,list the ordinary directory contents(not the items whose names begin with a dot) in alphabetical other.(Hint:Will that be easier to do with a directory handle or with a glob?)If the directory change doesn't succeed,alert the user but don't try show the contents.
#2.[4]Modify the program to include all files and not just the ones that don't begin with a dot.
#3.[5]If you used a directory handle for the previous exercise,rewrite it to use a glob.If you used a glob,try it now with a directory handle.
#4.[6]Write a program that works like rm,deleting any files named on the command line.(You don't need to handle any of the options of rm.)
#5.[10]Write a program that works like mv,renaming the first command-line argument to the second command-line argument.(You dont't need to handle any of the options of mv or additional arguments.)Allow for the destination to be a directory;if it is,use the same original basename in the new directory.
#6.[7]If your operating system supports it,write a program that works like In,making a hard link from the first command-line argument to the second.(You don't need to handle link from options of In or more arguments.)If your system doesn't have hard links,print out a message telling what operation you would perform if it were available.Hint:This program has something in common with the previous one and recognizing that could save your time in coding.
#7.[7]If your operating system supports it,fix up the program from the previous exercise to allow an optional -s switch before the other arguments to indicate you want to make a soft link instead of a hard link.(Even if you don't have hard links,see whether you can at least make soft links with this program.)
#8.[7]If you operating system supports it,write a program to find any symbolic links in the current directory and print out their values(like ls -l would: name ->value).