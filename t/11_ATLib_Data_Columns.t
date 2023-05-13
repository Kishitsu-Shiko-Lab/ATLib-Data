#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 23;

use ATLib::Std::Int;
use ATLib::Std::String;
use ATLib::Data::Column;
use ATLib::Data::Table;

my $class = q{ATLib::Data::Columns};

#1
use_ok($class);

#2
my $table = ATLib::Data::Table->create();
my $instance = $table->columns;
isa_ok($instance, $class);

#3
is($instance->count, 0);

#4
my $column1_name = q{Column1};
my $column1 = ATLib::Data::Column->create($column1_name, q{ATLib::Std::Int});
$instance->add($column1);
is($instance->count, 1);

#5
my $column2_name = q{Column2};
my $column2 = ATLib::Data::Column->create($column2_name, q{ATLib::Std::String});
$instance->add($column2);
is($instance->count, 2);

#6
my $column = $instance->items(0);
isa_ok($column, q{ATLib::Data::Column});

#7
is($column->column_name->equals($column1_name), 1);

#8
$column = $instance->items(1);
is($column->column_name->equals($column2_name), 1);

#9
$column = $instance->items(ATLib::Std::Int->from(1));
is($column->column_name->equals($column2_name), 1);

#10
$column = $instance->items($column1_name);
is($column->column_name->equals($column1_name), 1);

#11
$column = $instance->items(ATLib::Std::String->from($column1_name));
is($column->column_name->equals($column1_name), 1);

#12
$instance = $instance->remove($instance->items(0));
isa_ok($instance, $class);

#13
is($instance->count, 1);

#14
$column = $instance->items(0);
is($column->column_name->equals($column2_name), 1);

#15
$instance = $instance->clear();
isa_ok($instance, $class);

#16
is($instance->count, 0);

#17
$instance = $instance->add($column1);
$instance = $instance->add($column2);
is($instance->count, 2);

#18
$instance = $instance->remove_at(0);
is($instance->count, 1);

#19
is($instance->items(0)->column_name, $column2_name);

#20
$instance = $instance->add($column1);
is($instance->count, 2);

#21
$instance = $instance->remove($column1_name);
is($instance->count, 1);

#22
is($instance->items(0)->column_name, $column2_name);

#23
$instance = $instance->remove($column2);
is($instance->count, 0);

done_testing();
__END__
