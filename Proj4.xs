#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"
#include <proj_api.h>
#include <math.h>

MODULE = Geo::Proj4	PACKAGE = Geo::Proj4

projPJ
new_proj4 (defn)
	char * defn
    CODE:
	RETVAL = pj_init_plus(defn);
    OUTPUT:
	RETVAL

SV *
forward (proj, lat, lon)
	projPJ proj
	double lat
	double lon
    PREINIT:
	projUV in, out;
    PPCODE:
	in.u = lon * DEG_TO_RAD;
	in.v = lat * DEG_TO_RAD;
	out = pj_fwd( in, proj );
	if (out.u == HUGE_VAL && out.v == HUGE_VAL) 
	    XSRETURN_UNDEF;
	EXTEND(SP, 2);
	PUSHs(sv_2mortal(newSVnv(out.u)));
	PUSHs(sv_2mortal(newSVnv(out.v)));

SV *
inverse (proj, x, y)
	projPJ proj
	double x
	double y
    PREINIT:
	projUV in, out;
    PPCODE:
	in.u = x;
	in.v = y;
	out = pj_inv( in, proj );
	if (out.u == HUGE_VAL && out.v == HUGE_VAL) 
	    XSRETURN_UNDEF;
	out.u *= RAD_TO_DEG;
	out.v *= RAD_TO_DEG;
	EXTEND(SP, 2);
	PUSHs(sv_2mortal(newSVnv(out.v)));
	PUSHs(sv_2mortal(newSVnv(out.u)));

void
DESTROY(proj)
	projPJ proj
    PROTOTYPE: $
    CODE:
	pj_free(proj);
