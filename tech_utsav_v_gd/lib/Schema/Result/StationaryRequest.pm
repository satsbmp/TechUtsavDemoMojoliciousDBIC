use utf8;
package Schema::Result::StationaryRequest;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("stationary_request");
__PACKAGE__->add_columns(
  "employee_id",
  { data_type => "int", is_nullable => 1 },
  "stationary_id",
  { data_type => "int", is_nullable => 1 },
  "stationary_request_date",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
  },
  "stationary_item_count",
  { data_type => "int", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-09-22 11:54:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:y3s4ISEcsVXyWQFpJQ6S+g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
