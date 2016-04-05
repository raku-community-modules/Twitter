#!perl6

use lib 'lib';
use Twitter;

my $t = Twitter.new: |EVALFILE 'keys';
$t.statuses-update: "Just testing";
