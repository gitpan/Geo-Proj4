use 5.006;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Geo::Proj4',
    VERSION_FROM      => 'Proj4.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    LIBS              => ['-lproj'], # e.g., '-lm'
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
    # OBJECT            => '$(O_FILES)', # link all the C files too
);
