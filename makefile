


example_1 :
	perl main.pl -design            ./example/in_1/top_1.v   \
		     -power_intent      ./example/in_1/power_1.p \
		     -library           ./example/in_1/lib_1.v   \
		     -output_design     rst_1.v                  \
		     -domain_map        rpt_1.r                  \
		     -top_design_name   TOP


example_2 :
	perl main.pl -design            ./example/in_2/top_2.v   \
		     -power_intent      ./example/in_2/power_2.p \
		     -library           ./example/in_2/lib_2.v   \
		     -output_design     rst_2.v                  \
		     -domain_map        rpt_2.r                  \
		     -top_design_name   TOP

clean    :
	rm *.v
	rm *.r
