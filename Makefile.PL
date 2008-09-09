use ExtUtils::MakeMaker;

WriteMakefile(
   NAME => 'YAML::DBH',
   VERSION_FROM => 'lib/YAML/DBH.pm',


   # gen /usr/bin/pmused by Tue Sep  9 15:57:37 EDT 2008 
   PREREQ_PM => {
      'DBD::mysql'                        => '3.0002',
      'DBI'                               => '1.607',
      'Exporter'                          => '5.58',
      'Test::Simple'                      => '0.8',
      'YAML'                              => '0.62',
   },


   EXE_FILES => [],
);


