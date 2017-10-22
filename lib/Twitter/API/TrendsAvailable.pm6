unit role Twitter::API::TrendsAvailable;
# Returns the locations that Twitter has trending topic information for.
# The response is an array of “locations” that encode the location

method trends-available (

) {
    self!ua.request: 'GET', 'trends/available', %(
        # doesn't accept parameters
    );
}
