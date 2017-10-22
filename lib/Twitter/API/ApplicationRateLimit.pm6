unit role Twitter::API::ApplicationRateLimit;
use Subset::Helper;
# Returns the current rate limits for methods belonging to
# the specified resource families.



method application-rate-limit (
    Str     :$resources, #must be comma separated list ex: friends,statuses
) {
    self!ua.request: 'GET', 'application/rate_limit_status', %(
        |(resources => $resources if $resources)
    );
}
