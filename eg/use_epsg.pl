#!/usr/bin/perl -w
# Example contributed by Michael R. Davis

use strict;
use warnings;
use Geo::Proj4 ();

my $epsg = 26985;
my $proj = Geo::Proj4->new(init => "epsg:$epsg")
  or die "cannot use EPGS 26985: ",Geo::Proj4->error, "\n";

my ($x, $y) = (401717.80, 130013.88);
my ($lat, $lon) = $proj->inverse($x, $y);
print "  x: $x\n  y: $y\nlat: $lat\nlon: $lon\n";

__END__

=head1 NAME

Proj4 EPSG Example - Convert SPCS83 Maryland zone (meters) to WGS-84 Latitude and Longitude

=head1 Projection Input

  Code - CRS: 26985
  CRS Name: NAD83 / Maryland
  CRS Type: projected
  Coord Sys code: 4499
  CS Type: Cartesian
  Dimension: 2
  Remarks: Used in projected and engineering coordinate reference systems.
  CRS Name: NAD83
  Datum Name: North American Datum 1983
  Datum Origin: Origin at geocentre.
  Ellipsoid Name: GRS 1980
  Ellipsoid Unit: metre
  Coord Operation Name: SPCS83 Maryland zone (meters)
  Coord Op Method Name: Lambert Conic Conformal (2SP)

=head1 Output

Unprojected Latitude and Longitude, I think on the WGS-84 ellipsoid.  (but, there's not much differnce between the GRS80 and the WGS-84 ellipsoids)

=head1 Copyright

Copyright 2007 Michael R. Davis

=head1 License

MIT, BSD, Perl, or GPL (your choice)

=cut
