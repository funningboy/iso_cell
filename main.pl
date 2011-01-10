#! /usr/bin/perl

use tCAD::VeriParser;
use tCAD::PowerParser;
use tCAD::util;
use tCAD::RunISO;

use Data::Dumper;
use File::Path qw(make_path remove_tree);
use strict;

sub get_usage {
  print STDOUT '

#=============================================#
# Isolation Cell Insertion for Low Power Design
# author : sean chen
# mail   : funningboy@gmail.com
# license: FBS
# publish: 2011/01/07 v1
# project reference :  http://adar.ee.nctu.edu.tw/project.php
# bakup reference   :  https://docs.google.com/document/pub?id=1-0EMqlEeeYJ0CpMD6PdoXvV2ih1Dm30dTo1gZWLv2a4
#=============================================#

<USAGE>

  -design          [ design_file_list ]
  -power_intent    [ power_spec_filename ]
  -library         [ library_file_list ]
  -output_design   [ ouput_design_file_name ]
  -domain_map      [ isolation_domain_map_file_name ]
  -top_desing_name [ top_design_module_name ]

</USAGE>

ex: perl main.pl -design in/inDes.v -power_intent in/PI.spec -library in/Lib.v \
                 -output_design out/mDes.v -domain_map out/domain.map -top_design_name TOP 
';
die "\n";
}

my $sel;
my $chk =0;
my @design;
my $power_intent;
my @library;
my $output_design;
my $domain_map;
my $top_design_name;

if(!@ARGV){ get_usage(); }

while(@ARGV){
  $_ = shift @ARGV;

    if( /-design/         ){ $sel = 0; $chk++; }
 elsif( /-power_intent/   ){ $sel = 1; $chk++; }
 elsif( /-library/        ){ $sel = 2; $chk++; }
 elsif( /-output_design/  ){ $sel = 3; $chk++; }
 elsif( /-domain_map/     ){ $sel = 4; $chk++; }
 elsif( /-top_design_name/){ $sel = 5; $chk++; }
 
    if($sel == 0 ){ push (@design,    shift @ARGV); }
 elsif($sel == 1 ){ $power_intent   = shift @ARGV;  }
 elsif($sel == 2 ){ push (@library,   shift @ARGV); }
 elsif($sel == 3 ){ $output_design  = shift @ARGV;  }
 elsif($sel == 4 ){ $domain_map     = shift @ARGV;  }
 elsif($sel == 5 ){ $top_design_name= shift @ARGV;  }

} 

 if($chk!=6){
   get_usage();
  }

#===========================================
# cat design && lib files
#===========================================
foreach my $dsgn (@design){
   `cat $dsgn >> iveri.iv`; 
}
foreach my $lib (@library){
   `cat $lib >> iveri.iv`;
}

#============================================
# parser verilog file
# @ input  : verilog file
# @ return : verilog_DD
#============================================
my $veri_ptr = tCAD::VeriParser->new();
my $veri_rst = $veri_ptr->parser_files('iveri.iv');

#===========================================
# parse power file
# @ input  : power constrain file
# @ return : power_DD
#===========================================
my $power_ptr = tCAD::PowerParser->new();
my $power_rst = $power_ptr->parser_files($power_intent);

#==========================================
# check desgin && power match or not?
#==========================================
my $util_ptr  = tCAD::util->new();
   $util_ptr->set_verilog_DD($veri_rst);
   $util_ptr->set_power_DD($power_rst);

   $util_ptr->get_check_rst($top_design_name);
   $util_ptr->get_debug();
   $util_ptr->free_all();

my $run_ptr   = tCAD::RunISO->new($util_ptr);
   $run_ptr->runISO_INI($top_design_name);
   $run_ptr->runISO_OPT();
   $run_ptr->runEXP_nVerilog($output_design);
   $run_ptr->runDebug();
   $run_ptr->runReport($domain_map);
   $run_ptr->free_all();

`rm iveri.iv`;
