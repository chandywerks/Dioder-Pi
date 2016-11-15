package DioderPi::Controller::Main;
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;

sub index {
	my ($self) = @_;

	$self->render( text => "Dioder-Pi" );
}

1;
