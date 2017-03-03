unit role Twitter::API::DirectMessages;

method direct-message (Str:D $text, Str:D :$name = '', Str:D(Cool) :$id = '') {
    fail 'Must provide either :$id (user_id) or :$name (screen_name)'
        unless $name or $id;

    self!ua.request: 'POST', 'direct_messages/new',
        %(:$text, |(:screen_name($name) if $name), |(:user_id($id) if $id) );
}
