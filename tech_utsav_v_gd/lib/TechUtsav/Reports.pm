package TechUtsav::Reports;
use Mojo::Base 'Mojolicious::Controller';

my ($report_tac,
    $report_stnry,
    $report_lptp,
    $report_courier,
    $report_vstr)=(undef,undef,undef,undef,undef);
my $report_tac_fields=undef;

$report_tac={
    fields => [qw(all type emp details)],
    display_fields=>{
        all=>[qw(month taccount nonreturned returned)],
        type=>[qw(month type count)],
        emp=>[qw(empid month taccount returned)],
        details=>[qw(empid date time seq tacnumber retdate returned issuerid)],
    },
    values=>{
        all=> [{month=>'april',taccount=>10,nonreturned=>5,returned=>5},{month=>'June',taccount=>10,nonreturned=>2,returned=>5},],
        type=>[{month=>'april',type=>'employee',count=>20},{month=>'april',type=>'client',count=>20}],
        emp=> [{empid=>5743,month=>'april',taccount=>3,returned=>1},{empid=>5745,month=>'june',taccount=>3,returned=>1},],
        details=>[
            {empid=>5743,date=>12032014,time=>"12:01",seq=>1,tacnumber=>123456,retdate=>12032014,returned=>1,issuerid=>1234},
            {empid=>5742,date=>12032014,time=>"12:01",seq=>1,tacnumber=>123457,retdate=>12032014,returned=>0,issuerid=>1234},
        ]
    }
};
sub index{
    my $self=shift;
    my $report=undef;
    #$self->render('reports/index');
    $self->redirect_to('/rprts/show');
}
sub show{
    my $self=shift;
    my $reporttype=$self->param('reporttype') || undef;
    #$self->render('reports/index');
    $self->app->log->debug("ReportTYPE: $reporttype");   
  #$self->render('reports/show',type=> $reporttype,report=>$report_tac,);
   #$self->render('reports/tac',type=> $reporttype,report=>$report_tac,fields=>$report_tac_fields )          if $reporttype =~ /tac/;
   #$self->render('reports/stationary',type=> $reporttype,report=>$report_tac,)  if $reporttype =~ /stnry/;
   #$self->render('reports/visitor',type=> $reporttype,report=>$report_tac,)     if $reporttype =~ /vstr/;
   #$self->render('reports/laptop',type=> $reporttype,report=>$report_tac,)      if $reporttype =~ /lptp/;
   #$self->render('reports/courier',type=> $reporttype,report=>$report_tac,)     if $reporttype =~ /courier/;
   $self->render('reports/index', report_type=> $reporttype,report=>$report_tac );
}

###SampleReports
##TAC Register:
##SI No.,Date,Employee Name,ID No.,CellPhone, Photo Id No, Project Name, PM Name, Check-in Time,TAC No.,Check-out Time Signature,Team Mate ID no, Security Signature, Operation Team member Name and Signaut
#$report_tac=(fields=(empid,tacnum,date,count,time),
$report_tac_fields={
    fields => [qw(all type emp details)],
    display_fields=>{
        all=>[qw(month taccount nonreturned returned)],
        type=>[qw(month type count)],
        emp=>[qw(empid month taccount returned)],
        details=>[qw(empid date time seq tacnumber retdate returned issuerid)],
    }
};

