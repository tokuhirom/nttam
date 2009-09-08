package Nttam::Controller;
use strict;
use File::Spec;
use Text::MicroTemplate::File;

sub import {
    strict->import;
    warnings->import;

    no strict 'refs'; ## no critic.
    my $pkg = caller(0);
    *{"${pkg}::render"} = sub {
        my ($tmpl, @args) = @_;
        my $mt = Text::MicroTemplate::File->new(
            include_path => [
                Nttam::c()->base_dir->subdir('tmpl'),
                Nttam::c()->base_dir->subdir('tmpl', 'include'),
            ],
            use_cache    => 1,
        );
        return [
            200,
            ['Content-Type' => 'text/html'],
            [$mt->render_file("$tmpl", @args)]
        ];
    };
    *{"${pkg}::redirect"} = sub {
        my ($location) = @_;
        return [
            302,
            ['Location' => $location],
            []
        ];
    };
}

1;
