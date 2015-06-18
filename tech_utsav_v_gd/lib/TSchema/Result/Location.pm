use utf8;
package Schema::Result::Location;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("location");
__PACKAGE__->add_columns(  
  "location_id",
  { data_type => "integer", is_nullable => 0 },
  "office_location",
  { data_type => "char", is_nullable => 0, size => 255 },
);
__PACKAGE__->set_primary_key("location_id");

1;

=head1 RELATIONSHIPS

=head2 primary

Type: belongs_to

Related object: L<Schema::Result::Photo>

Alias for L<Schema::Result::Photo/primary_photo>

=head1 METHODS

=head2 date

Datetime object from set's primary photo

=head2 decoded_title

Title decoded from utf8

=head2 url_title

Title for use in readable URLs - uses id for incompatible titles

=head2 region

Region from set's primary photo

=head2 previous

Previous set, ordered by idx field

=head2 next

Next set, ordered by idx field

=head2 location

Location from set's primary photo

=head2 time_since

Time since photo was taken
