unit role Twitter::API::Search;
use Subset::Helper;

my subset TwitterSearchString of Str where subset-is *.chars <= 500,
    'Maximum search query length is 500 characters';

my subset TwitterGeoCode of Str where subset-is {
        m/^
            <[-+]>? \d+ [\. \d+]? ','             # latitude
            <[-+]>? \d+ [\. \d+]? ','             # longitude
                    \d+ [\. \d+]? [ 'mi' | 'km' ] # radius
        $/
    },
    'Geocode must be in format "latitude,longitude,radius", where radius must'
    ~ ' have either "mi" or "km" units, e.g. "37.781157,-122.398720,1mi"';

my subset TwitterResultType of Str
    where subset-is * ∈ set(<mixed recent popular>),
    'Must be one of <mixed, recent, popular>';

my subset TwitterCount of Int where subset-is 1 <= * <= 100,
    'Must be between 1 and 100, inclusive';

my subset TwitterDate of Int where subset-is
    { m/^ \d\d\d\d '-' \d\d '-' \d\d $/ },
    q{Must be in format YYYY-MM-DD. Won't return any tweets if date}
    ~ q{ older than 7 days from today};

my subset UNSUPPORTED of Cool where subset-is { 0 == 1 },
    'This parameter is not supported.';

method search-tweets (
    TwitterSearchString:D $q,
    TwitterGeoCode        :$geocode,
    Str                   :$lang,
    Str                   :$locale,
    TwitterResultType     :$result-type, # API defaults this to 'mixed'
    TwitterCount          :$count, # API defaults this to 15
    TwitterDate           :$until,
    Int                   :$since-id,
    Int                   :$max-id,
    Bool                  :$include-entities, # API defaults this to False
    UNSUPPORTED           :$callback,
) {
    self!ua.request: 'GET', 'search/tweets', %(
        :$q,
        |(:$geocode if $geocode),
        |(:$lang    if $lang   ),
        |(:$locale  if $locale ),
        |(:$count   if $count  ),
        |(:$until   if $until  ),
        |(result_type      => $result-type      if $result-type     ),
        |(since_id         => $since-id         if $since-id        ),
        |(max_id           => $max-id           if $max-id          ),
        |(include_entities => $include-entities if $include-entities),
    );
}

=finish
