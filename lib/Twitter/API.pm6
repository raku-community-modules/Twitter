use Twitter::UA;
use Twitter::API::Statuses;
use Twitter::API::Search;

unit role Twitter::API
    does Twitter::API::Statuses
    does Twitter::API::Search;

has Str:D $.consumer-key        is required;
has Str:D $.consumer-secret     is required;
has Str:D $.access-token        is required;
has Str:D $.access-token-secret is required;

has $!ua = Twitter::UA.new: :$!consumer-key, :$!consumer-secret,
                            :$!access-token, :$!access-token-secret;

method !ua { $!ua } # let roles use this

=finish

# NAME

Twitter::API - implementation of Twitter's API

# SYNOPSIS

```perl6
use Twitter::API;
my Twitter::API $t .= new:
    consumer-key        => 'drH7437T55HSV266UJ77TxhoT',
    consumer-secret     => 'zwilaza95yh2Gvowoadddp8dXWCJvvv68cbevxxx1eEar8Doht',
	access-token        => '7171fff60942444633-Aiv9Tczx4tXrrfcKCvvvUqORQbax35R',
	access-token-secret => 'uSFfXcvfdeghbfdhNsU9x16Ujwf0waIx1P0aHL59342Av';

$t.search-tweets: 'Perl 6';
```

# DESCRIPTION

This module is an implementation of REST API provided by Twitter.com. For more
user-oriented interface, see Twitter.pm6 included in this distribution.

# CONVENTIONS

The naming of methods mirrors Twitter's API, with the slash (`/`) replaced
by a hyphen (`-`). The methods take the same parameters as API calls, with
underscores in the names (`_`) replaced by hyphens (`-`).

In shown signatures, `Twitter*` types are subsets, restricting values
to those accepted by the API, the type in the parenthesis is the parent of
the subtype. For example, `TwitterCount(Int) :$count` in the signature means
`$count` named parameter takes an `Int` that is within API's allowed values.

Special subset `UNSUPPORTED` is used for arguments this implementation of the
API does not support.

# METHODS

## `search-tweets`

```perl6
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
    )
```

Searches tweets. Takes same values as
[described in the API](https://dev.twitter.com/rest/reference/get/search/tweets). Returns decoded
response, which looks like this:

```perl6
{
  search_metadata => {
    completed_in => 0.046.Rat,
    count        => 1.Int,
    max_id       => 722785042171301888.Int,
    max_id_str   => "722785042171301888".Str,
    next_results => "?max_id=722785042171301887\&q=Perl\%206\&count=1\&include_entities=1".Str,
    query        => "Perl+6".Str,
    refresh_url  => "?since_id=722785042171301888\&q=Perl\%206\&include_entities=1".Str,
    since_id     => 0.Int,
    since_id_str => "0".Str,
  },
  statuses        => [
    {
      contributors              => (Any),
      coordinates               => (Any),
      created_at                => "Wed Apr 20 13:52:37 +0000 2016".Str,
      entities                  => {
        hashtags      => [ ],
        symbols       => [ ],
        urls          => [
          {
            display_url  => "ift.tt/1rjORMX".Str,
            expanded_url => "http://ift.tt/1rjORMX".Str,
            indices      => [
              48.Int,
              71.Int,
            ],
            url          => "https://t.co/rGPqqGbLf0".Str,
          },
        ],
        user_mentions => [ ],
      },
      favorite_count            => 0.Int,
      favorited                 => Bool::False.Bool,
      geo                       => (Any),
      id                        => 722785042171301888.Int,
      id_str                    => "722785042171301888".Str,
      in_reply_to_screen_name   => (Any),
      in_reply_to_status_id     => (Any),
      in_reply_to_status_id_str => (Any),
      in_reply_to_user_id       => (Any),
      in_reply_to_user_id_str   => (Any),
      is_quote_status           => Bool::False.Bool,
      lang                      => "da".Str,
      metadata                  => {
        iso_language_code => "da".Str,
        result_type       => "recent".Str,
      },
      place                     => (Any),
      possibly_sensitive        => Bool::False.Bool,
      retweet_count             => 0.Int,
      retweeted                 => Bool::False.Bool,
      source                    => "<a href=\"http://ifttt.com\" rel=\"nofollow\">IFTTT</a>".Str,
      text                      => "Spændende vikingeuger i sommerferien (for alle) https://t.co/rGPqqGbLf0 Historisk: 27/6-21/8. Museumsøen. I sommerferien har hver uge sit …".Str,
      truncated                 => Bool::False.Bool,
      user                      => {
        contributors_enabled               => Bool::False.Bool,
        created_at                         => "Sun Jul 27 20:21:30 +0000 2014".Str,
        default_profile                    => Bool::True.Bool,
        default_profile_image              => Bool::False.Bool,
        description                        => "Nyheder fra Roskilde.".Str,
        entities                           => {
          description => {
            urls => [ ],
          },
          url         => {
            urls => [
              {
                display_url  => "roskildeportal.dk".Str,
                expanded_url => "http://roskildeportal.dk".Str,
                indices      => [
                  0.Int,
                  22.Int,
                ],
                url          => "http://t.co/qFR9Ja5TwN".Str,
              },
            ],
          },
        },
        favourites_count                   => 6.Int,
        follow_request_sent                => Bool::False.Bool,
        followers_count                    => 111.Int,
        following                          => Bool::False.Bool,
        friends_count                      => 107.Int,
        geo_enabled                        => Bool::False.Bool,
        has_extended_profile               => Bool::False.Bool,
        id                                 => 2685903733.Int,
        id_str                             => "2685903733".Str,
        is_translation_enabled             => Bool::False.Bool,
        is_translator                      => Bool::False.Bool,
        lang                               => "da".Str,
        listed_count                       => 2.Int,
        location                           => "Roskilde".Str,
        name                               => "RoskildePortal".Str,
        notifications                      => Bool::False.Bool,
        profile_background_color           => "C0DEED".Str,
        profile_background_image_url       => "http://abs.twimg.com/images/themes/theme1/bg.png".Str,
        profile_background_image_url_https => "https://abs.twimg.com/images/themes/theme1/bg.png".Str,
        profile_background_tile            => Bool::False.Bool,
        profile_banner_url                 => "https://pbs.twimg.com/profile_banners/2685903733/1406492946".Str,
        profile_image_url                  => "http://pbs.twimg.com/profile_images/493493398028824577/Kri-YXWb_normal.png".Str,
        profile_image_url_https            => "https://pbs.twimg.com/profile_images/493493398028824577/Kri-YXWb_normal.png".Str,
        profile_link_color                 => "0084B4".Str,
        profile_sidebar_border_color       => "C0DEED".Str,
        profile_sidebar_fill_color         => "DDEEF6".Str,
        profile_text_color                 => "333333".Str,
        profile_use_background_image       => Bool::True.Bool,
        protected                          => Bool::False.Bool,
        screen_name                        => "RoskildePortal".Str,
        statuses_count                     => 1064.Int,
        time_zone                          => (Any),
        url                                => "http://t.co/qFR9Ja5TwN".Str,
        utc_offset                         => (Any),
        verified                           => Bool::False.Bool,
      },
    },
  ],
}
```
