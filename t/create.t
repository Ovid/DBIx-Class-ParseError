use lib 't/lib';
use strict;
use warnings;
use Test::Roo;

with qw(SQLite Create);

run_me('create');

done_testing;