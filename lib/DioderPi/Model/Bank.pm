package DioderPi::Model::Bank;

use Moo;
use namespace::clean;

has 'wpi' => (
	is  => 'ro',
	required => 1
);

has 'pins' => (
	is => 'ro',
	required => 1
);

sub BUILD {
	my ($self) = @_;

	while( my ($color, $pin) = each( %{ $self->pins } ) ) {
		warn "Init pin $pin...";
		# Set pin to PWM_OUTPUT
		$self->wpi->pin_mode( $pin, 2 );

		# Init soft PWM thread
		$self->wpi->soft_pwm_create( $pin, 0, 255 );
	}

	# Set default color to blue
	$self->set_rgb( 0, 0, 255 );
}

sub set_rgb {
	my ($self, $red, $green, $blue ) = @_;

	$self->wpi->soft_pwm_write( $self->pins->{red}, $red );
	$self->wpi->soft_pwm_write( $self->pins->{green}, $green );
	$self->wpi->soft_pwm_write( $self->pins->{blue}, $blue );
}

1;
