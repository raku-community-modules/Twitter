
my %h = ^20;
say %h.pairs;

=finish

use URI::Escape;
my %h = 'me??o' => 'ga&v', 'fo10%' => 'bla%hff';
%h = %h.kv.map: { uri-escape $_ };
say %h.sort;
# %h = %h.kv.map({ uri-escape $_ }).pairs;
# say %h;
