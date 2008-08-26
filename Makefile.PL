use ExtUtils::MakeMaker;

WriteMakefile(
   NAME => 'YAML::DBH',
   VERSION_FROM => 'lib/YAML/DBH.pm',


   # gen /usr/bin/pmused by Tue Aug 26 10:29:15 EDT 2008 
   PREREQ_PM => {
      'DBI'                               => '1',
      'Exporter'                          => '5',
      #'Smart::Comments'                   => '1.0.2',
      'Test::Simple'                      => '0',
      'YAML'                              => '0',
   },


   EXE_FILES => [],
);


