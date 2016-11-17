package DioderPi::Model::Bank;

use Moo;
use namespace::clean;

has 'wpi' => (
	is  => 'ro',
	required => 1
);

has 'name' => (
	is => 'ro',
	required => 1
);

has 'pins' => (
	is => 'ro',
	required => 1
);

has 'rgb' => (
	is   => 'rw',
	trigger => \&_rgb_set,
	default => sub { [ 0, 0, 0 ] }
);

sub BUILD {
	my ($self) = @_;

	while( my ($color, $pin) = each( %{ $self->pins } ) ) {
		# Set pin to PWM_OUTPUT
		$self->wpi->pin_mode( $pin, 2 );

		# Init soft PWM thread
		$self->wpi->soft_pwm_create( $pin, 0, 255 );
	}

	# Set init flag
	$self->{init} = 1;

	# Set the starting color
	$self->rgb( $self->rgb );
}

sub TO_JSON {
	my ($self) = @_;

	return {
		"name" => $self->name,
		"rgb"  => $self->rgb
	};
}

sub _rgb_set {
	my ($self, $color) = @_;

	# Bail if constructor value passed b/c pins haven't been initialzed yet
	return unless $self->{init};

	# Change the duty cycle of each color channel
	my ($red, $green, $blue) = @{ $color };

	$self->wpi->soft_pwm_write( $self->pins->{red}, $red );
	$self->wpi->soft_pwm_write( $self->pins->{green}, $green );
	$self->wpi->soft_pwm_write( $self->pins->{blue}, $blue );
}

1;
