package DioderPi::Role::Config;

use Moo::Role;

use Mojo::Asset::File;
use Mojo::JSON qw( decode_json );

sub getConfig {
	my ($self, $name) = @_;

	my $file = Mojo::Asset::File->new( path => "etc/$name.json" );

	return $file->size ? decode_json( $file->slurp ) : undef;
}
1;
