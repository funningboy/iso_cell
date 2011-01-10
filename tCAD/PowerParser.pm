#! /usr/bin/perl

package tCAD::PowerParser;
use Parse::RecDescent;
use Data::Dumper;
use strict;

#    $::RD_TRACE=1;        # if defined, also trace parsers' behaviour
#    $::RD_AUTOSTUB=1;     # if defined, generates "stubs" for undefined rules
#    $::RD_AUTOACTION=1;   # if defined, appends specified action to productions
    $::RD_HINT=1;

my $InPowerGrammar = q {

{
use Data::Dumper; 
my  $InPowerTb ={};
}

START			: TOKEN_POWER_DOMAIN START(s?)
			{
			  $return = $item[1];
			} 
			| TOKEN_ISO_RULE START(s?)
			{
			 $return = $item[1];
			}
			| TOKEN_ISO_CELL START(s?)
			{
			 $return = $item[1];
			}

TOKEN_ISO_CELL		: 'define_isolation_cell' SLASH(?)
			  '-cells' IDENTIFIER SLASH(?)
			  '-enable' IDENTIFIER SLASH(?)
			  '-valid_location' IDENTIFIER 
			{
			  $InPowerTb->{isolation_cell}->{$item[4]} = {
			                                                iso_en => $item[7],
			                                                iso_loc=> $item[10],
								     };
			 $return = $InPowerTb;
			}

TOKEN_ISO_RULE		: 'create_isolation_rule' SLASH(?)
			  '-name' IDENTIFIER SLASH(?)
			  '-from' IDENTIFIER SLASH(?) '-to' IDENTIFIER SLASH(?)
			  '-isolation_output' IDENTIFIER SLASH(?)
			  '-isolation_condition' IDENTIFIER
			{
			 $InPowerTb->{isolation_rule}->{$item[4]} = {
			                                               iso_from   => $item[7],
			                                               iso_to     => $item[10],
			                                               iso_output => $item[13],
			                                               iso_cond   => $item[16],
                                                                    };
			 $return = $InPowerTb;
			}

TOKEN_POWER_DOMAIN	: 'create_power_domain' SLASH(?) '-name' IDENTIFIER SLASH(?) TOKEN_LIST
			{
			  $InPowerTb->{power_domain}->{$item[4]} = $item[6];
			  $return = $InPowerTb;
			}

TOKEN_LIST		: '-' 'default'
			{
			  $return = $item[2];
			}
			| '-' 'instances' LFT_BRACES IDENTIFIER(s?) RHT_BRACES
			{
			  #=========================
			  # hack constrain 2 our DD ex: I1/I2 -> I1/I2/
			  #=========================
			  my $tmp_st;
                          foreach my $inst (@{$item[4]}){
			       $inst .= '/';
			       push (@{$tmp_st},$inst);
			  }
			  $return = { $item[2] => $tmp_st};
			}

LFT_BRACKET		: '['   { $return = $item[1]; }
RHT_BRACKET		: ']'   { $return = $item[1]; }
LFT_BRACES		: '{'   { $return = $item[1]; }
RHT_BRACES		: '}'   { $return = $item[1]; }
OR			: '|'   { $return = $item[1]; }
SLASH			: '\\'  { $return = $item[1]; }

IDENTIFIER		: /[\!0-9a-zA-Z\/\_]+/ { $return = $item[1]; }
};

sub new {
    my $class = shift;
    my $self = {};
  
   bless $self, $class;
   return $self;
} 

sub parser_files { 
    my ($self,$path) = (@_);

    open(IPWER,$path) or die "input Power error\n";
    undef $/;
    my $text = <IPWER>;

    my $parse = new Parse::RecDescent($InPowerGrammar) or die 'InPowerGrammar';
    my $parse_tree = $parse->START($text) or die 'Power';
#    print Dumper($parse_tree);

   close(IPWER);
   return $parse_tree;
}
