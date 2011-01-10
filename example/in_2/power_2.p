create_power_domain -name DEF -default
create_power_domain -name PDB -instances {IB I5/ID1 I6}
create_power_domain -name PDC -instances {IC I5 I6/IE1}
create_isolation_rule -name IS_PDB2PDC \
                      -from PDB -to PDC \
                      -isolation_output high \
                      -isolation_condition ISOB
create_isolation_rule -name IS_PDB2PDC2 \
                      -from PDB -to DEF \
                      -isolation_output high \
                      -isolation_condition ISOB
create_isolation_rule -name IS_PDC2PDB \
                      -from PDC -to PDB \
                      -isolation_output low \
                      -isolation_condition !ISOC
create_isolation_rule -name IS_PDC2PDB2 \
                      -from PDC -to DEF \
                       -isolation_output low \
                      -isolation_condition !ISOC
define_isolation_cell -cells IsoLH \
           -enable En -valid_location to
define_isolation_cell -cells IsoHL \
           -enable En -valid_location to

