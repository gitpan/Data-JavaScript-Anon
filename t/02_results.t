#!/usr/bin/perl -w

# Testing for Data::JavaScript::Anon

use strict;
use lib ();
use UNIVERSAL 'isa';
use File::Spec::Functions ':ALL';
BEGIN {
	$| = 1;
	unless ( $ENV{HARNESS_ACTIVE} ) {
		require FindBin;
		chdir ($FindBin::Bin = $FindBin::Bin); # Avoid a warning
		lib->import( catdir( updir(), updir(), 'modules') );
	}
}

use Test::More tests => 74;
use Data::JavaScript::Anon;

# Thoroughly test the numeric tests
my @numbers = qw{
	0 1 2 3 4 5 6 7 8 9 10 11 123455 +1 +0 +5 +10 +123213 -0 -1 -5 -10 -12321133
	0.0 .0 1.0 1.1 10.1 10.01 111111.111111 +111111.111111 -1111111.000100
	1e0 1e1 1e2 1e10 1e+1 1e+2 1e+0 1e+10 1e-0 1e-1 1e-10
	2e+0002 31.31e-000200430 +41.420010E+222211 -5111.050E-5151
	0x2131 0xaaad32 -0x21312 +0x212 +0X212
	01 02 03 04 05 01251 002123 00000
	};
my @not_numbers = qw{
	a 09 +09 -09 ++1 +-34 
	3com 2131.231fd2132 +0x21x
};
foreach ( @numbers ) {
	ok( Data::JavaScript::Anon->is_a_number( $_ ), "$_ is a number" );
}
foreach ( @not_numbers ) {
	ok( ! Data::JavaScript::Anon->is_a_number( $_ ), "$_ is not a number" );
}




# Do a simple test of most of the code in a single go
my $rv = Data::JavaScript::Anon->anon_dump( [ 'a', 1, { a => { a => 1, } }, \"foo" ] );
is( $rv, '[ "a", 1, { a: { a: 1 } }, "foo" ]',
	'Generates expected output for simple combination struct' );

# Test for CPAN bug #7183
is( Data::JavaScript::Anon->anon_hash_key( "0596000278" ), '"0596000278"',
	'anon_hash_key correctly escapes 0-leading non-octal' );

# Test for CPAN bug #11882 (forward slash not being escaped)
is( Data::JavaScript::Anon->anon_scalar( 'C:\\devel' ), '"C:\\\\devel"',
	'anon_scalar correctly escapes forward slashes' );

# Also make sure double quotes are escaped
is( Data::JavaScript::Anon->anon_scalar( 'foo"bar' ), '"foo\\"bar"',
	'anon_scalar correctly escapes double quotes' );

# Test for generalised case of CPAN bug # (newline not being escaped)
$rv = Data::JavaScript::Anon->anon_dump( [ "a\nb", "a\rb", "a	b", "a\"b", "a\bb" ] );
is( $rv, '[ "a\nb", "a\rb", "a\tb", "a\\"b", "a\010b" ]', 'escape tabs, newlines, CRs and control chars');


1;
