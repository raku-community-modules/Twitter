use Twitter::OAuth;
unit role Twitter::UA does Twitter::OAuth;

use HTTP::Tinyish;
use Data::Dump;

has $.ua = HTTP::Tinyish.new(agent => "Mozilla/4.0");

method post ($update) {
    say $.ua.post: 'https://api.twitter.com/1.1/statuses/update.json',
        # headers => {

        # },
        content => 'status=test'; #"status=$update";
}

method sign ($method, $url) {

}
