package TechUtsav::Laptop;
use Mojo::Base 'Mojolicious::Controller';

sub index{
    my $self=shift;
	$self->stash('type'=>'lptp');
    #$self->render('employee/search');
	$self->redirect_to('/lptp/show');
}

sub show {
    my $self=shift; 
    my $empid=$self->param('empId') || $self->session('empId') || undef;
    my $type=$self->param('type') || 'lptp';
	my $checkin_type=$self->flash('checkin_type')|| 'checkin';
	
    my $laptop_details=undef;  
	my $msg = undef;
	
	## Render only Employee search page if Employee ID not defined	
	goto LAST unless (defined $empid );
  
	## if employee ID defined then start processing	
    $self->session(empId=>$empid);
    
    #$self->app->log->debug("\n".__PACKAGE__."::Show-[$empid][$type]::".$self->flash('checkin_type')."::");
    
    my @laptop_records=$self->db->resultset('LaptopRecord')->search({employee_id=>$empid})->all();	
	my $laptop_record_res=$self->db->resultset('LaptopDetail')->search({employee_id=>$empid});	
	
	my @laptop_details = $laptop_record_res->all();
	#my @laptop_records112 = $laptop_records1->first;
	
	#my $laptop_res=$self->db->resultset('LaptopEntry')->search({employee_id=>$empid} );
    #my @laptopentry=$laptop_res->all();
	#my @columns=$laptop_res->result_source->columns();
    #$self->app->log->debug("\n".__PACKAGE__."::Show - EmplID-$empid:checkin_type-$checkin_type:type-$type:columns -[ @columns ]");
	
    $laptop_details->{header}->{employee}	= $self->db->resultset('Employee')->get_employee_details($empid);
	$laptop_details->{header}->{columns} 	= $self->db->resultset('LaptopEntry')->get_columns();
	$laptop_details->{data}->{records} 		= [ @laptop_records ];
	$laptop_details->{data}->{entries} 		= [ @laptop_details ];
    LAST:
	##$self->flash(message=> $msg);
    $self->render('laptop/show',type=> $type, checkin_type => $checkin_type, result=>$laptop_details);  
}
sub add {
    my $self=shift;    
    my $laptop_serial_id=$self->param('laptop_serial_id');
    my $laptop_make=$self->param('laptop_company_name');
    my $laptop_type=$self->param('laptoptype');
    my $empid=$self->param('empId') || $self->session('empId');
    my $count=$self->db->resultset('LaptopRecord')->search({employee_id=>$empid,laptop_serial_id=>$laptop_serial_id,laptop_company_name=>$laptop_make,laptoptype=>$laptop_type})->count;
    my $response=undef;
    unless ($count)  {
		$response=$self->db->resultset('LaptopRecord')->create({employee_id=>$empid,laptop_serial_id=>$laptop_serial_id,laptop_company_name=>$laptop_make,laptoptype=>$laptop_type});
    };
    print "\n ADD:RES $response\n";
    my $msg=$response ? "Laptop Record Add: Success": "Laptop Record Add - Failed";
    $self->flash(message=> $msg);
    $self->redirect_to('/lptp/checkin');
}
sub checkin {
    my $self=shift;    
    my $laptop_serial_id=$self->param('laptop_serial_id') || $self->session('laptop_serial_id') || undef;
	
	my $laptop_id=undef;
	my $response=undef;
	my $count=undef;
	my $msg = undef;
	my $checkin_type=undef;
	
	print "\n ". __PACKAGE__ . "checkin-LAPTOPSERIAL ID :$laptop_serial_id:$laptop_id:";
	
	$self->session(laptop_serial_id=>$laptop_serial_id);
	
    my $empid=$self->param('empId') || $self->session('empId');
	
    if ( defined $laptop_serial_id && defined $empid ) {
		
		my $laptop_res=$self->db->resultset('LaptopRecord')->search( {employee_id=>$empid,laptop_serial_id=>$laptop_serial_id} );
		$self->app->log->debug(__PACKAGE__ . "::checkin". $laptop_res->count .":".$laptop_res->count().":");
		
		if ($laptop_res->count){
			$laptop_id = $laptop_res->first->laptop_id;
			## Handling multiple checkins - if a serial id is already checked in, then onemore checkin is not allowed
			$response=$self->db->resultset('LaptopEntry')->search({employee_id=>$empid,laptop_id => $laptop_id } );
			
			$self->app->log->debug("Laptop Entry-Check in^^^^^ :$laptop_id:".defined $response.":".$response->count().":");
			$self->app->log->debug("Laptop Entry-Check in^^^^^ :$laptop_id:".defined $response.":".$response->count().":");	
			
			if (defined $response && $response->count && $response->first->check_out_datetime !~ /^\d{4}\-\d{2}\-/){
				$self->app->log->debug("Laptop Entry - :". $response->first->check_out_datetime ."|");
				$msg="Checkout not done for the previous record! First Checkout";
			}else{
				$response=$self->db->resultset('LaptopEntry')->create({employee_id=>$empid,laptop_id=>$laptop_id});			
				$checkin_type= 'checkin';
				$msg=$response ? "Laptop Entry - Check in: Success": "Laptop Entry - Check In : Failed";				
			}			
			
		}else {			
			$checkin_type= 'add';
			$self->app->log->debug("Laptop Entry - Add and Check in");
			$msg=undef;
			goto CHECKIN;
		}		
	}else{
		$msg = "Laptop Entry - Check in -Improper details";
	}
	
  CHECKIN:
	$self->flash(message=> $msg,checkin_type=> $checkin_type);	
	$self->redirect_to('/lptp/show?' );
}
sub checkout {
    my $self=shift;
	my $laptop_serial_id=$self->param('laptop_serial_id') || undef;
    my $laptop_id=$self->param('laptop_id') || undef;
	my $response = undef;
	my $msg=undef;
    my $empid=$self->param('empId') || $self->session('empId');
	
    #print "\nCHECKOUT DUMPER PARAM::" .$self->dumper($self->param) . ":$laptop_serial_id:\n";
	#$self->app->log->debug("CHECKOUT DUMPER PARAM :$laptop_serial_id:");
	
    my $lr_response=$self->db->resultset('LaptopRecord')->search({employee_id=>$empid,laptop_serial_id=>$laptop_serial_id});
	if ( defined $lr_response && $lr_response->count ){
		$laptop_id=$lr_response->first->laptop_id ;		
		if ( defined $laptop_id ) {
			#$self->app->log->debug("CHECKOUT DEFINED DUMPER PARAM :$laptop_serial_id:$laptop_id ::\n");
			my $search_response=$self->db->resultset('LaptopEntry')->search({employee_id=>$empid,laptop_id=>$laptop_id } );
			if (defined $search_response && $search_response->count){
				$response=$search_response->update({employee_id=>$empid,laptop_id=>$laptop_id,check_out_datetime=>\'CURRENT_TIMESTAMP'} );
				$msg = ($response) ? "Laptop Entry - Check Out: Success" :"Laptop Entry - Check Out: Failed";
			}
		}
		
	};
    
    print "\n ADD:RES $response\n";
    $msg= "Laptop Entry - Check Out: Failed" unless defined $msg;
    $self->flash(message=> $msg);
    $self->redirect_to('/lptp/show?');
}
1;

#my $laptop_records1=$self->db->resultset('LaptopEntry')->search({'employee_id'=>$empid},{ join => 'laptop_id',columns=> [ qw/laptop_id laptop_id.laptop_serial_id laptop_id.laptop_company_name laptop_id.laptoptype check_in_datetime check_out_datetime/ ]});    
    #my $employee=$self->db->resultset('Employee')->search({employee_id=>$empid});
    #my $employee_name=$employee->first->emp_name;
    #print Data::Dumper::Dumper("\nRECORDS COUNTTTTT:".$laptop_records1->count.":\n");
	#print Data::Dumper::Dumper(@laptop_records112);

