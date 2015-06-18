use utf8;
package Schema::Result::EmployeeRole;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("employee_role");
__PACKAGE__->add_columns(
  "emp_role_id",
  { data_type => "int auto_increment", is_nullable => 0 },
  "employee_id",
  { data_type => "int", is_nullable => 1 },
  "role_id",
  { data_type => "int", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("emp_role_id");


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-09-22 11:54:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:go10kZYH5f4kFwhESSiDeA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
