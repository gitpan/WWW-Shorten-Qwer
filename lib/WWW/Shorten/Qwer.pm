# $Id$

=head1 NAME

WWW::Shorten::Qwer - Perl interface to qwer.org

=head1 SYNOPSIS

  use WWW::Shorten::Qwer;
  use WWW::Shorten 'Qwer';

  $short_url = makeashorterlink($long_url, $short_code);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web site qwer.org.  Qwer simply maintains
a database of long URLs, each of which has a unique identifier.

=cut

package WWW::Shorten::Qwer;

use 5.006;
use strict;
use warnings;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw( makeashorterlink makealongerlink );
our $VERSION = '1.00';

use Carp;

=head1 Functions

=head2 makeashorterlink

The function C<makeashorterlink> will call the Qwer web site passing
it your long URL and a mandatory short code. It will return the shorter
Qwer version of the URL.

=cut

sub makeashorterlink ($$)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $code = shift or croak 'No short code passed to makeashorterlink';

    my $ua = __PACKAGE__->ua();
    my $qwer = 'http://qwer.org/submit';
    my $resp = $ua->post($qwer, [
	name => $code,
	data => $url,
	]);
    return unless $resp->is_redirect;
    my $content = $resp->content;

    if (my $redir = $resp->header('Location')) {
        return $redir;
    }

    return;
}

=head2 makealongerlink

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full Qwer URL or just the
Qwer identifier.

If anything goes wrong, then either function will return C<undef>.

=cut

sub makealongerlink ($)
{
    my $qwer_url = shift 
	or croak 'No Qwer key / URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();

    $qwer_url = "http://qwer.org/$qwer_url"
        unless $qwer_url =~ m!^http://!i;

    my $resp = $ua->get($qwer_url);

    return unless $resp->is_success;
    my $content = $resp->content;
    my ($url) = $content =~ m|^(\w+://.*)</td|m;

    return $url;
}

1;

__END__

=head2 EXPORT

makeashorterlink, makealongerlink

=head1 SUPPORT, LICENCE, THANKS and SUCH

See the main L<WWW::Shorten> docs.

=head1 AUTHOR

Dave Cross <dave@mag-sol.com>

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://qwer.org/>

=cut
