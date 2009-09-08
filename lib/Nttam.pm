package Nttam;
use Moose;
our $VERSION = '0.01';
use Nttam::Plackup::Adapter;
use Path::Class;

sub import {
    my $pkg = caller(0);
    my $adapter  = Moose::Meta::Class->create_anon_class(
        superclasses => ['Nttam::Plackup::Adapter'],
        cache => 1,
    );
    do {
        # hack.
        my $p = $adapter->name;
        $p =~ s!::!/!g;
        $INC{"${p}.pm"} = 1;
    };
    $adapter->make_immutable;
    Moose->import({into_level => 1});
    $pkg->meta->add_method('plack_adapter' => sub { '+'.$adapter->name });
    $pkg->meta->make_immutable;

    Class::MOP::load_class("${pkg}::$_") for qw/Dispatcher/;
}

1;
__END__

=head1 NAME

Nttam -

=head1 SYNOPSIS

  use Nttam;

=head1 DESCRIPTION

Nttam is

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom  slkjfd gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
