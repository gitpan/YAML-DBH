use Test::Simple 'no_plan';
use lib './lib';
use YAML::DBH 'yaml_dbh';

ok(1,'loaded module, for further testing see README');

my $conf;

ok $conf = YAML::LoadFile('./t/dbh_yaml.conf');


ok yaml_dbh($conf),'opened from conf instead of path';



