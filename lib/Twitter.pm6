use HTTP::Tinyish;
use Data::Dump;
unit class Twitter:ver<1.001001>;

has $.ua = HTTP::Tinyish.new(agent => "Mozilla/4.0");

method post ($update) {
    say $.ua.post: 'https://api.twitter.com/1.1/statuses/update.json',
        # headers => {
            
        # },
        content => 'status=test'; #"status=$update";
}
