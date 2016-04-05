#!perl6

use lib 'lib';
# use Twitter;

use Twitter::OAuth;
my $t = Twitter::OAuth.new: |EVALFILE 'keys';
say $t.sign: 'POST', <https://api.twitter.com/1/statuses/update.json?include_entities=true>,
<status=Hello%20Ladies%20%2b%20Gentlemen%2c%20a%20signed%20OAuth%20request%21>;

# my $t = Twitter.new: |EVALFILE 'keys';
# $t.statuses-update: "Just testing";
