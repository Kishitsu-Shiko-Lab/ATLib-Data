#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 10;

use ATLib::Std::String;

my $class = q{ATLib::Data::Table};

#1
use_ok($class);

#2
my $default = $class->create();
isa_ok($default, $class);

#3
is($default->table_name, 'Table1');

#4
my $table = $class->create('Table2');
is($table->table_name, 'Table2');

#5
my $instance = $class->create('Table');
is($instance->table_name, 'Table');

#6
isa_ok($instance->columns, q{ATLib::Data::Columns});

#7
isa_ok($instance->rows, q{ATLib::Data::Rows});

#8
$instance->table_name('Table3');
is($instance->table_name, 'Table3');

#9
$instance->table_name(ATLib::Std::String->from('Table4'));
is($instance->table_name, 'Table4');

#10
my $row = $instance->create_new_row();
isa_ok($row, q{ATLib::Data::Row});

done_testing();
__END__