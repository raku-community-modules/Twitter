unit role Twitter::API::DMSent;
# Requires DM permissions for your app
# Returns the 20 most recent direct messages sent by the authenticating user
# https://dev.twitter.com/rest/reference/get/direct_messages/sent

method direct-messages-sent (
    Int     :$since-id,
    Int     :$max-id,
    Int     :$count, #API defaults to 20
    Bool    :$include-entities,
    Int     :$page,

) {
    self!ua.request: 'GET', 'direct_messages/sent', %(
        |(since_id  => $since-id if $since-id),
        |(max_id    => $max-id if $max-id),
        |(count     => $count if $count),
        |(include_entities  => $include-entities if $include-entities),
        |(page       => $page if $page),
    );
}
