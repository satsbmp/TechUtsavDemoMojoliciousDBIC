package Schema::ResultSet::VisitorEntry;

use base 'DBIx::Class::ResultSet';
use Tie::IxHash;

sub get_columns_old{
    my $self=shift;
    my @tempcolumns=$self->result_source()->columns;
    
    my @columns=grep{$_ !~ /time/i}@tempcolumns; 
    
    shift @columns;
    
    #$self->app->log->debug(Data::Dumper::Dumper("\n$0 get_columns::: [@columns]") );
    
    return [@columns];
}

sub get_columns{
    my $self=shift;    
    my %columns = undef;
    tie %columns, "Tie::IxHash";
    
    #my @tempcolumns=$self->result_source()->columns;
    
    %columns = (
            vsitor_name         => 'Name',
            vistor_badge_id     => 'Badge Id',
            visit_purpose       => 'Purpose',
            contact             => 'Contact',
            tomeet              => 'To Meet',
            address             => 'Address',
            remarks             => 'Remarks',
            check_in_datetime   => 'Check In',
            check_out_datetime  => 'Check Out',
            
    );
    
    return \%columns;
}

1;