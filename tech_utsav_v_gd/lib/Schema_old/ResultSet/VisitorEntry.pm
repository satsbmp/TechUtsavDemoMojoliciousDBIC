package Schema::ResultSet::VisitorEntry;

use base 'DBIx::Class::ResultSet';


sub get_columns{
    my $self=shift;
    my @tempcolumns=$self->result_source()->columns;
    
    my @columns=grep{$_ !~ /time/i}@tempcolumns; 
    
    shift @columns;
    
    #$self->app->log->debug(Data::Dumper::Dumper("\n$0 get_columns::: [@columns]") );
    
    return [@columns];
}

1;