use lib 'lib';

use Twitter;
my Twitter $t .= new: |EVALFILE 'keys';

$t.tweet: 'Testing';
