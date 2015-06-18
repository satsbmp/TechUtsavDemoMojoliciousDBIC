package Schema::ResultSet::Tacrequest;

use base 'DBIx::Class::ResultSet';
use DateTime;
use Tie::IxHash;

sub by_month(){
    my $self=shift;    
    my $empid=$self->param('empId');
    my $type=$self->param('type');
    my $test=$self->db->resultset('Tacrequest')->search({employee_id=>$empid});
    my @test_results_ary=$test->all();
  
    foreach my $row(@test_results_ary){
        my $temp=$row->employee_id;
        my $epoch=$row->tacrequest_date->epoch;
        my $dt = DateTime->from_epoch( epoch => $epoch );
        my $month = $dt->month;
        print "\n--TEMP".$temp ."---MONTH..".$month."\n";
    }   
    
}

sub find_month{
    my $self=shift;
    my $epoch=shift;
    my $dt = DateTime->from_epoch( epoch => $epoch );
    my $month = $dt->month;
    my $month_name = $dt->month_name;
    print "\n-MONTH..".$month."\nMONTHNAME".$month_name."\n";
    #return $month;
    return $month_name;
}
sub current_month{
    my $self=shift;
    my $epoch=shift;
    my $dt = DateTime->now;
    my $month = $dt->month;
    my $month_name = $dt->month_name;
    print "\n-MONTH..".$month."\nMONTHNAME".$month_name."\n";
    #return $month;
    return $month_name;
}

sub date_ddmmyyyy_format{ 
    #return shift->created_time->strftime("%A, %B %e, %Y at %l:%M%p");
    my $self=shift;
    my $rowdata=shift;
    my $date=$rowdata->tacrequest_date->strftime("%d-%m-%Y");
    print "DATE:$date";
    return $date;
}
sub get_columns{
    my $self=shift;    
    my %columns = undef;
    tie %columns, "Tie::IxHash";
    
    #my @tempcolumns=$self->result_source()->columns;
    
    %columns = (
        tacid => 'TAC ID',
        tacrequest_date => 'Request Date',
        tac_returned => 'Return TAC'
    );
    #my @ary=keys %$columnss;
    #print "\nget_columns::: [ ". @ary . "]\n";    
    return \%columns;
}
#    $self->app->log->debug(Data::Dumper::Dumper($row->tacrequest_date->epoch));
    #my $epoch=$row->tacrequest_date->epoch;    my $month1=$self->db->resultset('Tacrequest')->find_month($epoch);
    #my $dt = DateTime->from_epoch( epoch => $epoch );    my $month = $dt->month;

1;
