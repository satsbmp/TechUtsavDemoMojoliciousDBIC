package TechUtsav::Results;
use Mojo::Base 'Mojolicious::Controller';

use Schema;
  
sub _dumper_hook {
  $_[0] = bless {
    %{ $_[0] },
    result_source => undef,
  }, ref($_[0]);
}
use Data::Dumper;
 
local $Data::Dumper::Freezer = '_dumper_hook';

sub index {
  my $self=shift;
  $self->render('results/index');
}
#Result Details
#empID TACcount
#5743 3
my %tacresults=(5743=>2, 1234=>4,3456=>3);
my %lptpresults=(5743=>2, 1234=>4,3456=>3);
my %stnryresults=(5743=>2, 1234=>4,3456=>3);
my %vstrresults=(5743=>2, 1234=>4,3456=>3);
my %courierresults=(5743=>2, 1234=>4,3456=>3);
my %rqesults=(5743=>2, 1234=>4,3456=>3);

sub show {
  my $self=shift;
  my $empid=$self->param('empId');
  my $type=$self->param('type');
  #print "\nEMployyeeID: $empid";
  #print "\nRequestTYPE: $type";
  if ($type =~ /location/i) {show_location_results($self,$type) ; return 1;};
  $self->render('results/show',type=>$type,result=>\%tacresults,);
}
sub show_tac_results {
  my $self=shift;
  my $empid=$self->param('empID');
  my $type=$self->param('type');
  print "EMployyeeID: $empid";
  my %results=(5743=>2, 1234=>4,3456=>3);
  $self->render('results/show',type=>$type,data=>%results,);
}
sub show_stationary_results {
  my $self=shift;
  my $empid=$self->param('empID');
  my $type=$self->param('type');
  print "EMployyeeID: $empid";
  my %results=(5743=>2, 1234=>4,3456=>3);
  $self->render('results/show',data=>%results,);
}
sub show_lptp_results {
  my $self=shift;
  my $empid=$self->param('empID');
  my $type=$self->param('type');
  print "EMployyeeID: $empid";
  my %results=(5743=>2, 1234=>4,3456=>3);
  $self->render('results/show',data=>%results,);
}
sub show_location_results {
  my $self=shift;
  my $type=shift;
  my $search_result=$self->db->resultset('Location')->search_rs({},{columns =>[ qw/location_id office_location/ ]});
  my $count=$search_result->count;
  my @search_result_ary=$search_result->all();
  print @search_result_ary;
  my $results=$self->db->resultset('Location')->cursor;
  my @results_ary_ref=$results->all;
  #print "\nNEXT".Data::Dumper::Dumper($results->next)."NEXT\n";
  #print Data::Dumper::Dumper($search_result);
  #$self->app->log->debug(Dumper($search_result->all() ) );
  #print "RREEesults: ".ref results . "\n";
  print "!!!-------####------------";  
  #my $resultss={};
  $self->render('results/show',type=>$type,result=>\@results_ary_ref);
}
1;
