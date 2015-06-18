package TechUtsav::Login;

use Mojo::Base 'Mojolicious::Controller';
#use Mojo::Base 'Mojolicious::Plugin';
use Mojolicious::Plugin::Authentication;
use Mojolicious::Plugin::Bcrypt;
#plugin 'Mojolicious::Plugin::Authentication';
#plugin 'Mojolicious::Plugin::Bcrypt';
#use Mojolicious::Plugin::Database;
#use DBI;

#
# The auth database contains the user accounts
# The user_passwd fields contains a bcrypt hash
#dsn      => 'dbi:SQLite:dbname=techutsav.db',

#plugin 'bcrypt';
#plugin bcrypt => { cost => 6 };

#
# Database-based authentication example
#
sub paramauth{
    my $self=shift;
    $self->plugin( 'authentication',{
        load_user => sub {
            my ( $self, $employee_id ) = @_;
            my $res= $self->db->search({employee_id=>$employee_id});
            return $res;
        },
        validate_user => sub {
            my ( $self, $username, $password ) = @_;
            my $res = $self->db->search({emp_name => $username });        
            return unless $res;
            #my $salt = substr $password, 0, 2;
            print "->emp_passwd".$res->emp_passwd;
    
            #if ( $self->bcrypt_validate( $password, $res->{user_passwd} ) ) {
            if ( $password eq $res->emp_passwd ) {
                $self->session(user => $username);                
                $self->flash(message => 'Thanks for logging in.');
                return $res->employee_id;
            }
            else {
                return;
            }
        }
    });
};

#
# This page is visible only to authenticated users
#

sub welcome {
    my $self = shift;
    if ( not $self->user_exists ) {
        $self->flash( message => 'You must log in to view this page' );
        $self->redirect_to('/');
        return;
    }
    else {
        $self->render( template => 'welcome' );
    }
}

#
# Try to log in the user
#

sub login {
    my $self = shift;
    print "Entry :login $0:";
    my $user = $self->param('user') ;
    my $pass = $self->param('pass');
    print "\nuser: $user;password:$pass;";
    if ( $self->authenticate( $user, $pass ) ) {
        $self->app->log->debug("\nAuthenticated:" .$self->is_user_authenticated);
        $self->app->log->debug("SESSION USER".$self->session('user'));
        
        $self->flash( message => "User ". uc($user). ' has Logged In Successfully!' );
        
        $self->redirect_to('/index');
    }
    else {
        $self->flash( message => 'Invalid credentials!' );
        $self->redirect_to('/');
    }
}

#
# Close the session
#

sub logout {
    my $self = shift;
    print $self->session('name');
    $self->session( expires => 1 );
    $self->flash( message => 'Loggedout Successfully!' );
    $self->redirect_to('/');
}

1;
=pod
Can't load 'C:/Dwimperl/perl/site/bin/../lib/auto/Crypt/Eksblowfish/Eksblowfish.dll' for module Crypt::Eksblowfish: load_file:%1 is not a valid Win32 application at C:/Perl64/lib/DynaLoader.pm line 191.
=cut