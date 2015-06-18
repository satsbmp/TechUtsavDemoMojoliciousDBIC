use utf8;
package Schema::Result::Tacrequest;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("tacrequest");
__PACKAGE__->add_columns(
  "tacrequest_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "issuer_emp_id",
  { data_type => "int", is_nullable => 1 },
  "tacid",
  { data_type => "int", is_nullable => 1 },
  "employee_id",
  { data_type => "int", is_nullable => 1 },
  "tacrequest_date",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
  },
  "tac_returned",
  { data_type => "boolean", default_value => 0, is_nullable => 1 },
  "tac_returned_date",
  { data_type => "timestamp", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("tacrequest_id");


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-08-04 20:39:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BuuwvbPugBtTmGRvfb6iMA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
