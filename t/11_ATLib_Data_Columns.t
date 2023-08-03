#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 24;

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
is($instance->type_name, $class);

#4
is($instance->count, 0);

#5
my $column1_name = q{Column1};
my $column1 = ATLib::Data::Column->create($column1_name, q{ATLib::Std::Int});
$instance->add($column1);
is($instance->count, 1);

#6
my $column2_name = q{Column2};
my $column2 = ATLib::Data::Column->create($column2_name, q{ATLib::Std::String});
$instance->add($column2);
is($instance->count, 2);

#7
my $column = $instance->items(0);
isa_ok($column, q{ATLib::Data::Column});

#8
is($column->column_name->equals($column1_name), 1);

#9
$column = $instance->items(1);
is($column->column_name->equals($column2_name), 1);

#10
$column = $instance->items(ATLib::Std::Int->from(1));
is($column->column_name->equals($column2_name), 1);

#11
$column = $instance->items($column1_name);
is($column->column_name->equals($column1_name), 1);

#12
$column = $instance->items(ATLib::Std::String->from($column1_name));
is($column->column_name->equals($column1_name), 1);

#13
$instance = $instance->remove($instance->items(0));
isa_ok($instance, $class);

#14
is($instance->count, 1);

#15
$column = $instance->items(0);
is($column->column_name->equals($column2_name), 1);

#16
$instance = $instance->clear();
isa_ok($instance, $class);

#17
is($instance->count, 0);

#18
$instance = $instance->add($column1);
$instance = $instance->add($column2);
is($instance->count, 2);

#19
$instance = $instance->remove_at(0);
is($instance->count, 1);

#20
is($instance->items(0)->column_name, $column2_name);

#21
$instance = $instance->add($column1);
is($instance->count, 2);

#22
$instance = $instance->remove($column1_name);
is($instance->count, 1);

#23
is($instance->items(0)->column_name, $column2_name);

#24
$instance = $instance->remove($column2);
is($instance->count, 0);

done_testing();
__END__