##MAx One Year
$report_tac={
    fields => [qw(all type emp details)],
    display_fields=>{
        all=>[qw(month taccount nonreturned returned)],
        type=>[qw(month type count)],
        emp=>[qw(empid month taccount returned)],
        details=>[qw(empid date time seq tacnumber retdate returned issuerid)],
    },
    values=>{
        all=> [{month=>'april',taccount=>10,nonreturned=>5,returned=>5},{month=>'June',taccount=>10,nonreturned=>2,returned=>5},],
        type=>[{month=>'april',type=>'employee',count=>20},{month=>'april',type=>'client',count=>20}],
        emp=> [{empid=>5743,month=>'april',taccount=>3,returned=>1},{empid=>5745,month=>'june',taccount=>3,returned=>1},],
        details=>[
            {empid=>5743,date=>12032014,time=>"12:01",seq=>1,tacnumber=>123456,retdate=>12032014,returned=>1,issuerid=>1234},
            {empid=>5742,date=>12032014,time=>"12:01",seq=>1,tacnumber=>123457,retdate=>12032014,returned=>0,issuerid=>1234},
        ]
    }
};
#$report_stnry=(fields=(empid,type,date,count,time),
#all=>qw(month,count,delivered,nondelivered),
#type=>(month,type,count),
#emp=>qw(month,count,delivered,nondelivered),
#details=>qw(empname,month,date,seq,type,delivered,couriernumber));
$report_stnry={
    all=>[{month=>'april',stockOut=>50,stockIn=>100},{month=>'June',stockOut=>50,stockIn=>100},],
    type=>[{month=>'april',type=>'pen',stockOut=>50,stockIn=>100},
           {month=>'april',type=>'Notepad',stockOut=>50,stockIn=>100},
           {month=>'June',type=>'pen',stockOut=>50,stockIn=>100}],
    emp=>[{empid=>5743,month=>'april',type=>'pen',count=>3,notepad=>2},{empid=>5743,month=>'april',pen=>1,notepad=>0}],
    details => [{empid=>5743,date=>12032014,time=>"12:01",type=>'pen',count=>3},{empid=>5743,date=>12032014,type=>'notepad',count=>3,}],
};
#laptopentries,laptopregister
#type=laptop/PC
##LAPTOPREGISTER:si.No.,Date,location,Employee Name,Laptop Make, Laptop Si.No, Quantity, INTime,Signature,OutTime Signature,Remarks
#$report_lptp=(fields=(empid,sno,make,model,type,date,count,time),
#Laptop_entries=>qw(empid,sno,make,model,type);
#all=>qw(month,count,delivered,nondelivered),
#type=>(month,type,count),
#emp=>qw(month,count,delivered,nondelivered),
#details=>qw(empname,month,date,seq,type,delivered,couriernumber));
$report_lptp={
    all=>[{month=>'april',entries=>10,empcount=>10,},{month=>'June',entries=>10,empcount=>10,},],
    type=>[{type=>"SSE",count=>5},{type=>"SE",count=>5}],
    emp=>{  
        5743=>{sno=>123456,in=>'CURRENT_TIME',out=>'CURRENT_TIME',securityid=>1234},
        5743=>{sno=>123456,in=>'CURRENT_TIME',out=>'CURRENT_TIME',securityid=>1234},
    },
    entries=>{
        5743=>[{sno=>123456,make=>"Dell",model=>"t200",type=>"laptop"},{sno=>123456,make=>"Lenovo",model=>"m-one",type=>"PC"}],
        5743=>[{sno=>123456,make=>"Dell",model=>"t200",type=>"laptop"},],
    }
};
###VISITOR:SI No.,Date,Name of Visitor,From Address,Whome to meet, Purpose,Visiotr Badge No.,Time in, Signature, Time Out, Signature, Signature of teh Security, Rematks
#$report_vstr=(fields=(empid,sno,make,model,type,date,count,time),
#$report_vstr_fields=(all=>qw(month,count,contact,nonreturns,returns),details=>qw(name,badge,contact,purpose,tomeet,in,out,issuerid,regular)
#all=>qw(month,count,contacts,type,nonreturns,returns),
#type=>(month,type,count),
#vstr=>qw(month,name,contact,count,purpose,type),
#details=>qw(seq,date,time,name,badgenumber,contact,delivered,purpose,tomeet,timein,timeout,issuerid,type));
$report_vstr={
    all=>[{month=>'april',count=>10,contacts=>2,type=>'regular',nonreturns=>5,returns=>10},
          {month=>'april',count=>10,contacts=>2,type=>'regular',nonreturns=>5,returns=>10},],
    type=>[{month=>'april',type=>"regular",count=>5},{month=>'april',type=>"non-regular",count=>5}],
    vstr=>[{month=>'april',name=>'Nagaraj',contact=>1234567890,purpose=>'water',type=>0},
           {month=>'april',name=>'Nagaraj',contact=>1234567890,purpose=>'water',type=>0}],
    details=>[{seq=>1,date=>12032014,time=>"12:03",name=>'Nagaraj',badgenumber=>1234,contact=>1234567890,purpose=>'water',tomeet=>"HR",timein=>'CURRENT_TIME',timeout=>'CURRENT_TIME',issuerid=>1234,type=>1},
              {seq=>1,date=>12032014,time=>"12:03",name=>'Mikky',badgenumber=>1234,contact=>1234567890,purpose=>'buziness',tomeet=>"HR",timein=>'CURRENT_TIME',timeout=>'CURRENT_TIME',issuerid=>1234,type=>0},],
};
##CourierTypes=
##CourierRegister
##CourierRegister_fields=(
#all=>qw(month,count,delivered,nondelivered),
#type=>(month,type,count),
#emp=>qw(month,count,delivered,nondelivered),
#details=>qw(empname,month,date,seq,type,delivered,couriernumber));
$report_courier={
    all=>[{month=>'april',count=>25,delivered=>5,nondelivered=>20},{month=>'June',count=>25,delivered=>5,nondelivered=>20},],
    type=>[{month=>'april',type=>"bankstatements",count=>20,},{month=>'april',type=>"parcels",count=>20,},{month=>'april',type=>"courier",count=>20,}],
    emp=>{
        5743=>[{month=>'april',count=>3,delivered=>1,nondelivered=>2},],
        5744=>[{month=>'april',count=>3,delivered=>1,nondelivered=>2},[{month=>"june",seq=>2,type=>"BankStmt",datetime=>"12032014",delivered=>0},{month=>"june",seq=>1,type=>"parcel",datetime=>"12032014",couriernumber=>123456,delivered=>0}] ],
    },
    details=>[
        {empname=>"Satish",month=>"june",seq=>1,type=>"parcel",datetime=>"12032014",couriernumber=>123456,delivered=>1,}
        #{empid=>5743,month=>"june",seq=>1,type=>"parcel",datetime=>"12032014",couriernumber=>123456,delivered=>1, },
         #     {empid=>5743,month=>"june",seq=>1,type=>"parcel",datetime=>"12032014",couriernumber=>123456,delivered=>1,},           
    ]
};
1;
