package Schema::ResultSet::StationaryRequest;

use base 'DBIx::Class::ResultSet';

sub insert_items{ 
    my $self=shift;
    my $id = shift;
    my $count = shift;
    my $itemlist=$self->create(
  {
     stationary_id => $id,
     stationary_item_count => $count,
  });
    return $itemlist;
}

1;
