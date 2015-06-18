package TechUtsav::Home;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  my $self=shift;
  #$self->session('name')=undef;
  $self->render('home/index');  
}

1;

=pod
if ( $self->session('user') ){
    print "TEst". $self->session('user') ;#if defined $self->session('name');
    $self->render('home/index');
  }
  else {
    $self->render('login/login');
  }
