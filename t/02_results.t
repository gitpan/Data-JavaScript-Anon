#!/usr/bin/perl

# Formal testing for Data::JavaScript::Anon

# This only tests that it loads successfully

use strict;
use lib '../../modules'; # For development testing
use lib '../lib'; # For installation testing
use UNIVERSAL 'isa';
use Test::More tests => 70;
use Data::JavaScript::Anon;

BEGIN { $| = 1 }

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
is( $rv, '[ "a", 1, { a: { a: 1 } }, "foo" ]', 'Generates expected output for simple combination struct' );

1;
