#!/usr/bin/perl

use warnings;
use strict;

use v5.10.1;

use Getopt::Long;

use Army;


my $blue_army_location;
my $red_army_location;

GetOptions (
    "blue-army-continent=s" => \$blue_army_location,
    "red-army-continent=s" => \$red_army_location,
);


say "\nWelcome to Pangaea, Risk's geographically ignorant cousin";
say "The gameflow is very similar. First each army will pick a starting continent";
say "And by continent, I mean immediately adjacent area";
say "Each continent will have different random chances of increasing or decreasing";
say "your army's strength, defense, dexterity or size in number";

say "\n\nThe higher your army's stength attribute, the more likely an individual soldier will succeed on a given attack\n";

say "The higher your army's defense attribute, the more likely an individual soldier will succeed on a given defense\n";

say "The higher your army's dexterity attribute, the more likely an individual soldier will not miss in an attack and evade in a defense move\n";

say "Gameplay is as follows. You will have a choice on what to do for each turn (Recruit, Attack, Do Nothing)\n";
say "The next army's turn will follow immediately.\n\n";
say "You will start with 100 soldiers in your army, with continent selection being a possible modifier";

say "\n\nThe game is over when an army has no more soldiers available for deployment\n\n";
say "\n\nBoth armies can start on the same continent\n\n";

usage() if missing_args();

use constant BLUE => 0;
use constant RED => 1;

my @armies = (
    Army->new( location => $blue_army_location ),
    Army->new( location => $red_army_location ),
);

my $current_player_army = BLUE;
my $opposing_player_army = RED;

my %army_color_lut = (
    0 => 'blue',
    1 => 'red',
);


say "$current_player_army";

while ( $armies[BLUE]->num_alive > 0 && $armies[RED]->num_alive > 0 ) {

    say "Current army: $army_color_lut{$current_player_army} " . $armies[$current_player_army]->num_alive ." soldiers alive select an action: [recruit, attack, nothing]";
    my $action = <STDIN>;
    chomp $action;

    if ( lc $action eq 'recruit') {
        my $num_recruits = $armies[$current_player_army]->recruitment_roll();
        say  "Recruited $num_recruits soldiers to your cause. Current size of army is: " . $armies[$current_player_army]->num_alive;
    }
    elsif ( lc $action eq 'attack' ) {

        my @attack_rolls;

        for (my $a_rolls = 0; $a_rolls < $armies[$current_player_army]->num_alive; $a_rolls++ ) {
            push @attack_rolls, $armies[$current_player_army]->attack_roll();
        }

        my @defense_rolls;

        for (my $d_rolls = 0; $d_rolls < $armies[$opposing_player_army]->num_alive; $d_rolls++ ) {
            push @defense_rolls, $armies[$opposing_player_army]->defense_roll();
        }


        my $attacking_dead = 0;
        my $defending_dead = 0;

        my $roll_count;

        if ( scalar @defense_rolls <=  scalar @attack_rolls ) {
            $roll_count = scalar @defense_rolls;
        }
        else {
            $roll_count = scalar @attack_rolls;
        }

        for ( my $d_rolls = 0; $d_rolls < $roll_count; $d_rolls++ ) {
            if ( $defense_rolls[$d_rolls ] >= $attack_rolls[$d_rolls] ) {
                $attacking_dead++;
            }
            else {
                $defending_dead++;
            }
        }

        $armies[$current_player_army]->num_alive( $armies[$current_player_army]->num_alive - $attacking_dead );
        $armies[$opposing_player_army]->num_alive( $armies[$opposing_player_army]->num_alive - $defending_dead );


        say "Attacking army lost $attacking_dead soldiers . Defending army lost $defending_dead soldiers";

    }
    elsif ( lc $action eq 'nothing' ) {
        #Do nothing
    }
    else {
        say 'Invalid action, you lost your turn';
    }

    if ($current_player_army == BLUE) {
        $current_player_army = RED;
        $opposing_player_army = BLUE;
    }
    else {
        $current_player_army = BLUE;
        $opposing_player_army = RED;
    }
}


if ( $armies[BLUE]->num_alive > 0 && $armies[RED]->num_alive == 0) {
    say "Congratulations to the Blue army for winning the battle!";
}
elsif ($armies[BLUE]->num_alive == 0 && $armies[RED]->num_alive > 0) {
    say "Congratulations to the Red army for winning the battle!";
}
else {
    say "EVERYBODY LOSES!";
}

sub usage {

        say "Usage: perl pangaea.pl --blue-army-continent [NA,SA,EU,AF,AU,AS,AT] --red-army-continent [NA,SA,EU,AF,AU,AS,AT]\n\n";
        say "Continent attribute modifiers:";
        print_continent_attribute_modifiers();
        exit;

}

sub missing_args {
    if ( !$red_army_location || !$blue_army_location ){
        return 1;
    }

    return 0;
}

sub print_continent_attribute_modifiers {

    my %continents = (
    'NA' => #North America
        [
            'North America: (NA)',
            'Random increase to defense',
            'Random increase to dexterity'
        ],
    'SA' => #South America
        [
            'South America: ',
            'Random increase to defense',
            'Random increase to strength',
            'Random decrease to dexterity',
        ],
    'EU' => #Europe
        [
            'Europe: ',
            'Random increase to dexterity',
            'Random increase to defense',
        ],
    'AF' => #Africa
        [
            'Africa: ',
            'Random increase to strength',
            'Random increase to defense',
            'Random increase to dexterity',
            'Decrease base army size by 25',

        ],
    'AS' => #Asia
        [
            'Asia: ',
            'Random chance of losing immediately',
            'Double army size otherwise'

        ],
    'AU' =>  #Australia
        [
            'Australia: ',
            'Random decrease to strength',
            'Random decrease to defense',
            'Random decrease to dexterity',
            'Increase base army size by 25',
        ],
    'AT' => #Antarctica
        [
            'Antarctica: ',
            'Random chance of losing immediately',
            'Double stats otherwise'
        ],


    );

    foreach my $continent ( keys %continents ) {
        foreach my $attributes ( @{ $continents{$continent} } ) {
            say $attributes;

        }

        say "\n\n";
    }
}








#ENUM to track state of who is currently in play, push them into a hash or something and
#refer to the active army that way
#Do this in a simple while loop, while both armies have num_alive greater than 0




