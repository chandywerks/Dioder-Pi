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
	$app->helper( banks => sub { state $banks = {} } );

	# Init each RGB bank
	foreach my $bank ( @{ $self->getConfig("banks") } ) {
		# Add WiringPi interface to bank args
		$bank->{wpi} = $wpi;

		# Init and register bank
		$app->banks->{ $bank->{name} } = DioderPi::Model::Bank->new( $bank );
	}
}
1;
