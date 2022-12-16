#!/usr/bin/perl
use strict;
use warnings;

print "Content-type: text/html\n\n";



use DBI;
# MySQL database configuration
my $dsn = "mysql";
my $username = "newuser";
my $password = 'newpass';

$dsn = "DBI:mysql:database=demo;host=mysqldb";
my $dbh  = DBI->connect($dsn,$username,$password);

my $query = 'SELECT * FROM Persons';
my $sth = $dbh->prepare($query);
$sth->execute();

my $data = $sth->fetchall_hashref('PersonID');

print q{
<style>
table, th, td {
  border:1px solid black;
}
</style>
<table style="width:100%">
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>City</th>
    <th>Address</th>
  </tr>
};

foreach my $member ( sort keys %{$data} ) {
  print qq{
    <tr>
      <td>$member</td>
      <td>$data->{$member}{FirstName} $data->{$member}{LastName}</td>
      <td>$data->{$member}{City}</td>
      <td>$data->{$member}{Address}</td>
    </tr>
  };
}

#use Data::Dumper;
#print Dumper $dbh, $data;
