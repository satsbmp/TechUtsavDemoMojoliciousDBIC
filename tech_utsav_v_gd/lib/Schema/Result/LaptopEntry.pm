use utf8;
package Schema::Result::LaptopEntry;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("laptop_entry");
__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "employee_id",
  { data_type => "int", is_nullable => 1 },
  "laptop_id",
  { data_type => "int", is_nullable => 1 },
  "check_in_datetime",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
  },
  "check_out_datetime",
  { data_type => "timestamp", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-09-22 11:54:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GUoYjjUCE3nWz4Q8inWldQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
