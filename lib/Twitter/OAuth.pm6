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

method !sign (
    Str:D $method  where { .uc eq any <POST  GET> },
    Str:D $url-raw where m{^ 'http' s? '://'},
    Str:D $body # %query
) {
    # Using method outlined on
    # https://dev.twitter.com/oauth/overview/creating-signatures

    my URI $url .= new: $url-raw;
    my Str $base-url = [~] $url.scheme, '://', $url.host, $url.path;

    my $timestamp = $*TEST-TWITTER-OAUTH-TIME  // time;
    my $nonce     = $*TEST-TWITTER-OAUTH-NONCE // (rand ~ $*PID ~ rand);

    my %params =
        URI.new("?$body").query-form,
        oauth_version           => '1.0',
        oauth_consumer_key	    => $!consumer-key,
        oauth_nonce	            => $nonce,
        oauth_signature_method  => 'HMAC-SHA1',
        oauth_timestamp	        => $timestamp,
        oauth_token	            => $!access-token;
    %params = %params.kv.map: { uri-escape $_ };

    my $base = join '&',
        $method.uc,
        uri-escape($base-url),
        uri-escape( %params.pairs.sort.map(*.kv.join: '=').join: '&' );

    my $signing-key = join '&',
        uri-escape($!consumer-secret),
        uri-escape($!access-token-secret);

    my $signature = encode-base64 hmac($signing-key, $base, &sha1), :str;

    return |($signature, $nonce, $timestamp).map: { uri-escape $_ };
}
