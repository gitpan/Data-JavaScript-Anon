#!/usr/bin/perl

# Formal testing for Data::JavaScript::Anon

# This only tests that it loads successfully

use strict;
use lib '../../modules'; # For development testing
use lib '../lib'; # For installation testing
use UNIVERSAL 'isa';
use Test::More tests => 1;
use Data::JavaScript::Anon;

BEGIN { $| = 1 }

my $rv = Data::JavaScript::Anon->anon_dump( [ 'a', 1, { a => { a => 1, } }, \"foo" ] );
ok( $rv eq '[ "a", 1, { a: { a: 1 } }, "foo" ]', 'Generates expected output' );

1;
