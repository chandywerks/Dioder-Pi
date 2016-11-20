package DioderPi::Model::Bank;

use Moo;
use namespace::clean;

use constant {
	PWM_OUTPUT => 2,	# PWM OUTPUT MODE
	PWM_MAX  => 128		# 12.8 ms period or 78.125 Hz
};

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
		$self->wpi->pin_mode( $pin, PWM_OUTPUT );

		# Init soft PWM thread
		$self->wpi->soft_pwm_create( $pin, 0, PWM_MAX );
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

	$self->wpi->soft_pwm_write( $self->pins->{red}, $self->_scale( $red ) );
	$self->wpi->soft_pwm_write( $self->pins->{green}, $self->_scale( $green ) );
	$self->wpi->soft_pwm_write( $self->pins->{blue}, $self->_scale( $blue ) );
}

# Scale the color value to the PWM range
sub _scale {
	my ($self, $color_value) = @_;
	return int( PWM_MAX / 255 * $color_value );
}

1;
