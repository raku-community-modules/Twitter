[![Build Status](https://travis-ci.org/zoffixznet/perl6-Twitter.svg)](https://travis-ci.org/zoffixznet/perl6-Twitter)

# NAME

Twitter - use Twitter via Perl 6

# SYNOPSIS

```perl6
use Twitter;
my Twitter $t .= new:
    consumer-key        => 'drH7437T55HSV266UJ77TxhoT',
    consumer-secret     => 'zwilaza95yh2Gvowoadddp8dXWCJvvv68cbevxxx1eEar8Doht',
	access-token        => '7171fff60942444633-Aiv9Tczx4tXrrfcKCvvvUqORQbax35R',
	access-token-secret => 'uSFfXcvfdeghbfdhNsU9x16Ujwf0waIx1P0aHL59342Av';

$t.tweet: 'My first ever Perl6 Tweet!';
```

# DESCRIPTION

This module lets you use Twitter from Perl 6 as well as implements
Twitter's REST API for those who want to use API methods directly.

# EARLY ACCESS RELEASE

This release aims to both give those who want little something to use as well
as avoid potential wheel reinvention, since this module already takes care of
the OAuth roadblock.

The plan for the interface is pretty straightforward as well. The `Twitter`
module will provide means to use Twitter from Perl 6 with some convenient
methods. The `Twitter::API` role is composed into `Twitter` to allow a more
refined control; its methods will follow Twitter's API naming, with
slashes in REST API methods changed to hyphens.

Error checking will be done by this distribution with `fail` on errors, and
returning decoded JSON response as is on success.

# METHODS

## `new`

```perl6
my Twitter $t .= new:
    consumer-key        => 'drH7437T55HSV266UJ77TxhoT',
    consumer-secret     => 'zwilaza95yh2Gvowoadddp8dXWCJvvv68cbevxxx1eEar8Doht',
    access-token        => '7171fff60942444633-Aiv9Tczx4tXrrfcKCvvvUqORQbax35R',
    access-token-secret => 'uSFfXcvfdeghbfdhNsU9x16Ujwf0waIx1P0aHL59342Av';
```

Constructs and returns a new `Twitter` object. Takes four **mandatory**
arguments: `consumer-key`, `consumer-secret`, `access-token`, and
`access-token-secret`. To obtain those four keys, you need to log in to
Twitter and visit [https://apps.twitter.com/](https://apps.twitter.com/).
Then, click the `Create New App` button and follow instructions. Once
your app is set up, click on its `Keys and Access Tokens` tabs. The consumer
key and consumer secret will be available, but you'll have
to click the button at the bottom of the page to generate access keys. Use
the values provided on that page for the arguments.

## `tweet`

```perl6
    $t.tweet: 'Hello, world!';
```

Takes one mandatory positional argument: the string to tweet. At the moment,
no length checking is done. `fail`s on failure. On success, returns decoded
JSON returned by Twitter.

## `direct-message`

```perl6
    $t.direct-message: 'I ♥ You!', :name<Zoffix>;
    $t.direct-message: 'I ♥ You!', :id<123684986>;
```

Takes a positional argument with the text of the direct message and sends it
to the user identified by the `:$name` argument (user's screen name) or the
`:$id` argument (user's ID).

## `search`

```perl6
    my @tweets = $t.search: q{"Perl 6" :)};
```

Performs a search for tweets and returns an array of hashes that represent
results. Supports all of features listed in [Query Operators section of the API](https://dev.twitter.com/rest/public/search).

Will return at most 100 results. If you need more refined control, see
`.search-tweets` method in `Twitter::API`
(docs are included in the module file).

Sample return data:

```perl6
[
  {
    created_at => "Wed Apr 13 23:00:02 +0000 2016".Str,
    text       => "\@eerie_descent Perl 6 is trying… at least. :-)".Str,
    url        => "https://twitter.com/statuses/720386089161244672".Str,
    user       => "\@furt1v3ly".Str,
  },
  ...
]
```

----

# REPOSITORY

Fork this module on GitHub:
https://github.com/zoffixznet/perl6-Twitter

# BUGS

To report bugs or request features, please use
https://github.com/zoffixznet/perl6-Twitter/issues

# AUTHOR

Zoffix Znet (http://zoffix.com/)

# LICENSE

You can use and distribute this module under the terms of the
The Artistic License 2.0. See the `LICENSE` file included in this
distribution for complete details.
