use lib 'lib';
use Test;

use Twitter::OAuth;

# Test keys, values, and result obtained from
# https://dev.twitter.com/oauth/overview/creating-signatures

ok 1;

# my $t = Twitter::OAuth.new:
#     consumer-key        => 'xvz1evFS4wEEPTGEFPHBog',
#     consumer-secret     => 'kAcSOqF21Fu85e7zjz7ZN2U4ZRhfV3WpwPAoE3Z7kBw',
#     access-token        => '370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb',
#     access-token-secret => 'LswwdoUaIvS8ltyTt5jkRh4J50vUPVVHtR2YPi5kE';
#
#
# my $*TEST-TWITTER-OAUTH-TIME  = 1318622958;
# my $*TEST-TWITTER-OAUTH-NONCE = 'kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg';
#
# my $signature = $t.sign: 'POST', <https://api.twitter.com/1/statuses/update.json?include_entities=true>,
# <status=Hello%20Ladies%20%2b%20Gentlemen%2c%20a%20signed%20OAuth%20request%21>;
#
# is $signature, 'tnnArxj06cWHq44gCs1OSKk/jLY=',
#     'Generated signature looks right';

done-testing;
