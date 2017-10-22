unit role Twitter::API::AccountCredentials;

method account-verify_credentials (
    Bool                :$include-entities,
    Bool                :$skip-status,
    Bool                :$include-email,
) {
    self!ua.request: 'GET', 'account/verify_credentials', %(
         |(skip_status => $skip-status if $skip-status),
         |(include_entities      => $include-entities if $include-entities),
         |(include_email         => $include-email if $include-email),
    );
}
