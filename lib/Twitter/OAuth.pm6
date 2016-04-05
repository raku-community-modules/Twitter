unit role Twitter::OAuth;

use Base64;
use Digest::SHA;
use Digest::HMAC;
use URI;
use URI::Escape;

has Str:D $.consumer-key        is required;
has Str:D $.consumer-secret     is required;
has Str:D $.access-token        is required;
has Str:D $.access-token-secret is required;

method sign (
    Str:D $method  where { .uc eq any <POST  GET> },
    Str:D $url-raw where m{^ 'http' s? '://'},
    Str:D $body
) {
    # Using method outlined on
    # https://dev.twitter.com/oauth/overview/creating-signatures

    my URI $url .= new: $url-raw;
    my Str $base-url = [~] $url.scheme, '://', $url.host, $url.path;
    my %params = $url.query-form,
        URI.new("?$body").query-form,
        oauth_version           => '1.0',
        oauth_consumer_key	    => $!consumer-key,
        oauth_nonce	            => $*TEST-TWITTER-OAUTH-NONCE
                                    // (rand ~ $*PID ~ rand),
        oauth_signature_method  => 'HMAC-SHA1',
        oauth_timestamp	        => $*TEST-TWITTER-OAUTH-TIME // time,
        oauth_token	            => $!access-token;
    %params = %params.kv.map: { uri-escape $_ };

    my $signature = join '&',
        $method.uc,
        uri-escape($base-url),
        uri-escape( %params.pairs.sort.map(*.kv.join: '=').join: '&' );

    my $signing-key = join '&',
        uri-escape($!consumer-secret),
        uri-escape($!access-token-secret);

    return encode-base64 hmac($signing-key, $signature, &sha1), :str;
}
