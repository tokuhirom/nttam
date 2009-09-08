package Nttam::Plackup::Adapter;
use Moose;
use Plack::Request;
use Path::Class;

has app => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has base_dir => (
    is => 'ro',
    isa => 'Path::Class::Dir',
    default => sub {
        dir('.')
#       my $self = shift;
#       my $p = $self->app() . ".pm";
#       $p =~ s!::!/!g;
#       my $path = $INC{$p};
#       $path =~ s!lib/$p$!!;
#       dir($path);
    }
);

sub BUILDARGS {
    my ($class, $app) = @_;
    return +{ app => $app };
}

sub handler {
    my $self = shift;
    return sub {
        my $req = Plack::Request->new(shift);
        local *Nttam::c     = sub { $self };
        my $app = $self->app;
        my $rule = "${app}::Dispatcher"->match($req);
        my $controller = $app . '::Controller::' . $rule->{controller};
        Class::MOP::load_class($controller);
        my $action = $rule->{action};
        my $code = $controller->can($action) or die "unknown action: $action";
        return $code->($req);
    };
}

1;
