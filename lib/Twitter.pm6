use Twitter::API;
unit class Twitter:ver<0.002001> does Twitter::API;

method tweet  ($what) { self.statuses-update: $what;       }
method search ($q) {
    my $res = self.search-tweets: $q;

    my @tweets;
    for |$res<statuses> -> $raw {
        my %tweet =
            url  => "https://twitter.com/statuses/$raw<id_str>",
            user => '@' ~ $raw<user><screen_name>,
            text => $raw<text>,
            created_at => $raw<created_at>;
        @tweets.push: %tweet;
    }

    return @tweets;
}
