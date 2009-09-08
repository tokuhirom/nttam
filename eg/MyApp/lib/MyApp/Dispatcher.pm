package MyApp::Dispatcher;
use HTTPx::Dispatcher;

connect '' => {controller => 'Root', action => 'root'};
connect 'greetings' => {controller => 'Root', action => 'greetings'};

1;
