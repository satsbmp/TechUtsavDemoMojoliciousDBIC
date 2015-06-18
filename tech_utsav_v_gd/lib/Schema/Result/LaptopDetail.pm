use utf8;
package Schema::Result::LaptopDetail;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table_class("DBIx::Class::ResultSource::View");
__PACKAGE__->table("laptop_details");
__PACKAGE__->add_columns(
  "laptop_id",
  { data_type => "int", is_nullable => 1 },
  "employee_id",
  { data_type => "int", is_nullable => 1 },
  "check_in_datetime",
  { data_type => "timestamp", is_nullable => 1 },
  "check_out_datetime",
  { data_type => "timestamp", is_nullable => 1 },
  "laptop_serial_id",
  { data_type => "int", is_nullable => 1 },
  "laptop_company_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "laptoptype",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-09-22 11:54:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nc6MzOQhuJrrYWqLM2P0UA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
