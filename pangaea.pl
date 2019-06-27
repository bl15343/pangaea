#!/usr/bin/perl

use warnings;
use strict;

use v5.10.1;

use Army;

my $blue_army = Army->new();
my $red_army = Army->new();

system('clear');
say "\nWelcome to Pangaea, Risk's geographically ignorant cousin";
say "The gameflow is very similar. First each army will pick a starting continent";
say "And by continent, I mean immediately adjacent area";
say "Each continent will have different random chances of increasing or decreasing";
say "your army's strength, defense, dexterity or size in number";
say "\n\nThe game is over when an army has no more soldiers available for deployment";
