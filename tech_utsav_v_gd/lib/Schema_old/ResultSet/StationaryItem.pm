package Schema::ResultSet::StationaryItem;

use base 'DBIx::Class::ResultSet';

sub item_list{ 
    my $self=shift;
    my $itemlist=$self->search(undef, {
    columns => [qw/item_name/],
  });
    return $itemlist;
}

sub item_id{
    my $self=shift;
    my $item_name = shift;
    my $itemid = $self->search(
                                {'item_name' => $item_name},
                                {columns => [qw/stationary_id/]}
                              );
    return $itemid;
}

1;
