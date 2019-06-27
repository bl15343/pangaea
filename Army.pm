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

sub attack_roll {
    my $self = shift;
    return int(rand(6)) * $self->strength;
}

#Recruitment up to 5 new soldiers per recruitment_roll
sub recruitment_roll {
    my $self = shift;
    return $self->num_alive % int(rand(6));
}

sub defense_roll {
    my $self = shift;
    return int(rand(6)) * $self->defense;
}

1;
