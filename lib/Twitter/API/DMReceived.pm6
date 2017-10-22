unit role Twitter::API::DMReceived;
# Requires DM permissions for your app
# Will return direct messages that the user has received
# https://dev.twitter.com/rest/reference/get/direct_messages

method direct-messages-received (
    Int     :$since-id,
    Int     :$max-id,
    Int     :$count, #API defaults to 20
    Bool    :$include-entities,
    Bool    :$skip-status,

) {
    self!ua.request: 'GET', 'direct_messages', %(
        |(since_id  => $since-id if $since-id),
        |(max_id    => $max-id if $max-id),
        |(count     => $count if $count),
        |(include_entities  => $include-entities if $include-entities),
        |(skip_status       => $skip-status if $skip-status),
    );
}
