use Twitter;
my Twitter $t .= new: |EVAL-FILE 'keys';

$t.tweet: 'This may be the first ever tweet tweeted by a #Perl6 program \o/ #Programming';
