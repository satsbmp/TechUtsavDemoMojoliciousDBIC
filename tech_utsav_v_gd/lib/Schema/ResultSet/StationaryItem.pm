package Schema::ResultSet::StationaryItem;

use base 'DBIx::Class::ResultSet';

use Tie::IxHash;

sub item_list{ 
    my $self=shift;
    my @itemlist=$self->search(undef, { columns => [qw/item_name/]})->all();
    return @itemlist;
}

sub item_id{
    my $self=shift;
    my $item_name = shift;
    my $item_id = $self->search(
                                {'item_name' => $item_name},
                                {columns => [qw/stationary_id/]}
                              );
    return $item_id->first->stationary_id;
}
sub item_name_by_id{
    my $self=shift;
    my $stationary_id = shift;
    my $item_name = $self->search(
                                {stationary_id => $stationary_id},
                                {columns => [qw/item_name/]}
                              );
    return $item_name->first->item_name;
}

1;
