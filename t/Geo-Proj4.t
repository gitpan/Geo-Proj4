#Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Geo-Proj4.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More qw(no_plan);
use blib;
use strict;

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

use_ok('Geo::Proj4');



ok(1,'Start testing Lat/Long to/from UTM');

my $proj = Geo::Proj4->new( proj => "utm", zone => 10 );
isa_ok($proj, "Geo::Proj4");

# convert from lat/long to UTM

my $rv;
$rv->[0] = {
		lat=>38.40249, 
		long=>-122.82888, 
		northing=>4250487, 
		easting=>514941,
		name=>"imaginary"
	};


$rv->[1] = {
		lat=>38.40342, 
		long=>-122.81856, 
		northing=>4250592,
		easting=>515842,
		name=>"O'Reilly"
	};

$rv->[2] = {
		lat=>37.73960, 
		long=>-122.41980, 
		northing=>4177082,
		easting=>551119,
		name=>"Unicorn Precinct"
	};



foreach my $c (@$rv) {
	my ($x, $y) = $proj->forward($c->{'lat'}, $c->{'long'});
	is( int $x, $c->{easting}, "$c->{'name'} conversion to UTM: x is correct $x, $c->{'easting'}" );
	is( int $y, $c->{northing}, "$c->{'name'} conversion to UTM: y is correct $y, $c->{'northing'}" );
	my ($lat, $long) = $proj->inverse($x, $y);
	is( int $lat, int $c->{lat}, "inverse conversion: lat is correct $lat, $c->{lat}" );
	is( int $long, int $c->{long}, "inverse conversion: long is correct $long, $c->{long}" );
}



my ($long, $lat) = ( -122.82888, 38.40249);
my ($x, $y) = $proj->forward($lat, $long);
is( int $x, 514941, "conversion to UTM: x is correct $x, 514941" );
is( int $y, 4250487, "conversion to UTM: y is correct $y, 4250487" );


my ($lat2, $long2) =  $proj->inverse($x, $y);
is( int $lat, int $lat2, "inverse conversion: lat is correct $lat, $lat2" );
is( int $long, int $long2, "inverse conversion: long is correct $long, $long2" );


($long, $lat) = ( -122.82888, 38.40249);
for (0..10) {
	($x, $y) = $proj->forward($lat, $long);
	($lat, $long) =  $proj->inverse($x, $y);
}

is( int $x, 514941, "Run 10 times conversion to UTM: x is correct $x, 514941" );
is( int $y, 4250487, "Run 10 times conversion to UTM: y is correct $y, 4250487" );
is( int $lat, int $lat2, "Run 10 times inverse conversion: lat is correct $lat, $lat2" );
is( int $long, int $long2, "Run 10 times inverse conversion: long is correct $long, $long2" );
