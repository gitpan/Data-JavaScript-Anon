require 5.000;
use ExtUtils::MakeMaker;
WriteMakefile(
	'NAME'         => 'Data::JavaScript::Anon',
	'VERSION_FROM' => 'lib/Data/JavaScript/Anon.pm',
	'PREREQ_PM'    => {
		# For the tests
		'Test::More'       => 0,
	},
	($] >= 5.005) ? (
		'AUTHOR'     => 'Adam Kennedy (cpan@ali.as)',
		'ABSTRACT'   => 'Dump to anonymous JavaScript structs',
	) : (),
);
