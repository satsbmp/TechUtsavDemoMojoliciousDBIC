use utf8;
package Schema::Result::LaptopRecord;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("laptop_record");
__PACKAGE__->add_columns(
  "laptop_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "employee_id",
  { data_type => "int", is_nullable => 1 },
  "laptop_serial_id",
  { data_type => "int", is_nullable => 1 },
  "laptop_company_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "laptoptype",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "created_date",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
  },
);
__PACKAGE__->set_primary_key("laptop_id");


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-08-21 19:57:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eT6BxcNDCyfodAU0qO85yg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
