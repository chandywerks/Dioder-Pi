package DioderPi::Controller::Banks;
use Mojo::Base "Mojolicious::Controller";

sub list {
	my ($c) = @_;

	# Build an array of banks
	my @banks;

	while( my ($name, $bank) = each( %{ $c->bank } ) ) {
		push( @banks, {
			"name" => $name,
			"rgb"  => $bank->rgb
		});
	}

	$c->render( openapi => \@banks );
}

1;
