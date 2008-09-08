package YAML::DBH;
use strict;
use Exporter;
use YAML;
use vars qw(@EXPORT_OK %EXPORT_TAGS @ISA $VERSION);
@ISA = qw/Exporter/;
@EXPORT_OK = qw(yaml_dbh);
%EXPORT_TAGS = ( all => \@EXPORT_OK );
$VERSION = sprintf "%d.%02d", q$Revision: 1.3 $ =~ /(\d+)/g;

#use Smart::Comments '###';


sub yaml_dbh {
   my $arg = shift;
   $arg or die('yaml_dbh() missing argument');
   



   # 1) figure out conf 

   my $c; # conf ref

   if ( ref $arg ){ # assume a conf ref was passed (hash or array, could be both?      
      $c = $arg;
   }

   else { # assume path
      $c = YAML::LoadFile($arg) or die("cant YAML load $arg");      
   }


     
   # 2) scan conf ref for arguments

   my $username = _findkey( $c => qw(username uname user dbuser dbusername) )
      or die("missing username in $arg");
      
   my $hostname = _findkey( $c => qw(hostname host dbhost dbhostname) ) || 'localhost';

   my $password = _findkey( $c => qw(password dbpass dbpassword passw dbpassw pass))
      or die("missing password in $arg");
   
   my $database = _findkey( $c => qw(database dbname databasename))
      or die("missing database name in $arg");
   my $dbdriver = _findkey( $c => qw(dbdriver driver db_driver) ) || 'mysql';


   my $dbsource = "DBI:$dbdriver:database=$database;host=$hostname";
   
   ### $database
   ### $hostname
   ### $username
   ### $password
   ### $dbdriver
   ### $dbsource


   # 3) open handle
   require DBI;

   my $dbh = DBI->connect(
      $dbsource, 
      $username, 
      $password
   ) or die;

   return $dbh;
}





# pass it the conf hash ref, and a list of possible case insensitive key matches
sub _findkey {
   my $_hashref = shift;

   # convert the hashref
   my $c;
   map { $c->{lc($_)} = $_hashref->{$_} } keys %$_hashref;
   
   for my $_poss ( @_ ){
      my $poss = lc($_poss);
      if (exists $c->{$poss}){
         return $c->{$poss};
      }
   }
   return;

}

1;


__END__

=pod

=head1 NAME

YAML::DBH

=head1 SYNOPSIS

   use YAML::DBH 'yaml_dbh';

   my $dbh = yaml_dbh( '/home/myself/mysql_credentials.conf' );


=head2 EXAMPLE 2

   use YAML::DBH;

   my $conf = YAML::LoadFile('./file.conf');

   my $dbh  = YAML::DBH::yml_dbh($conf);


=head1 DESCRIPTION

Point and shoot method of getting a mysql database handle with only a yaml 
configuration file as argument.

This is meant for people learning perl who just want to get up and running.
It's the simplest customizable way of getting a database handle with very little code.

=head1 SUBS

Are not exported by default.

=head2 yaml_dbh()

Argument is abs path to yaml config file.
Returns DBI mysql dbh handle.

Optionally you may pass it a conf hashref as returned by YAML::LoadFile instead, to 
scan it for the parameters to open a mysql connect with, and return a database handle.


=head1 THE YAML CONFIG FILE

You basically need a text file with various parameters. We need the hostname, the username,
the password, and the name of your database to connect to. 
We allow the names of the parameters to be all kinds of silly things like 'user', 'username',
'uname','dbuser', 'DbUsEr' .. Case insensitive.
If your config file lacks hostname, we use 'localhost' by default.
You can also  specify 'driver', by default it is 'mysql'

In /etc/my.conf

   ---
   username: loomis
   host: localhost
   driver: mysql
   database: stuff
   password: stuffsee

Also acceptable:

   ---
   DBUSER: loomis
   DBHOST: tetranomicon
   DBNAME: margaux
   DBPASS: jimmy

Also acceptable:

   ---
   user; james
   pass: kumquat
   dbname: stuff

Also acceptable:

   ---
   username: jack
   password: aweg3hmva
   database: akira

=head1 SEE ALSO

L<YAML>
L<DBI>
L<DBD::mysql>

=head1 AUTHOR

Leo Charre leocharre at cpan dot org

=cut


