package Schema::ResultSet::Employee;

use base 'DBIx::Class::ResultSet';

sub get_employee_details{
    my $self=shift;
    my $empid=shift; #|| $self->session('empId');
    print "\nget_employee_details:EMPLOYEE ID:$empid";
    my $employee=$self->search({employee_id=>$empid});
    #print Data::Dumper::Dumper($employee->all());
    my $employee_name=$employee->first->emp_name;
    my $header={employee_name=>$employee_name,employee_id=>$empid};
    print "\n get_employee_details:%$header";
    return $header; 
}


#    $self->app->log->debug(Data::Dumper::Dumper($row->tacrequest_date->epoch));
    #my $epoch=$row->tacrequest_date->epoch;    my $month1=$self->db->resultset('Tacrequest')->find_month($epoch);
    #my $dt = DateTime->from_epoch( epoch => $epoch );    my $month = $dt->month;

1;
