package TechUtsav;
use Mojo::Base 'Mojolicious';
use Tie::IxHash;
use Mojo::Log;
use Schema;
use Switch;

my $message=undef;
my $dsn = undef;
my $user=undef;
my $password=undef;
my $db_types={sqlite=>1,mysql=>2,oracle=>3};

my $database_type=$db_types->{'sqlite'};

switch( $database_type ){
  case 1  {$dsn  ='dbi:SQLite:techutsav.db';}
  case 2  {
            $dsn='dbi:mysql:techutsav';
            $user='test';
            $password='test';
        }
  case 3  {
            $dsn='dbi:oracle:techutsav';
            $user='test';
            $password='test';
        }
};

# Database Setup
has schema => sub{
    return Schema->connect($dsn);
};

# This method will run once at server start
sub startup {
    my $self = shift;
    $self->app->secrets(['mojolicious', 'techutsav']);
    $self->helper(db=>sub{$self->app->schema});
  
  $self->plugin( 'authentication',{
        load_user => sub {
            my ( $self, $employee_id ) = @_;
            my $res= $self->db->resultset('Employee')->search({employee_id=>$employee_id});
            return $res;
        },
        validate_user => sub {
            my ( $self, $username, $password ) = @_;
            my $res = $self->db->resultset('Employee')->search({emp_name => $username });
            #print "\n VALIDATION".Data::Dumper::Dumper($res);
            unless ($res->count()) {
                $message = "User Name Does Exist, Please check...";
                $self->flash( message => $message );
                return;
            };
            #my $salt = substr $password, 0, 2;
            print "\n->emp_passwd".$res->first->emp_password;
    
            #if ( $self->bcrypt_validate( $password, $res->{user_passwd} ) ) {
            if ( $password eq $res->first->emp_password ) {
              print "\n Entry:Password equal: $password ][".$res->first->emp_password;
                $self->session(user => $username);                
                $self->flash(message => 'Thanks for logging in.');
                return $res->first->employee_id;
            }
            else {
                return;
            }
        }
    });
  #my $log=Mojo::Log->new(path=>'D:/learning/perl_practice_scripts/tech_utsav/log/log.log',level=>'debug');
  
  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes; 

  my $auth = $r->under( sub{
      my $self=shift;
      unless($self->is_user_authenticated){
        $self->flash(message=>'Invalid Credentials');
        $self->render('login/login');
        return 0;
      };
      $self->flash(message=>'Successfully LoggedIN');
      return 1;
    }
  );

 # Normal route to controller
  $r->get('/test')->to('example#welcome');  
  $r->any('/')->to('home#index');
  $auth->any('/index')->over(authenticated=>1)->to('home#index');
  
  #$r->any('/login')->to('login#login');
  #$r->any('/logout')->to('login#logout');
  
  #$auth->any('/tac')->to('TACRequest#index');
  $r->any('/tac')->to('TACRequest#index');
  $r->any('/tac/show')->to('TACRequest#show');  
  $r->any('/tac/add')->to('TACRequest#add');
  $r->any('/tac/render')->to('TACRequest#rendertac');
  
  $r->any('/stnry')->to('Stationary#index');
  $r->any('/stnry/show')->to('Stationary#show');
  $r->any('/stnry/add')->to('Stationary#add');
  #$r->any('/stnry/:employeeID')->to('employee#Search');
  
  
  $r->any('/lptp')->to('Laptop#index');
  $r->any('/lptp/show')->to('Laptop#show');
  $r->any('/lptp/checkin')->to('Laptop#checkin');
  $r->any('/lptp/checkout')->to('Laptop#checkout');
  $r->any('/lptp/add')->to('Laptop#add');
  $r->any('/lptp/:employeeID')->to('employee#Search');
  $r->any('/lptp/:employeeID')->to('laptop#details');
  
  $r->get('/vstr')->to('Visitor#show');
  $r->get('/vstr/show')->to('Visitor#show');
  $r->get('/vstr/checkout')->to('Visitor#checkout');
  $r->get('/vstr/checkin')->to('Visitor#checkin');
  $r->get('/vstr/:contacts')->to('Visitor#contatcs');
  
  $r->any('/rprts')->to('reports#index');
  $r->any('/rprts/show')->to('reports#show');
  $r->any('/rprts/tac')->to('reports#tac');
  $r->any('/rprts/lptp')->to('reports#lptp');
  $r->any('/rprts/stnry')->to('reports#stnry');
  $r->any('/rprts/vstr')->to('reports#vstr');
  $r->any('/rprts/courier')->to('reports#courier');
  
  $r->get('/alerts')->to('Alerts#index');
  $r->get('/alerts/tac')->to('Alerts#tac');
  $r->get('/alerts/lptp')->to('Alerts#lptp');
  $r->get('/alerts/stnry')->to('Alerts#stnry');
  $r->get('/alerts/vstr')->to('Alerts#vstr');
  $r->get('/alerts/courier')->to('Alerts#courier');  
}

#http://www.oliverguenther.de/2014/04/applications-with-mojolicious-part-four-database-schemas-with-dbixclass/
#https://github.com/alexanderBendo/Experiments/blob/master/exp0001/mojolicious-auth-session.pl
#https://github.com/alexanderBendo/Experiments/blob/master/exp0001/mojolicious-auth-session.pl

1;

__END__

=head1 NAME

  TechUtsav - Entry point for the client side calls, transaforms the request to the respective modules to perform the required action like TAC Request, Laptop entry,etc.

=head1 SYNOPSIS

=head2 API usage

=head1 DESCRIPTION

=head1 SEE ALSO

=head1 AUTHOR

Satish Malipatil

=head1 CONTRIBUTORS
  
  Vinay G.A
  
=head1 COPYRIGHT
 
Copyright (c) Free L</AUTHOR> and L</CONTRIBUTORS>
 
=head1 LICENSE
 
This library is free software and may be distributed under the same terms
as perl itself