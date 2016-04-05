use Twitter::UA;
use Twitter::API::Statuses;

unit role Twitter::API
    does Twitter::API::Statuses;

has Str:D $.consumer-key        is required;
has Str:D $.consumer-secret     is required;
has Str:D $.access-token        is required;
has Str:D $.access-token-secret is required;

has $!ua = Twitter::UA.new: :$!consumer-key, :$!consumer-secret,
                            :$!access-token, :$!access-token-secret;
