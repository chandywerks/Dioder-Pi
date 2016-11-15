package DioderPi::Plugin::Banks;

use Moo;
use Mojo::Base -strict;
use namespace::clean;

extends 'Mojolicious::Plugin';
with 'DioderPi::Role::Config';

use WiringPi::API;

use DioderPi::Model::Bank;

sub register {
	my ($self, $app) = @_;

	# Init WiringPi
	my $wpi = WiringPi::API->new();
	$wpi->setup;

	# Hash of RGB light bank modules
	$app->helper( bank => sub { state $bank = {} } );

	# Init each RGB bank
	my $banks = $self->getConfig("banks");
	while( my ($bank, $pins) = each( %{ $banks } ) ) {
		$app->bank->{ $bank } = DioderPi::Model::Bank->new({
			wpi  => $wpi,
			pins => $pins
		});
	}
}
1;
