package Schema::ResultSet::StationaryRequest;

use base 'DBIx::Class::ResultSet';

sub insert_items{ 
    my $self=shift;
    my $id = shift;
    my $count = shift;
    my $employee_id = shift;
    my $itemlist=$self->create(
        {
           stationary_id => $id,
           employee_id => $employee_id,
           stationary_item_count => $count,
        }
    );
    return $itemlist;
}

sub get_records{ 
    my $self=shift;    
    my $employee_id = shift;    
    my $itemlist=$self->search( {employee_id => $employee_id,});
    return $itemlist;
}

sub get_columns {
    my $self=shift;
    my %columns = undef;
    tie %columns, "Tie::IxHash";
    
    my @tempcolumns=$self->result_source()->columns;
    
    %columns = (
        item_name => 'Item Name',
        stationary_request_date => 'Request Date',
        stationary_item_count => 'Item Count'
    );
    #my @ary=keys %$columnss;
    #print "\nget_columns::: [ ". @ary . "]\n";    
    return \%columns;
}

1;
