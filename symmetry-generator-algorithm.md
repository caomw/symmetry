# Symmetry Project

## Notes on MATLAB code from Alasdair Clarke

### Code used in

Clarke, A. D. F., Green, P. R., Halley, F., & Chantler, M. J. (2011). Similar Symmetries: The Role of Wallpaper Groups in Perceptual Texture Similarity. Symmetry, 3(2), 246–264. <http://doi.dx.org/doi:103390/sym3020246>

## 2013-04-14-08:44

### Tiling algorithm

#### 1. Make elemental tile region.

Assumes square lattice. Elemental tile must not have intrinsinc reflection or rotational symmetry, but the use of random textures effectively ensures this.

Dimensions of elemental tile:

[ n n ] 	: p1
[ n n/2 ]	: p2
[ n/2 n ]	: pg, pm, pgg
[ n/2 n/4 ] : cm
[ n/2 n/2 ]	: pmm, pmg, p4, p4m
[ n/4 n/4 ] : cmm
[ n/4 n/2 ] = p4g

#### 2. Transform (rotate, horiz_rev, vert_rev ) tile

p2 	: { tile, rotate( tile, 180 ) }
pm 	: { tile, reverse( tile, 'horiz') }
pg 	: { tile, reverse( tile, 'vert' ) }
cm 	: { tile, reverse( tile, 'vert' ) }
pmm : { tile, reverse( tile, 'vert' ), reverse( tile, 'horiz'), reverse( tile, 'both') }
pmg : { tile, reverse( tile, 'vert' ), reverse( tile, 'horiz'), reverse( tile, 'both') }
pgg : ?? triangular replication
cmm : { tile, reverse( tile, 'vert'), ?? }
p4 	: { tile, rotate( tile, 270), rotate( tile, 180), rotate( tile, 90) }
p4m : { tile, rotate( tile, 270), rotate( tile, 180), rotate( tile, 90) }
p4g : { tile, reverse( tile, 'horiz'), rotate( tile, 270), rotate( tile, 180), rotate( tile, 90) }

#### 3. Create motif

Arrange to create [ n n ] motif combining components from in 2D arrangement.

p1_motif : [ tile ]

p2_motif : [ tile rot180 ]

pm_motif : [ 	revHoriz;
	   			tile ]

pg_motif : [ 	tile;
       			revVert ]

cm_motif : [ 	tile 	revVert tile 	revVert;
	   			revVert  tile    vertRev tile ];

pmm_motif : [ 	tile 		revVert;
				revHoriz	revBoth ];

pmg_motif : [ 	revBoth		tile;
				revVert		revHoriz ];

p4_motif : [ 	tile 	rot270;
				rot90	rot180 ];


p4m_motif : [ 	tile 	rot270;
				rot90	rot180 ];

p4m_motif : [ 	tile 	rot270;
				rot90	rot180 ];

#### 4. Replicate motif across 2D plane

Replicate motif based on screen size N in pix
reps = round( N / n)

p1, p2, pm, pg, cm, pmm, pmg, p4m, p4g : repmat( tile, [ reps reps ] )
cmm : repmat(tile, [round(N/(4*n)), round(N/(4*n))])


----
