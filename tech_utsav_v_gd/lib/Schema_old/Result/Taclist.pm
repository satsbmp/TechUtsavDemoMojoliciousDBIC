use utf8;
package Schema::Result::Taclist;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("taclist");
__PACKAGE__->add_columns(
  "tacid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "location_id",
  { data_type => "varchar", is_nullable => 1, size => 30 },
);
__PACKAGE__->set_primary_key("tacid");


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-08-04 15:28:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:E/LUvmF34Eb4r2j5FnTDjw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
