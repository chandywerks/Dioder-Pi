package DioderPi::Controller::Banks;
use Mojo::Base "Mojolicious::Controller";

sub list {
	my ($c) = @_;

	my @banks = values %{ $c->banks };
	$c->render( openapi => \@banks );
}

1;
