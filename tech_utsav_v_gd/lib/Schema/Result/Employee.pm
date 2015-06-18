use utf8;
package Schema::Result::Employee;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("employee");
__PACKAGE__->add_columns(
  "employee_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "emp_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "emp_password",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);
__PACKAGE__->set_primary_key("employee_id");


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-09-22 11:54:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GyFkIoWb/YbNJ7wl2fZ5bQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
