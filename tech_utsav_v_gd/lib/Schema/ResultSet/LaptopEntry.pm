package Schema::ResultSet::LaptopEntry;

use base 'DBIx::Class::ResultSet';
use Tie::IxHash;
my %columns = undef;
tie %columns, "Tie::IxHash";

sub date_ddmmyyyy_format{ 
    #return shift->created_time->strftime("%A, %B %e, %Y at %l:%M%p");
    my $self=shift;
    my $rowdata=shift;
    my $date=$rowdata->strftime("%d-%m-%Y");
    print "DATE:$date";
    return $date;
}

sub get_columns{
    my $self=shift;
    
    my @tempcolumns=$self->result_source()->columns;
    
    %columns= (
        laptop_serial_id => 'Serial No',
        laptop_company_name => 'Make',
        laptoptype => 'Type',
        check_in_datetime=>'Check In Time',
        check_out_datetime=>'Check Out'
    );
    #shift @columns;
    
    #$self->app->log->debug(Data::Dumper::Dumper("\n$0 get_columns::: [@columns]") );
    
    return \%columns;
}

1;