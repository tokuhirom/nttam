package MyApp::Controller::Root;
use Nttam::Controller;

sub root {
    my $req = shift;
    render('index.html');
}

sub greetings {
    my $req = shift;
    render('greetings.html', $req->param('name'));
}

1;
