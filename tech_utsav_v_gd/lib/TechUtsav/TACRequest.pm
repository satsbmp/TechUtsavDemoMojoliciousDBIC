package TechUtsav::TACRequest;

use Mojo::Base 'Mojolicious::Controller';

#use constant MAXTACCOUNT => 3;
our $MAX_TAC_COUNT=3;

sub _dumper_hook {
  $_[0] = bless {
    %{ $_[0] },
    result_source => undef,
  }, ref($_[0]);
};

sub index{
    my $self=shift;
    #$self->render('tacrequest/index');
    #$self->render('employee/search');
    $self->redirect_to('/tac/show');
};

sub show {
  my $self=shift;
  my $empid=$self->param('empId') || $self->session('empId') || undef;
  my $type=$self->param('type') || 'tac';
  my $tacdetails=undef;
  my $tac_add_enable=undef;
  $self->app->log->debug("\n-Entry:[$empid][$type]"); 
  
  my $msg= $self->flash('messsage') || undef;
  
  print "\n***##########***** empid :$empid:".$self->session('empId').":\n";
  
  ## Render only Employee search page if Employee ID not defined
  goto LAST unless (defined $empid );
  
  print "\n***(((((((((((( empid :$empid:".$self->session('empId').":\n";
  
  ## if employee ID defined then start processing
  $self->session(empId=>$empid);
  
  $tacdetails->{header}->{employee}= (defined $empid ) ? $self->get_employee_details($empid) : undef;
  my $tacrequest=$self->db->resultset('Tacrequest')->search({employee_id=>$empid, tac_returned => 0});
  my $taccount=$tacrequest->count;
  my @tac_results_ary=$tacrequest->all();  
    
  
  $tacdetails->{header}->{columnss} = $self->db->resultset('Tacrequest')->get_columns();
  $tacdetails->{data} = [ @tac_results_ary ];
  
  #print "\n[[[[COLUMNS". keys %{$tacdetails->{columns}} ."]]]]\n";
  
  my $count=0;
    foreach my $row(@tac_results_ary){
        my $month=$self->db->resultset('Tacrequest')->find_month($row->tacrequest_date->epoch);    
        $tacdetails->{tac_details}->{$month}++;
        $count++;
    };
  
  #$self->app->log->debug("********************".Data::Dumper::Dumper($tacdetails) );
  
  my $current_month= $self->db->resultset('Tacrequest')->current_month();
  $tac_add_enable=( $tacdetails->{tac_details}->{$current_month} >= $MAX_TAC_COUNT )? 0:1;
  
  $msg .= $tac_add_enable ?
    "\n You are allowed to request new TAC's for the month of $current_month" :
    "\n User has crossed the MAXIMUM Limit of".$MAX_TAC_COUNT." for the month of $current_month";
    $self->app->log->debug($tac_add_enable."|".$msg);
  $self->flash(message=> $msg);  
  #$self->render('tacrequest/show',type=>$type,result=>\@tac_results_ary,);
  LAST:
  $self->render('tacrequest/show',type=> $type, result=>$tacdetails,enable=>$tac_add_enable);  
}

sub add{
    my $self= shift;
    my $tacdetails=undef;    
    my $tacid=$self->param('tacid');
    my $empid=$self->param('empId') || $self->session('empId');
    my $msg=undef;
    print "\n #####add:tacid:$tacid;;;empid :$empid:".$self->session('empId').":".$self->{empId}.":\n";  
    #my $response=$self->db->resultset('Tacrequest')->cursor;
    #my $taccount= $response->count;
    my $tac_returned = $self->db->resultset('Tacrequest')->search({tacid=>$tacid,tac_returned => 0})->count;
    if ($tac_returned){
        $msg="TAC ID is not yet returned, kindly assign other TACID/First Render the TAC\n";
        goto REDIRECT;
    };

    my $response=$self->db->resultset('Tacrequest')->create({tacid=>$tacid,employee_id=>$empid,issuer_emp_id=>2345});
    print "\n ADD:RES $response\n";
    $msg=$response ? "TAC Activate: Success": "TAC activation - Failed";
    
    #$response=$self->db->resultset('Tacrequest')->search({tacid=>$tacid,employee_id=>$empid});
    #print "\n ADD:RES $response\n";        
    #my @results= $response->all();
    
    #$tacdetails->{header} = {};#get_employee_details($self,$empid);
    #$tacdetails->{data} = [ @results ];    
    #$self->render('tacrequest/show',result=>$tacdetails);
 REDIRECT:
    $self->flash(message=> $msg);
    $self->redirect_to('/tac/show?');
}
sub rendertac{
    my $self= shift;
    my $tacid=$self->param('tacid');
    my $empid=$self->param('empId') || $self->session('empId');
    my $tacdetails=undef;
    #print "\n rendertac :tacid:$tacid;;;empid $empid\n";    
    my $response=$self->db->resultset('Tacrequest')->search({employee_id=>$empid,tacid=>$tacid,tac_returned => 0 });
    #my $taccount= $response->count;
    #my @results= $response->all();
    my $res=$response->update({tac_returned=>1,tac_returned_date=>'NOW()'});
    
    print "\n rendertac: RENDER:RES $res\n";
    my $msg=$res ? "TAC-Render: Success ": "TAC-Render: Failed";
    
    
    $self->flash(message=> $msg);    
    $self->redirect_to('/tac/show');
    #$tacdetails->{header}={};#get_employee_details($self,$empid);
    #$tacdetails->{data} = [ @results ];
    
    #$self->render('tacrequest/show',result=>$tacdetails);
}

sub get_employee_details{
    my $self=shift;
    my $empid=shift;
    print "\nEMPLOYEE ID:$empid:::###";
    my $employee=$self->db->resultset('Employee')->search({employee_id=>$empid});
    #print Data::Dumper::Dumper($employee->all());
    my $employee_name=$employee->first->emp_name;
    return {employee_name=>$employee_name,employee_id=>$empid};  
}
sub space_adjust{
    my $self=shift;
    my @ary=@_;
    my @ret_ary=();
    my $max_len=0;
    foreach my $string(@ary){
        my $temp=split //,$string;
        $max_len=$temp if $temp > $max_len;        
    };
    foreach my $string(@ary){
        my $str_len=split //,$string;
        my $len=($max_len + 1) - $str_len;
        $string .=" " . ('&#160; ' x $len) . ":";
        push @ret_ary, $string;        
    };
    print "\nARRAY @ret_ary ";
    return @ret_ary;    
}
1;