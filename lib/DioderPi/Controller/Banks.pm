package DioderPi::Controller::Banks;
use Mojo::Base "Mojolicious::Controller";

sub list {
	my ($c) = @_;

	my @banks = values %{ $c->banks };
	$c->render( openapi => \@banks );
}

sub get_bank {
	my ($c) = @_;

	$c->openapi->valid_input or return;

	if( my $bank = $c->_bank ) {
		$c->render( openapi => $bank );
	} else {
		$c->render( $c->_bank_not_found );
	}
}

sub update_bank {
	my ($c) = @_;

	$c->openapi->valid_input or return;

	if( my $bank = $c->_bank ) {
		$bank->rgb( $c->req->json );
		$c->render( openapi => $bank );
	} else {
		$c->render( $c->_bank_not_found );
	}
}

sub _bank {
	my ($c) = @_;

	return $c->banks->{ $c->param('name') };
}
sub _bank_not_found {
	my ($c) = @_;

	return (
		status  => 404,
		openapi => {
			errors => [
				{
					status => "404",
					title  => "Invalid Bank",
					detail => "Bank '" . $c->param("name") . "' is not defined."
				}
			]
		}
	);
}

1;
