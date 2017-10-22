unit role Twitter::API::TrendsPlace;
# Returns an array of the top 50 trending topics for a specific WOEID, if
# trending information is available for it.

method trends-place (
    Int:D       $id = 1,
    Str         :$exclude
) {
    self!ua.request: 'GET', 'trends/place', %(
        |(id        => $id if $id),
        |(exclude   => $exclude if $exclude), #excludes hashtag if set as that
    );
}
