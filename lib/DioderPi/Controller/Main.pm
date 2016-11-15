package DioderPi::Controller::Main;
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;

sub index {
	my ($self) = @_;
warn "Bank A...";
warn Dumper $self->bank->{a};
	$self->render( text => "Dioder Pi" );
}

1;
