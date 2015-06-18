package TechUtsav::Reports;
use Mojo::Base 'Mojolicious::Controller';

sub index{
    my $self=shift;
    $self->render('reports/index');
}

1;