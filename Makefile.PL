use inc::Module::Install;
name		( 'Geo-Proj4' );
author
    ( 'Schuyler Erle <schuyler@nocat.net>, Rich Gibson <rich@nocat.net>' );
version_from	( 'Proj4.pm' );
libs		( ['-lproj'] );
license		( 'perl' );
requires	( perl => 5.006 );

&WriteAll;
