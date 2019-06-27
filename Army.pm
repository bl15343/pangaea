package Army;

use v5.10.1;

use Moose;


has 'num_alive' => (
    is => 'rw',
    default => 100,
);

has 'num_dead' => (
    is => 'rw',
    default => 0,
);

has 'location' => (
    is => 'rw',
    required => 1
);

has 'defense' => (
    is => 'rw',
    default => 10,
);

has 'strength' => (
    is => 'rw',
    default => 10,
);

has 'dexterity' => (
    is => 'rw',
    default => 10,
);

#On object instantiation, run this
sub BUILD {
    my $self = shift;
    $self->_modify_stats_based_on_location();
}

sub _modify_stats_based_on_location {
    my $self = shift;
    my %location_lut = (

    );
}

sub attack_roll {
    my $self = shift;
    return int(rand(6)) * $self->strength;
}

#Recruitment up to 5 new soldiers per recruitment_roll
sub recruitment_roll {
    my $self = shift;
    my $recruits = $self->num_alive % (int(rand(6)) + 1 ) ;
    $self->num_alive( $self->num_alive + $recruits );
    return $recruits;
}

sub defense_roll {
    my $self = shift;
    return int(rand(6)) * $self->defense;
}

1;
