package TechUtsav::Employee;
use Mojo::Base 'Mojolicious::Controller';

sub index{
    my $self=shift;
    $self->render('employee/index');
}

1;