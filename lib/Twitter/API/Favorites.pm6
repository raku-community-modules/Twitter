unit role Twitter::API::Favorites;
# Returns array of the 20 most recent Tweets favorited by the authenticating
# or specified user.
# https://dev.twitter.com/rest/reference/get/favorites/list

method favorites-destroy (
    Str     :$screen-name!, #API defaults to user
    Int     :$id!,
    Bool    :$include-entities,
) {
    self!ua.request: 'POST', 'favorites/destroy', %(
        |(:screen_name($screen-name) if $screen-name),
        |(:$id if $id),
        |(:$include-entities if $include-entities),
    );
}
