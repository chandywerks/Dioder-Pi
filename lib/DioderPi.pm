package DioderPi;

use Mojo::Base 'Mojolicious';

sub startup {
	my ($self) = @_;

	# Init the RGB light strip banks
	$self->plugin('DioderPi::Plugin::Banks');

	# Build API routes from swagger spec
	$self->plugin( "OpenAPI" => {
		url => $self->home->rel_file("etc/api.json")
	});

	my $r = $self->routes;

	$r->route('/')->to('main#index');
}

1;
