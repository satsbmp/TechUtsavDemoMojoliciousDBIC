package TechUtsav::Visitor;
use Mojo::Base 'Mojolicious::Controller';

#use Tie::IxHash;
#my %columns = undef;
#tie %columns, "Tie::IxHash";


sub index{
    my $self=shift;
    $self->render('visitor/index');
}

sub show {
    my $self=shift;     
    #my $type=$self->param('type');
    my $visitor_details=undef;    
    
    my $res=$self->db->resultset('VisitorEntry')->search();
    my @visitors=$res->all();   
    
    $visitor_details->{header}->{columns}   = $self->db->resultset('VisitorEntry')->get_columns();
    $visitor_details->{data} = [ @visitors ];
    
    $self->render('visitor/show',result=>$visitor_details);  
}
sub checkin {
    my $self=shift;
    
    my $tempcolumns=$self->db->resultset('VisitorEntry')->get_columns();#->result_source->columns();
    my $bind_params={};
    
    foreach my $column ( keys %$tempcolumns){
        next if ($column =~ /check_out_datetime/);
        $bind_params->{$column}=\'CURRENT_TIMESTAMP' && next if ($column =~ /check_in_datetime/);
        $bind_params->{$column}=$self->param($column);
    };   
    my $response=$self->db->resultset('VisitorEntry')->create($bind_params);
    
    my $msg=$response ? "Visitor Check in: Success": "Visitor Check In - Failed";
    
    print "\n ADD:RES $response\n";
    
    $self->flash(message=> $msg);
    $self->redirect_to('/vstr/show');
}

sub checkout {
    my $self=shift;
    my $vistor_badge_id=$self->param('vistor_badge_id');    
    
    my $search_response=$self->db->resultset('VisitorEntry')->search(vistor_badge_id => $vistor_badge_id);
    my $response=$search_response->update({vistor_badge_id=>$vistor_badge_id,check_out_datetime=>\'CURRENT_TIMESTAMP'});
    
    print "\n ADD:RES $search_response: $response:\n";
    my $msg=$response ? "Visitor Checkout: Success": "Visitor Checkout - Failed";
    $self->flash(message=> $msg);
    $self->redirect_to('/vstr/show?');
}

1;