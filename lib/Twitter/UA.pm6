use Twitter::OAuth;
unit role Twitter::UA does Twitter::OAuth;

use HTTP::Tinyish;
use JSON::Fast;
use URI::Escape;

has $!ua      = HTTP::Tinyish.new(agent => "Mozilla/4.0");
has $!api-url = 'https://api.twitter.com/1.1/';

method request ($method, $action, %params) {
    my $body
    = %params.kv.map(&uri-escape).hash.sort.map(*.kv.join: '=').join: '&';

    my $url = [~] $!api-url, $action, '.json', |("?$body" if $method eq 'GET');

    my ($signature, $nonce, $timestamp) = self!sign: $method, $url, $body;

    my $auth-header = [~] qq{OAuth oauth_consumer_key="$.consumer-key",},
        qq{ oauth_nonce="$nonce", oauth_signature="$signature",},
        qq{ oauth_signature_method="HMAC-SHA1", oauth_timestamp="$timestamp",},
        qq{ oauth_token="$.access-token", oauth_version="1.0"};

    my %res = do given $method {
        when 'POST' {
            $!ua.post: $url,
                headers => { 'Authorization' => $auth-header },
                content => $body;
        }
        when 'GET' {
            $!ua.get: $url, headers => { 'Authorization' => $auth-header };
        }
    }

    %res<success> or fail "ERROR %res<status>: %res<reason>";
    return from-json %res<content>;
}
