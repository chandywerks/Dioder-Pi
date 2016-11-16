package DioderPi::Controller::Main;
use Mojo::Base 'Mojolicious::Controller';

sub index {
	my ($c) = @_;

	$c->render( text => "Dioder-Pi" );
}

1;
