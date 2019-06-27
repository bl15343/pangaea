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


1;
