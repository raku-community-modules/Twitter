unit role Twitter::API::Statuses;

method statuses-update (Str:D $tweet-text) {
    self!ua.request: 'POST', 'statuses/update', %(status => $tweet-text);
}
