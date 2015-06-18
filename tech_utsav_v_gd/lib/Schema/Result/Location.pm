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
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "office_location",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);
__PACKAGE__->set_primary_key("location_id");


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-09-22 11:54:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xAfWnwp/iZzN3z0gX3Rf/w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
