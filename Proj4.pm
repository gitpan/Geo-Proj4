package Geo::Proj4;

use 5.006;
use DynaLoader;
use strict;

our @ISA     = 'DynaLoader';
our $VERSION = '0.11';


# Preloaded methods go here.

sub new {
    my $class = shift;
    my @args;

    while (my ($key, $val) = splice(@_, 0, 2)) {
	if (defined $val) {
	    push @args, "+$key=$val";
	} else {
	    push @args, "+$key";
	}
    }
    
    return new_proj4( join(" ", @args) );
}

bootstrap Geo::Proj4 $VERSION;

1;

__END__

=head1 NAME

Geo::Proj4 - Wrap the powerful PROJ.4 cartographic projections library

=head1 SYNOPSIS

  use Geo::Proj4;

  my $proj = Geo::Proj4->new(
    	proj => "merc", ellps => "clrk66", lon_0 => -96 );

  my ($x, $y) = $proj->forward($lat, $lon);

  my ($lat, $lon) = $proj->inverse($x, $y);

=head1 DESCRIPTION 

This perl library converts geodetic latitude and longitude into an
enormous variety of cartographic projections and back. Geo::Proj4 uses
XS to wrap the PROJ.4 cartographic projections library. You will need
to have the PROJ.4 library installed in order to build and use this
module. You can get source code and binaries for the PROJ.4 library
from its home page at L<http://www.remotesensing.org/proj/>.  See 
L<pj_init(3)> for details on the internals.

=head1 METHODS

=over 4

=item new( %args )

  my $proj = Geo::Proj4->new(
	    proj => "merc", ellps => "clrk66", lon_0 => -96 );

The contructor accepts a hash of parameters that will be passed on to
the PROJ.4 library. You must supply a C<proj> parameter identifying the
target projection. Specify boolean parameters (e.g. the south parameter
to the UTM projection) with a matching value of undef.

Covering all the possible projections and their arguments in PROJ.4 is
well beyond the scope of this document. However, the cs2cs utility that
ships with PROJ.4 will list the projections it knows about by running
B<cs2cs -lp>, the ellipsoid models it knows with the B<-le> parameter,
the units it knows about with B<-lu>, and the geodetic datums it knows
with B<-ld>. Read L<cs2cs(1)> for more details.

Alternately, you can read the PROJ.4 documentation, which can be found
on the project's homepage. There are links to PDFs, text documentation,
a FAQ, and more.

=item forward( $lat, $lon )

  my ($x, $y) = $proj->forward($lat, $lon);

Perform a forward projection from latitude and longitude to the
cartographic projection represented by $proj. Latitude and longitude
are assumed to be in degrees, with latitude south of the Equator and
longitude west of the Prime Meridian given with negative values. $x and
$y are typically returned in meters, or whatever units are relevant to
the given projection.

If PROJ.4 encounters an error, forward() will return undef for both values.

=item inverse( $x, $y )

  my ($lat, $lon) = $proj->inverse($x, $y);

Perform an inverse projection from the cartographic projection represented
by $proj back into latitude and longitude. Units and error conditions
are as described above.

=back 

=head1 EXAMPLES

  To Convert from Lat/Long to UTM:
  #!/usr/bin/perl

  use strict;
  use Geo::Proj4;

  my $proj = Geo::Proj4->new( proj => "utm", zone => 10 );
  my ($x, $y) = $proj->forward(38.40342, -122.81856);
  print "conversion to UTM: y is  $y\n";
  print "conversion to UTM: x is  $x\n";

  my ($lat, $long) = $proj->inverse($x, $y);
  print "inverse conversion: lat is $lat \n" ;
  print "inverse conversion: long is $long \n" ;



=head1 ERRATA, BUGS, TODO, ETC.

One common source of errors is that latitude and longitude are
swapped, or that the values have the wrong sign. Make sure you give
negative values for south latitude and west longitude.

PROJ.4 offers a C<pj_transform()> function that would be really
cool to add to this module, but... PROJ.4 expects spherical coordinates
(i.e. lat and long) in radians, whereas most ordinary people think
of lat and long in degrees. Ordinarily, Geo::Proj4 takes care of this
for you transparently, but in the case of the proposed C<transform()>
method, the list of points to be transformed between two cartographic
projections might be spherical or planar in zero, one, or both of the
input and output lists. We could supply helper functions to allow a
developer to perform the degree-to-radian and reverse as needed before
or after the call to C<transform()>, but... would anyone use this,
or would you just rely on cs2cs?

Passing undef as the value to a boolean parameter is an ugly interface.

Needs more tests!  Especially of border cases.

Needs more samples in the samples directory!

=head1 SEE ALSO

PROJ.4 home page: http://www.remotesensing.org/proj/

Mapping Hacks home page: http://www.mappinghacks.com

proj(1), cs2cs(1), pj_init(3), Geo::Dymaxion(3pm), Geo::Coordinates::UTM(3pm)

=head1 AUTHORS

Schuyler Erle E<lt>schuyler@nocat.netE<gt>

Rich Gibson E<lt>rich@nocat.netE<gt>

=head1 EFFUSIVE THANKS TO...

Frank Warmerdam, maintainer of PROJ.4 and all around most excellent person.

Gerald Evenden.  'Essentially all work (on PROJ.4) was done by Gerald...'

=head1 COPYRIGHT 

Copyright (C) 2004 by Schuyler Erle and Rich Gibson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.3 or,
at your option, any later version of Perl 5 you may have available.

=cut
