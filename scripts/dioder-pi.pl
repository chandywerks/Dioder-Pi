#!/usr/bin/env perl

use warnings;
use strict;

use FindBin;

use lib "$FindBin::Bin/../lib";
use Mojolicious::Commands;

Mojolicious::Commands->start_app('DioderPi');
