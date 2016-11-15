package DioderPi;

use Mojo::Base 'Mojolicious';

sub startup {
	my ($self) = @_;

	# Init the RGB light strip banks
	$self->plugin('DioderPi::Plugin::Banks');

	my $r = $self->routes;

	$r->route('/')->to('main#index');
}

1;
