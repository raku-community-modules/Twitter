unit role Twitter::API::FavoritesList;
# Returns array of the 20 most recent Tweets favorited by the authenticating
# or specified user.
# https://dev.twitter.com/rest/reference/get/favorites/list

method favorites-list (
    Int     :$user-id, #API defaults to user's app
    Str     :$screen-name, #API defaults to user
    Int     :$count, # API default is 20
    Int     :$since-id,
    Int     :$max-id,
    Bool    :$include-entities,
) {
    self!ua.request: 'GET', 'favorites/list', %(
        |(user_id     => $user-id if $user-id),
        |(screen_name => $screen-name if $screen-name),
        |(count       => $count if $count),
        |(since_id    => $since-id if $since-id),
        |(max_id      => $max-id if $max-id),
        |(include_entities  => $include-entities if $include-entities),
    );
}
