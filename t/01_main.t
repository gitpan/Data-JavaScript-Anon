#!/usr/bin/perl

# Formal testing for Data::JavaScript::Anon

# This only tests that it loads successfully

use strict;
use lib '../../modules'; # For development testing
use lib '../lib'; # For installation testing
use UNIVERSAL 'isa';
use Test::More tests => 2;

# Set up any needed globals
use vars qw{$loaded};
BEGIN {
	$loaded = 0;
	$| = 1;
}




# Check their perl version
BEGIN {
	ok( $] >= 5.005, "Your perl is new enough" );
}





# Does the module load
END { ok( 0, 'Data::JavaScript::Anon loads' ) unless $loaded; }
use Data::JavaScript::Anon;
$loaded = 1;
ok( 1, 'Data::JavaScript::Anon loads' );
