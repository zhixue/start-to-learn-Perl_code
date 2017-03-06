####CHAPTER 15 Perl Modules####

##Finding Modules
#Before you go looking for a module,check if it has been installed already.One way is to try to read the cocumentation with perldoc.The CGI.pm module comes with Perl.
	$perldoc CGI
#Try it with a module that doesn't exist,and you'll get an error message.
	$perldoc Llamas
	$No ducumentation found for "Llamas"

##Install Modules
	$perl Makefile.PL
	$make install

	$perl Makefile.PL
	$./Build install

	$perl -MCPAN -e shell

	$cpan Module::COreLList LWP CGI::Prototype

##Using Simple Modules
	my $name = "/usr/local/bin/perl";
	(my $basename = $name) =~ s#.*/##;	#Oops!

####The File::Basename Module
	use File::Basename;

	my $name = "/usr/local/bin/perl";
	my $basename = basename $name;	#gives 'perl'

####Using Only Some Functions from a Module
	use File::Basename qw/ basename /;

	use File::Basename qw/ /;

	use File::Basename ();
#When they're not imported,we have to call them by their full names:
	use File::Basename qw / /;	#import no function names
	my $betty = &dirname($wilma);	#uses our own subroutine &dirname

	my $name = "/usr/local/bin/perl";
	my $dirname = File::Basename::dirname $name;	#dirname from the module

####The File::Spec Module
#take a filename like /home/rootbeer/ice-2.1.txt and add a prefix to the basename:
	use File::Basename;

	print "Please enter a filename: ";
	chomp(my $old_name = <STDIN>);

	my $dirname = dirname $old_name;
	my $basename = basename $old_name;

	$basename =~ s/^/not/;	#Add a prefix to the basename
	my $new_name = "$dirname/$basename";

	rename($old_name,$new_name)
	  or warn "Can't rename '$old_name' to '$new_name': $!";

#The difference is that you'll always call the methods from File::Spec with their full names,like this:
	use File::Spec;

	#get the values for $dirname and $basename as above

	my $new_name = File::Spec->catfile($dirname,$basename);
	rename($old_name,$new_name)
	  or warn "Can't rename '$old_name' to '$new_name': $!";

####CGI.pm
	#!/usr/bin/perl
	use CGI qw(:all);
	print header("text/plain");
	foreach my #param(param())
		{
		print "$param: " . param($param) . "\n";
		}


	#!/usr/bin/perl
	use CGI qw(:all);
	print header(),
		start_html("This is the page title");
		h1("Input parameters");

	my $list_items;
	foreach my $param ( pararm() )
		{
		$list_items .= li("$param:" . param($param) );
		}

	print ul($list_items);
	print end_html();

####Databases and DBI
	use DBI;
	$dbh = BDI->connect($data_source,$username,$password)
	my $data_source = "dbi:Pg;dbname=name_of_database";

	$sth = $dbh->prepare("SELECT * FROM foo WHERE bla");
	$sth->execute();
	@row_ary = $sth->fetchrow_array;
	$sth->finish;

	$dbh->disconnect();

##Exercise
#See Appendix A for answers to following exercise:
#1.[15]Install the Module::CoreList module from CPAN.Print a list of all of the modules that came with Perl 5.006.To build a hash whose keys are the names of the modules that came with a given version of Perl,use this line:
	my %modules = %{ $Module::CoreList::version{5.006} };
#2.[15]Get a list of filenames in the current directory.Use the Cwd module to get current directory,then use the File::Spec module to join the directory name with the filenames to get an absolute path.Print the list of paths to standard output with one path per line.Your solution should be portable to other operating system.
#3.[15]Using the output from the previous exercise,read in a list of paths and use the File::Basename module to extract the filename from each path.Print each name on a line by itself.Your solution should be portable to other operating systems.