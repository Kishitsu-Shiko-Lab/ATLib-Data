#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 11;

use ATLib::Std::String;

my $class = q{ATLib::Data::Table};

#1
use_ok($class);

#2
my $default = $class->create();
isa_ok($default, $class);

#3
is($default->type_name, $class);

#4
is($default->table_name, 'Table1');

#5
my $table = $class->create('Table2');
is($table->table_name, 'Table2');

#6
my $instance = $class->create('Table');
is($instance->table_name, 'Table');

#7
isa_ok($instance->columns, q{ATLib::Data::Columns});

#8
isa_ok($instance->rows, q{ATLib::Data::Rows});

#9
$instance->table_name('Table3');
is($instance->table_name, 'Table3');

#10
$instance->table_name(ATLib::Std::String->from('Table4'));
is($instance->table_name, 'Table4');

#11
my $row = $instance->create_new_row();
isa_ok($row, q{ATLib::Data::Row});

done_testing();
__END__