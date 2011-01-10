create_power_domain -name DEF -default
create_power_domain -name PDB -instances {I1}
create_isolation_rule -name IS_PDB2PDC2 \
-from PDB -to DEF \
-isolation_output high \
-isolation_condition ISO
define_isolation_cell -cells IsoLH \
-enable En -valid_location to
define_isolation_cell -cells IsoHL \
-enable En -valid_location to
