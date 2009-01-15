use Test::More tests => 6;

BEGIN { use_ok WWW::Shorten::Qwer };

my $url = 'http://search.cpan.org/dist/WWW-Shorten';
my $code = 'wwwshorten';
my $prefix = 'http://qwer.org/';
is ( makeashorterlink($url, $code), $prefix.$code, 'make it shorter');
is ( makealongerlink($prefix.$code), $url, 'make it longer');
is ( makealongerlink($code), $url, 'make it longer by Id',);

eval { &makeashorterlink() };
ok($@);
eval { &makealongerlink() };
ok($@);
