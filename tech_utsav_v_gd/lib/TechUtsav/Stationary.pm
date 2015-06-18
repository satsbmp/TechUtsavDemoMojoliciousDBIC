package TechUtsav::Stationary;
use Mojo::Base 'Mojolicious::Controller';

sub index{
    my $self=shift;
    #$self->render('employee/search');
	$self->redirect_to('/stnry/show');
}

sub show {
	my $self=shift;
	my $empid=$self->param('empId') || $self->session('empId') || undef;
	my $type=$self->param('type') || 'stnry';  
	my $stationary_details=undef;  
	my $msg = undef;
	
	## Render only Employee search page if Employee ID not defined	
	goto LAST unless (defined $empid );
  	$self->app->log->debug("\n ::".__PACKAGE__."::show:EmployeeID:$empid::::\n");
	## if employee ID defined then start processing	
    $self->session(empId=>$empid);	
	
	my $stationaryitem = $self->db->resultset('StationaryItem')->search();
	my @stationary_records = $self->db->resultset('StationaryRequest')->search(employee_id => $empid)->all();#get_records($empid);
		
	#$self->render('stationary/show',itemnames=>\@itemnames);

	
	$stationary_details->{header}->{employee}	= $self->db->resultset('Employee')->get_employee_details($empid);
	$stationary_details->{header}->{columns} 	= $self->db->resultset('StationaryRequest')->get_columns();
	$stationary_details->{data}->{records} 		= [ @stationary_records ] ;
	$stationary_details->{data}->{entries}		= $stationaryitem ;
    LAST:
	##$self->flash(message=> $msg);
    $self->render('stationary/show',type=> $type, result=>$stationary_details);  
}
sub add {
    my $self=shift;
    my $itemchecked= undef;
	my $msg=undef;
	my $empid=$self->param('empId') || $self->session('empId') || undef;
	my $item_name=$self->param('stationaryitems');
	my $item_count=$self->param('stationary_item_count');
    
	my $item_id= $self->db->resultset('StationaryItem')->item_id($item_name);	
	
	$self->app->log->debug("\n ::".__PACKAGE__."::add:ITEMID:$item_id:itemname:$item_name:item_count:$item_count:\n");
	
	my $itemrequest = $self->db->resultset('StationaryRequest')->insert_items($item_id,$item_count,$empid);
	#print "\n::::::::" . $self->dumper($itemrequest) . "::::::::::::::::::::::\n";
	$msg = ($itemrequest) ? "Stationary Request - Add : Success": "Stationary Request - Add : Failed";	
	
	$self->flash(message=> $msg);
	
   REDIRECT:
   $self->redirect_to('/stnry/show');
}

1;

=pod
my $totalitems = $self->param('total');
    print "$totalitems";
    print "\n";
    for(my $a =1 ; $a <= $totalitems ;$a = $a +1){
	 my $itemcheckedcount = 'itemchecked'.$a;
	 my $itemcount = 'item'.$a;
	 my $totalcount = 'count'.$a;
       $itemchecked= $self->param($itemcheckedcount);
    my $item_name=$self->param($itemcount);
    my $count=$self->param($totalcount);