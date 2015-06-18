use utf8;
package Schema::Result::StationaryItem;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("stationary_items");
__PACKAGE__->add_columns(
  "stationary_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "item_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);
__PACKAGE__->set_primary_key("stationary_id");


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-08-04 15:28:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:N/fpiUkgNrbHvYa1qCchhw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
